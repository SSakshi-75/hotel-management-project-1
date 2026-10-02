using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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

                    // Only select active tables added by admin
                    string query = @"
                        SELECT TableId, TableNumber, TableName, Capacity, Section, Location, Floor, TableStatus, IsActive
                        FROM RestaurantTables
                        WHERE IsActive = 1
                        ORDER BY TableNumber ASC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
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
        string status = tableStatusObj != null ? tableStatusObj.ToString() : "";
        if (string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-available\">Available</span>";
        }
        else if (string.Equals(status, "Reserved", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-reserved\">Reserved</span>";
        }
        else if (string.Equals(status, "Blocked", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"status-pill-blocked\">Blocked</span>";
        }
        return "<span class=\"badge bg-secondary\">" + status + "</span>";
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

        bool saved = SaveReservationToDatabase(bookingCode, custName, custPhone, custEmail, resDate, timeSlot, guestCount, tableNum, specialRequest);

        if (saved)
        {
            litVouchCode.Text = bookingCode;
            litVouchDateTime.Text = resDate.ToString("dd MMM yyyy") + " @ " + timeSlot;
            litVouchTableGuests.Text = "Table " + tableNum + " (" + guestCount + " Guests)";
            litVouchGuestName.Text = custName + " (" + custPhone + ")";

            pnlReservationForm.Visible = false;
            pnlConfirmationVoucher.Visible = true;

            ClientScript.RegisterStartupScript(this.GetType(), "ScrollToVouch", "window.scrollTo({ top: 200, behavior: 'smooth' });", true);
        }
        else
        {
            ClientScript.RegisterStartupScript(this.GetType(), "SaveFailAlert", "alert('Unable to save reservation at this moment. Please check database connection.');", true);
        }
    }

    private bool SaveReservationToDatabase(string bookingCode, string custName, string custPhone, string custEmail, DateTime resDate, string timeSlot, int guestCount, string tableNum, string specialRequest)
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
                            CreatedDate DATETIME DEFAULT GETDATE()
                        );
                    END";

                using (SqlCommand cmdEnsure = new SqlCommand(ensureSql, con))
                {
                    cmdEnsure.ExecuteNonQuery();
                }

                // Insert new table reservation
                string insertSql = @"
                    INSERT INTO TableReservations (
                        BookingCode, CustomerName, CustomerPhone, CustomerEmail,
                        ReservationDate, TimeSlot, GuestCount, TableNumber,
                        SpecialRequest, Status, CreatedDate
                    )
                    VALUES (
                        @BookingCode, @CustomerName, @CustomerPhone, @CustomerEmail,
                        @ReservationDate, @TimeSlot, @GuestCount, @TableNumber,
                        @SpecialRequest, 'Pending', GETDATE()
                    )";

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
}
