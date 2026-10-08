using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.SignalR;

public partial class TableReservation : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Enforce login/registration before booking a table
        bool isCustomerLoggedIn = Session["UserId"] != null &&
                                  Session["AdminId"] == null &&
                                  (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"]);

        if (!isCustomerLoggedIn)
        {
            string rawUrl = Request.RawUrl ?? "TableReservation.aspx";
            Response.Redirect("Login.aspx?msg=table&returnUrl=" + Server.UrlEncode(rawUrl));
            return;
        }

        if (!IsPostBack)
        {
            if (txtResDate != null && string.IsNullOrEmpty(txtResDate.Value))
            {
                txtResDate.Value = DateTime.Today.ToString("yyyy-MM-dd");
            }
            if (txtCustName != null) txtCustName.Value = "";
            if (txtCustPhone != null) txtCustPhone.Value = "";
            if (txtCustEmail != null) txtCustEmail.Value = "";
            if (txtSpecialRequest != null) txtSpecialRequest.Value = "";
            LoadAvailableTables();
        }
    }

    private void LoadAvailableTables()
    {
        DataTable dt = new DataTable();
        if (!string.IsNullOrEmpty(connectionString))
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    // Ensure RestaurantTables table exists
                    string createTableSql = @"
                        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RestaurantTables' AND xtype='U')
                        BEGIN
                            CREATE TABLE RestaurantTables (
                                TableId INT IDENTITY(1,1) PRIMARY KEY,
                                TableNumber NVARCHAR(50) NOT NULL UNIQUE,
                                TableName NVARCHAR(100) NOT NULL,
                                Capacity INT NOT NULL DEFAULT 2,
                                Section NVARCHAR(100) NULL,
                                Location NVARCHAR(100) NULL,
                                Floor NVARCHAR(50) NULL DEFAULT 'Ground Floor',
                                TableStatus NVARCHAR(50) NOT NULL DEFAULT 'Available',
                                IsActive BIT NOT NULL DEFAULT 1,
                                CreatedDate DATETIME DEFAULT GETDATE()
                            );
                        END";

                    using (SqlCommand cmdInit = new SqlCommand(createTableSql, con))
                    {
                        cmdInit.ExecuteNonQuery();
                    }

                    // Selected reservation date
                    DateTime selectedDate = DateTime.Today;
                    if (txtResDate != null && !string.IsNullOrEmpty(txtResDate.Value))
                    {
                        DateTime.TryParse(txtResDate.Value, out selectedDate);
                    }

                    // Select tables with live TableStatus or active TableReservations for selected date
                    string query = @"
                        SELECT 
                            T.TableId, 
                            T.TableNumber, 
                            T.TableName, 
                            T.Capacity, 
                            T.Section, 
                            T.Location, 
                            T.Floor,
                            CASE 
                                WHEN T.TableStatus IN ('Blocked', 'Maintenance') THEN T.TableStatus
                                WHEN T.TableStatus IN ('Booked', 'Occupied') THEN 'Booked'
                                WHEN EXISTS (
                                    SELECT 1 
                                    FROM TableReservations TR 
                                    WHERE TR.TableNumber = T.TableNumber 
                                      AND CAST(TR.ReservationDate AS DATE) = @SelectedDate
                                      AND TR.Status IN ('Pending', 'Confirmed', 'Seated')
                                ) THEN 'Booked'
                                ELSE ISNULL(T.TableStatus, 'Available')
                            END AS TableStatus,
                            T.IsActive
                        FROM RestaurantTables T
                        WHERE T.IsActive = 1
                        ORDER BY T.TableNumber ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@SelectedDate", selectedDate.Date);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Non-blocking fallback
            }
        }

        if (dt.Rows.Count > 0)
        {
            rptAvailableTables.DataSource = dt;
            rptAvailableTables.DataBind();
            pnlNoTablesAvailable.Visible = false;

            int availableCount = 0;
            foreach (DataRow row in dt.Rows)
            {
                if (string.Equals(row["TableStatus"] != null ? row["TableStatus"].ToString() : "", "Available", StringComparison.OrdinalIgnoreCase))
                {
                    availableCount++;
                }
            }
            litTableCount.Text = availableCount + (availableCount == 1 ? " Table Available" : " Tables Available");
        }
        else
        {
            rptAvailableTables.DataSource = null;
            rptAvailableTables.DataBind();
            pnlNoTablesAvailable.Visible = true;
            litTableCount.Text = "0 Tables Available";
        }
    }

    // ==========================================
    // REPEATER HELPER METHODS FOR CLEAN ASPX
    // ==========================================
    public string GetTableStatusBadge(object tableStatusObj)
    {
        string status = tableStatusObj != null ? tableStatusObj.ToString().Trim() : "";
        if (string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-available\"><i class=\"bi bi-check-circle-fill me-1\"></i> Available</span>";
        }
        else if (string.Equals(status, "Booked", StringComparison.OrdinalIgnoreCase) ||
                 string.Equals(status, "Occupied", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-booked\"><i class=\"bi bi-x-circle-fill text-danger me-1\"></i> Booked</span>";
        }
        else if (string.Equals(status, "Reserved", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-reserved\"><i class=\"bi bi-clock-fill me-1\"></i> Reserved</span>";
        }
        else if (string.Equals(status, "Blocked", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-blocked\"><i class=\"bi bi-slash-circle me-1\"></i> Blocked</span>";
        }
        return "<span class=\"badge bg-secondary\">" + HttpUtility.HtmlEncode(status) + "</span>";
    }

    public string GetTableCardClass(object tableStatusObj)
    {
        string status = tableStatusObj != null ? tableStatusObj.ToString() : "";
        if (!string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase))
        {
            return "table-card-select table-card-disabled";
        }
        return "table-card-select";
    }

    public string GetFloorDisplay(object floorObj)
    {
        if (floorObj != null && floorObj != DBNull.Value && !string.IsNullOrWhiteSpace(floorObj.ToString()))
        {
            return " &bull; " + floorObj.ToString();
        }
        return "";
    }

    // ==========================================
    // CONFIRM RESERVATION CLICK HANDLER
    // ==========================================
    protected void btnConfirmReservation_Click(object sender, EventArgs e)
    {
        bool isCustomerLoggedIn = Session["UserId"] != null &&
                                  Session["AdminId"] == null &&
                                  (Session["IsAdmin"] == null || !(bool)Session["IsAdmin"]);

        if (!isCustomerLoggedIn)
        {
            Response.Redirect("Login.aspx?msg=table&returnUrl=TableReservation.aspx");
            return;
        }

        string tableNum = hdnSelectedTableNum != null && !string.IsNullOrEmpty(hdnSelectedTableNum.Value)
            ? hdnSelectedTableNum.Value.Trim()
            : (Request.Form["hdnSelectedTableNum"] ?? "").Trim();

        string custName = txtCustName != null && !string.IsNullOrEmpty(txtCustName.Value)
            ? txtCustName.Value.Trim()
            : (Request.Form["txtCustName"] ?? "").Trim();

        string custPhone = txtCustPhone != null && !string.IsNullOrEmpty(txtCustPhone.Value)
            ? txtCustPhone.Value.Trim()
            : (Request.Form["txtCustPhone"] ?? "").Trim();

        string custEmail = txtCustEmail != null && !string.IsNullOrEmpty(txtCustEmail.Value)
            ? txtCustEmail.Value.Trim()
            : (Request.Form["txtCustEmail"] ?? "").Trim();

        string resDateStr = txtResDate != null && !string.IsNullOrEmpty(txtResDate.Value)
            ? txtResDate.Value.Trim()
            : (Request.Form["txtResDate"] ?? "").Trim();

        string timeSlot = ddlTimeSlot != null && !string.IsNullOrEmpty(ddlTimeSlot.Value)
            ? ddlTimeSlot.Value.Trim()
            : (Request.Form["ddlTimeSlot"] ?? "").Trim();

        string guestsStr = ddlGuestCount != null && !string.IsNullOrEmpty(ddlGuestCount.Value)
            ? ddlGuestCount.Value.Trim()
            : (Request.Form["ddlGuestCount"] ?? "").Trim();

        string specialRequest = txtSpecialRequest != null && !string.IsNullOrEmpty(txtSpecialRequest.Value)
            ? txtSpecialRequest.Value.Trim()
            : (Request.Form["txtSpecialRequest"] ?? "").Trim();

        if (string.IsNullOrEmpty(tableNum))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "TableReqAlert", "alert('Please select an available table from Step 2.');", true);
            return;
        }

        if (string.IsNullOrEmpty(custName) || string.IsNullOrEmpty(custPhone))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "CustReqAlert", "alert('Please fill in your Full Name and Mobile Number.');", true);
            return;
        }

        DateTime resDate = DateTime.Today;
        if (!string.IsNullOrEmpty(resDateStr))
        {
            DateTime.TryParse(resDateStr, out resDate);
        }

        int guestCount = 2;
        int.TryParse(guestsStr, out guestCount);
        if (guestCount <= 0) guestCount = 2;

        if (string.IsNullOrEmpty(timeSlot)) timeSlot = "07:00 PM";

        string dateCode = resDate.ToString("yyyyMMdd");
        int randNum = new Random().Next(1000, 9999);
        string bookingCode = "TAB-" + dateCode + "-" + randNum;
        
        int? userId = null;
        if (Session["UserId"] != null)
        {
            userId = Convert.ToInt32(Session["UserId"]);
        }

        // Prevent double-booking: verify table availability in database
        if (!IsTableAvailableForReservation(tableNum, resDate))
        {
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "TableAlreadyBookedAlert",
                "alert('Table " + Server.HtmlEncode(tableNum) + " is already Booked for the selected date. Please choose another table.');",
                true
            );
            LoadAvailableTables();
            return;
        }

        bool saved = SaveReservationToDatabase(bookingCode, custName, custPhone, custEmail, resDate, timeSlot, guestCount, tableNum, specialRequest, userId);

        if (saved)
        {
            litVouchCode.Text = bookingCode;
            litVouchDateTime.Text = resDate.ToString("dd MMM yyyy") + " @ " + timeSlot;
            litVouchTableGuests.Text = "Table " + tableNum + " (" + guestCount + " Guests)";
            litVouchGuestName.Text = custName + " (" + custPhone + ")";

            // Send real-time notification to all connected admin panels
            NotificationHub.Broadcast(
                "New table reservation: " + bookingCode +
                " | Guest: " + custName +
                " | Table: " + tableNum + " for " + guestCount + " guests"
            );

            LoadAvailableTables();
            pnlReservationForm.Visible = false;
            pnlConfirmationVoucher.Visible = true;

            ClientScript.RegisterStartupScript(this.GetType(), "ScrollToVouch", "window.scrollTo({ top: 200, behavior: 'smooth' });", true);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "SaveFailAlert", "alert('Unable to save reservation at this moment. Please check database connection.');", true);
        }
    }

    private bool SaveReservationToDatabase(string bookingCode, string custName, string custPhone, string custEmail, DateTime resDate, string timeSlot, int guestCount, string tableNum, string specialRequest, int? userId)
    {
        if (string.IsNullOrEmpty(connectionString)) return false;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Ensure TableReservations table exists
                string ensureSql = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TableReservations' AND xtype='U')
                    BEGIN
                        CREATE TABLE TableReservations (
                            ReservationId INT IDENTITY(1,1) PRIMARY KEY,
                            BookingCode NVARCHAR(50) NOT NULL UNIQUE,
                            CustomerName NVARCHAR(100) NOT NULL,
                            CustomerPhone NVARCHAR(50) NOT NULL,
                            CustomerEmail NVARCHAR(100) NULL,
                            ReservationDate DATE NOT NULL,
                            TimeSlot NVARCHAR(50) NOT NULL,
                            GuestCount INT NOT NULL DEFAULT 2,
                            TableNumber NVARCHAR(50) NULL,
                            SpecialRequest NVARCHAR(500) NULL,
                            Status NVARCHAR(50) NOT NULL DEFAULT 'Pending',
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            UserId INT NULL
                        );
                    END
                    ELSE
                    BEGIN
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('TableReservations') AND name = 'UserId')
                        BEGIN
                            ALTER TABLE TableReservations ADD UserId INT NULL;
                        END
                    END";

                using (SqlCommand cmdEnsure = new SqlCommand(ensureSql, con))
                {
                    cmdEnsure.ExecuteNonQuery();
                }

                // Insert new table reservation and update table status to 'Booked'
                string insertSql = @"
                    INSERT INTO TableReservations (
                        BookingCode, CustomerName, CustomerPhone, CustomerEmail,
                        ReservationDate, TimeSlot, GuestCount, TableNumber,
                        SpecialRequest, Status, CreatedDate, UserId
                    )
                    VALUES (
                        @BookingCode, @CustomerName, @CustomerPhone, @CustomerEmail,
                        @ReservationDate, @TimeSlot, @GuestCount, @TableNumber,
                        @SpecialRequest, 'Pending', GETDATE(), @UserId
                    );

                    -- Update RestaurantTables live status to 'Booked'
                    UPDATE RestaurantTables 
                    SET TableStatus = 'Booked' 
                    WHERE TableNumber = @TableNumber;";

                using (SqlCommand cmd = new SqlCommand(insertSql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingCode", bookingCode);
                    cmd.Parameters.AddWithValue("@CustomerName", custName);
                    cmd.Parameters.AddWithValue("@CustomerPhone", custPhone);
                    cmd.Parameters.AddWithValue("@CustomerEmail", string.IsNullOrEmpty(custEmail) ? (object)DBNull.Value : custEmail);
                    cmd.Parameters.AddWithValue("@ReservationDate", resDate.Date);
                    cmd.Parameters.AddWithValue("@TimeSlot", timeSlot);
                    cmd.Parameters.AddWithValue("@GuestCount", guestCount);
                    cmd.Parameters.AddWithValue("@TableNumber", tableNum);
                    cmd.Parameters.AddWithValue("@SpecialRequest", string.IsNullOrEmpty(specialRequest) ? (object)DBNull.Value : specialRequest);
                    cmd.Parameters.AddWithValue("@UserId", userId.HasValue ? (object)userId.Value : DBNull.Value);

                    cmd.ExecuteNonQuery();
                }

                return true;
            }
        }
        catch (Exception)
        {
            return false;
        }
    }

    // ==========================================
    // HELPER: VERIFY TABLE AVAILABILITY BEFORE RESERVING
    // ==========================================
    private bool IsTableAvailableForReservation(string tableNumber, DateTime resDate)
    {
        if (string.IsNullOrEmpty(connectionString) || string.IsNullOrEmpty(tableNumber)) return false;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Check table status in RestaurantTables
                string checkSql = @"
                    SELECT TableStatus, IsActive 
                    FROM RestaurantTables 
                    WHERE TableNumber = @TableNumber";

                using (SqlCommand cmd = new SqlCommand(checkSql, con))
                {
                    cmd.Parameters.AddWithValue("@TableNumber", tableNumber);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                            string status = dr["TableStatus"] != DBNull.Value ? dr["TableStatus"].ToString().Trim() : "Available";

                            if (!isActive || 
                                status.Equals("Blocked", StringComparison.OrdinalIgnoreCase) || 
                                status.Equals("Maintenance", StringComparison.OrdinalIgnoreCase) ||
                                status.Equals("Booked", StringComparison.OrdinalIgnoreCase) ||
                                status.Equals("Occupied", StringComparison.OrdinalIgnoreCase))
                            {
                                return false;
                            }
                        }
                        else
                        {
                            return false;
                        }
                    }
                }

                // 2. Check active reservations for this table on this date
                string checkResSql = @"
                    IF EXISTS (SELECT * FROM sysobjects WHERE name='TableReservations' AND xtype='U')
                    BEGIN
                        SELECT COUNT(*) 
                        FROM TableReservations 
                        WHERE TableNumber = @TableNumber 
                          AND CAST(ReservationDate AS DATE) = @ResDate 
                          AND Status IN ('Pending', 'Confirmed', 'Seated');
                    END
                    ELSE
                    BEGIN
                        SELECT 0;
                    END";

                using (SqlCommand cmdRes = new SqlCommand(checkResSql, con))
                {
                    cmdRes.Parameters.AddWithValue("@TableNumber", tableNumber);
                    cmdRes.Parameters.AddWithValue("@ResDate", resDate.Date);
                    int activeResCount = Convert.ToInt32(cmdRes.ExecuteScalar());
                    if (activeResCount > 0)
                    {
                        return false;
                    }
                }
            }

            return true;
        }
        catch
        {
            return false;
        }
    }
}
