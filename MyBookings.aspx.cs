using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class MyBookings : Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            Response.Redirect("Login.aspx?msg=login_required");
            return;
        }

        if (!IsPostBack)
        {
            LoadUserBookings();
        }
    }

    private void LoadUserBookings()
    {
        int userId = Convert.ToInt32(Session["UserId"]);

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string sql = @"
                SELECT 
                    b.BookingReference, 
                    r.RoomName, 
                    b.CheckInDate, 
                    b.CheckOutDate, 
                    b.TotalAmount, 
                    b.BookingStatus
                FROM Bookings b
                JOIN Rooms r ON b.RoomId = r.RoomID
                WHERE b.UserId = @UserId
                ORDER BY b.BookingDate DESC";

            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        rptBookings.DataSource = dt;
                        rptBookings.DataBind();
                        rptBookings.Visible = true;
                    }
                    else
                    {
                        rptBookings.Visible = false;
                    }
                }
            }

            // Ensure TableReservations schema is up to date (UserId column might be missing)
            string schemaSql = @"
                IF EXISTS (SELECT * FROM sysobjects WHERE name='TableReservations' AND xtype='U')
                BEGIN
                    IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('TableReservations') AND name = 'UserId')
                    BEGIN
                        ALTER TABLE TableReservations ADD UserId INT NULL;
                    END
                END";

            using (SqlCommand cmdSchema = new SqlCommand(schemaSql, con))
            {
                try { cmdSchema.ExecuteNonQuery(); } catch { }
            }

            string tableSql = @"
                IF EXISTS (SELECT * FROM sysobjects WHERE name='TableReservations' AND xtype='U')
                BEGIN
                    SELECT 
                        BookingCode,
                        TableNumber,
                        ReservationDate,
                        TimeSlot,
                        GuestCount,
                        Status
                    FROM TableReservations
                    WHERE UserId = @UserId
                    ORDER BY CreatedDate DESC
                END";

            using (SqlCommand cmdTable = new SqlCommand(tableSql, con))
            {
                cmdTable.Parameters.AddWithValue("@UserId", userId);

                using (SqlDataAdapter daTable = new SqlDataAdapter(cmdTable))
                {
                    DataTable dtTable = new DataTable();
                    try {
                        daTable.Fill(dtTable);
                    } catch { }

                    if (dtTable.Rows.Count > 0)
                    {
                        rptTableBookings.DataSource = dtTable;
                        rptTableBookings.DataBind();
                        rptTableBookings.Visible = true;
                    }
                    else
                    {
                        rptTableBookings.Visible = false;
                    }
                }
            }
            
            pnlNoBookings.Visible = !rptBookings.Visible && !rptTableBookings.Visible;
        }
    }

    protected string GetStatusBadge(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "";
        switch (status.ToLower())
        {
            case "pending": return "<span class='badge bg-warning text-dark'>Pending</span>";
            case "confirmed": return "<span class='badge bg-success'>Confirmed</span>";
            case "checked-in": return "<span class='badge bg-primary'>Checked-In</span>";
            case "completed": return "<span class='badge bg-info text-dark'>Completed</span>";
            case "cancelled": return "<span class='badge bg-danger'>Cancelled</span>";
            default: return "<span class='badge bg-secondary'>" + status + "</span>";
        }
    }
}
