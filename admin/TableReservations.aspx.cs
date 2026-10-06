using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_TableReservations : System.Web.UI.Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            EnsureTableExists();
            LoadReservations();
        }
    }

    // ==========================================
    // ENSURE TABLE EXISTS IN DATABASE
    // ==========================================
    private void EnsureTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string script = @"
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
                    END;";

                using (SqlCommand cmd = new SqlCommand(script, con))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            // Non-blocking fallback
        }
    }

    // ==========================================
    // LOAD RESERVATIONS AND CALCULATE KPIS
    // ==========================================
    private void LoadReservations()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("ReservationId", typeof(int));
        dt.Columns.Add("BookingCode", typeof(string));
        dt.Columns.Add("CustomerName", typeof(string));
        dt.Columns.Add("CustomerPhone", typeof(string));
        dt.Columns.Add("CustomerEmail", typeof(string));
        dt.Columns.Add("ReservationDate", typeof(DateTime));
        dt.Columns.Add("TimeSlot", typeof(string));
        dt.Columns.Add("GuestCount", typeof(int));
        dt.Columns.Add("TableNumber", typeof(string));
        dt.Columns.Add("Status", typeof(string));

        int totalCount = 0;
        int pendingCount = 0;
        int confirmedCount = 0;
        int seatedCount = 0;
        int completedCount = 0;
        int cancelledCount = 0;

        if (!string.IsNullOrEmpty(connectionString))
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = @"
                        SELECT ReservationId, BookingCode, CustomerName, CustomerPhone, CustomerEmail, 
                               ReservationDate, TimeSlot, GuestCount, TableNumber, Status
                        FROM TableReservations
                        ORDER BY ReservationDate DESC, ReservationId DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                int id = Convert.ToInt32(dr["ReservationId"]);
                                string code = dr["BookingCode"] != DBNull.Value ? dr["BookingCode"].ToString() : "";
                                string name = dr["CustomerName"] != DBNull.Value ? dr["CustomerName"].ToString() : "";
                                string phone = dr["CustomerPhone"] != DBNull.Value ? dr["CustomerPhone"].ToString() : "";
                                string email = dr["CustomerEmail"] != DBNull.Value ? dr["CustomerEmail"].ToString() : "";
                                DateTime date = dr["ReservationDate"] != DBNull.Value ? Convert.ToDateTime(dr["ReservationDate"]) : DateTime.Today;
                                string time = dr["TimeSlot"] != DBNull.Value ? dr["TimeSlot"].ToString() : "";
                                int guests = dr["GuestCount"] != DBNull.Value ? Convert.ToInt32(dr["GuestCount"]) : 2;
                                string tableNum = dr["TableNumber"] != DBNull.Value ? dr["TableNumber"].ToString() : "T-01";
                                string status = dr["Status"] != DBNull.Value ? dr["Status"].ToString() : "Pending";

                                dt.Rows.Add(id, code, name, phone, email, date, time, guests, tableNum, status);

                                totalCount++;
                                string st = status.Trim().ToLower();
                                if (st == "pending") pendingCount++;
                                else if (st == "confirmed") confirmedCount++;
                                else if (st == "seated") seatedCount++;
                                else if (st == "completed") completedCount++;
                                else if (st == "cancelled") cancelledCount++;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Non-blocking fallback
            }
        }

        // Set KPI Counters
        lblTotalCount.Text = totalCount.ToString();
        lblPendingCount.Text = pendingCount.ToString();
        lblConfirmedCount.Text = confirmedCount.ToString();
        lblSeatedCount.Text = seatedCount.ToString();
        lblCompletedCount.Text = completedCount.ToString();
        lblCancelledCount.Text = cancelledCount.ToString();

        // Set Filter Pill Counts
        litFilterAll.Text = totalCount.ToString();
        litFilterPending.Text = pendingCount.ToString();
        litFilterConfirmed.Text = confirmedCount.ToString();
        litFilterSeated.Text = seatedCount.ToString();
        litFilterCompleted.Text = completedCount.ToString();
        litFilterCancelled.Text = cancelledCount.ToString();

        trNoReservations.Visible = (dt.Rows.Count == 0);

        rptReservations.DataSource = dt;
        rptReservations.DataBind();
    }

    // ==========================================
    // STATUS BADGE RENDERER HELPER FOR ASPX
    // ==========================================
    public string GetStatusBadge(string status)
    {
        string s = (status ?? "").Trim().ToLower();
        if (s == "pending")
            return "<span class=\"res-status-pending\"><i class=\"bi bi-clock-history me-1\"></i> Pending</span>";
        if (s == "confirmed")
            return "<span class=\"res-status-confirmed\"><i class=\"bi bi-check-circle me-1\"></i> Confirmed</span>";
        if (s == "seated")
            return "<span class=\"res-status-seated\"><i class=\"bi bi-person-check me-1\"></i> Seated</span>";
        if (s == "completed")
            return "<span class=\"res-status-completed\"><i class=\"bi bi-check2-all me-1\"></i> Completed</span>";
        if (s == "cancelled")
            return "<span class=\"res-status-cancelled\"><i class=\"bi bi-x-circle me-1\"></i> Cancelled</span>";

        return "<span class=\"badge bg-secondary\">" + (status ?? "") + "</span>";
    }

    // ==========================================
    // REPEATER COMMAND (STATUS UPDATES & DELETE)
    // ==========================================
    protected void rptReservations_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int resId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteRes")
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string query = @"
                        DECLARE @TNum NVARCHAR(50);
                        SELECT @TNum = TableNumber FROM TableReservations WHERE ReservationId = @ReservationId;

                        DELETE FROM TableReservations WHERE ReservationId = @ReservationId;

                        IF @TNum IS NOT NULL AND NOT EXISTS (
                            SELECT 1 FROM TableReservations 
                            WHERE TableNumber = @TNum AND Status IN ('Pending', 'Confirmed', 'Seated')
                        )
                        BEGIN
                            UPDATE RestaurantTables 
                            SET TableStatus = 'Available' 
                            WHERE TableNumber = @TNum AND TableStatus = 'Booked';
                        END";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ReservationId", resId);
                        cmd.ExecuteNonQuery();
                    }
                }

                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Updated successfully";

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "ResDeleted",
                    "showConfirmation('Updated successfully');",
                    true
                );

                LoadReservations();
            }
            catch (Exception ex)
            {
                pnlStatusMsg.Visible = true;
                lblStatusMessage.Text = "Error deleting reservation: " + ex.Message;
            }
        }
        else
        {
            string newStatus = "";
            if (e.CommandName == "ConfirmRes") newStatus = "Confirmed";
            else if (e.CommandName == "SeatRes") newStatus = "Seated";
            else if (e.CommandName == "CompleteRes") newStatus = "Completed";
            else if (e.CommandName == "CancelRes") newStatus = "Cancelled";

            if (!string.IsNullOrEmpty(newStatus))
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();
                        string query = @"
                            UPDATE TableReservations SET Status = @Status WHERE ReservationId = @ReservationId;

                            IF @Status IN ('Completed', 'Cancelled')
                            BEGIN
                                DECLARE @TableNum NVARCHAR(50);
                                SELECT @TableNum = TableNumber FROM TableReservations WHERE ReservationId = @ReservationId;

                                IF @TableNum IS NOT NULL AND NOT EXISTS (
                                    SELECT 1 FROM TableReservations 
                                    WHERE TableNumber = @TableNum 
                                      AND ReservationId != @ReservationId
                                      AND Status IN ('Pending', 'Confirmed', 'Seated')
                                )
                                BEGIN
                                    UPDATE RestaurantTables 
                                    SET TableStatus = 'Available' 
                                    WHERE TableNumber = @TableNum AND TableStatus = 'Booked';
                                END
                            END
                            ELSE IF @Status IN ('Confirmed', 'Seated', 'Pending')
                            BEGIN
                                UPDATE RestaurantTables 
                                SET TableStatus = 'Booked' 
                                WHERE TableNumber = (SELECT TableNumber FROM TableReservations WHERE ReservationId = @ReservationId)
                                  AND TableStatus = 'Available';
                            END";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Status", newStatus);
                            cmd.Parameters.AddWithValue("@ReservationId", resId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    pnlStatusMsg.Visible = true;
                    lblStatusMessage.Text = "Updated successfully";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "ResStatusUpdated",
                        "showConfirmation('Updated successfully');",
                        true
                    );

                    LoadReservations();
                }
                catch (Exception ex)
                {
                    pnlStatusMsg.Visible = true;
                    lblStatusMessage.Text = "Error updating status: " + ex.Message;
                }
            }
        }
    }
}
