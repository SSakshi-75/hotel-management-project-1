using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Bookings : Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBookingMetrics();
            BindBookings();
        }
    }

    private void LoadBookingMetrics()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = @"
                    SELECT 
                        COUNT(*) AS TotalBookings,
                        SUM(CASE WHEN BookingStatus = 'Confirmed' THEN 1 ELSE 0 END) AS ConfirmedCount,
                        SUM(CASE WHEN BookingStatus = 'Checked-In' THEN 1 ELSE 0 END) AS InHouseCount,
                        SUM(CASE WHEN BookingStatus = 'Completed' THEN 1 ELSE 0 END) AS CompletedCount,
                        SUM(CASE WHEN BookingStatus != 'Cancelled' THEN ISNULL(TotalAmount, 0) ELSE 0 END) AS TotalRevenue
                    FROM Bookings";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            lblTotalBookings.Text = rdr["TotalBookings"] != DBNull.Value ? rdr["TotalBookings"].ToString() : "0";
                            lblConfirmedBookings.Text = rdr["ConfirmedCount"] != DBNull.Value ? rdr["ConfirmedCount"].ToString() : "0";
                            lblInHouseGuests.Text = rdr["InHouseCount"] != DBNull.Value ? rdr["InHouseCount"].ToString() : "0";
                            lblCompletedBookings.Text = rdr["CompletedCount"] != DBNull.Value ? rdr["CompletedCount"].ToString() : "0";

                            decimal rev = 0;
                            if (rdr["TotalRevenue"] != DBNull.Value)
                            {
                                decimal.TryParse(rdr["TotalRevenue"].ToString(), out rev);
                            }
                            lblTotalRevenue.Text = "₹ " + string.Format("{0:N0}", rev);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error loading booking statistics: " + ex.Message, "danger");
        }
    }

    private void BindBookings()
    {
        try
        {
            string searchTerm = txtBookingSearch.Text.Trim();
            string statusFilter = ddlBookingStatus.SelectedValue;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string sql = @"
                    SELECT 
                        b.BookingId,
                        b.BookingReference,
                        b.GuestName,
                        b.GuestEmail,
                        b.GuestPhone,
                        b.RoomId,
                        ISNULL(r.RoomName, 'Suite #' + CAST(b.RoomId AS VARCHAR(10))) AS RoomName,
                        ISNULL(r.RoomCategory, 'Luxury Room') AS RoomCategory,
                        b.CheckInDate,
                        b.CheckOutDate,
                        DATEDIFF(day, b.CheckInDate, b.CheckOutDate) AS NightsCount,
                        b.Adults,
                        b.Children,
                        b.TotalRooms,
                        b.RatePerNight,
                        b.TotalAmount,
                        b.BookingStatus,
                        b.SpecialRequests,
                        b.BookingDate
                    FROM Bookings b
                    LEFT JOIN Rooms r ON b.RoomId = r.RoomID
                    WHERE 1 = 1";

                if (!string.IsNullOrEmpty(statusFilter))
                {
                    sql += " AND b.BookingStatus = @StatusFilter";
                }

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    sql += @" AND (
                        b.BookingReference LIKE @Search OR 
                        b.GuestName LIKE @Search OR 
                        b.GuestEmail LIKE @Search OR 
                        b.GuestPhone LIKE @Search OR
                        r.RoomName LIKE @Search
                    )";
                }

                sql += " ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (!string.IsNullOrEmpty(statusFilter))
                    {
                        cmd.Parameters.AddWithValue("@StatusFilter", statusFilter);
                    }
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptBookings.DataSource = dt;
                            rptBookings.DataBind();
                            rptBookings.Visible = true;
                            pnlNoBookings.Visible = false;
                        }
                        else
                        {
                            rptBookings.Visible = false;
                            pnlNoBookings.Visible = true;
                        }

                        lblRecordCount.Text = dt.Rows.Count.ToString() + " Reservation(s) Found";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error loading bookings ledger: " + ex.Message, "danger");
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindBookings();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtBookingSearch.Text = "";
        ddlBookingStatus.SelectedIndex = 0;
        LoadBookingMetrics();
        BindBookings();
    }

    protected void rptBookings_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int bookingId;
        if (!int.TryParse(e.CommandArgument != null ? e.CommandArgument.ToString() : "", out bookingId))
        {
            return;
        }

        if (e.CommandName == "CheckIn")
        {
            ExecuteCheckIn(bookingId);
        }
        else if (e.CommandName == "CheckOut")
        {
            ExecuteCheckOut(bookingId);
        }
        else if (e.CommandName == "CancelBooking")
        {
            ExecuteCancelBooking(bookingId);
        }
    }

    private void ExecuteCheckIn(int bookingId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Update Booking status to 'Checked-In'
                // 2. Update Room status to 'Occupied'
                string sql = @"
                    UPDATE Bookings 
                    SET BookingStatus = 'Checked-In' 
                    WHERE BookingId = @BookingId;

                    UPDATE Rooms 
                    SET RoomStatus = 'Occupied' 
                    WHERE RoomID = (SELECT RoomId FROM Bookings WHERE BookingId = @BookingId);";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingId", bookingId);
                    cmd.ExecuteNonQuery();
                }
            }

            ShowAlert(string.Format("Booking #{0} successfully Checked-In. Room has been marked as 'Occupied'.", bookingId), "success");
            LoadBookingMetrics();
            BindBookings();
        }
        catch (Exception ex)
        {
            ShowAlert("Check-in error: " + ex.Message, "danger");
        }
    }

    private void ExecuteCheckOut(int bookingId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Update Booking status to 'Completed'
                // 2. Update Room status to 'Cleaning' for housekeeping
                string sql = @"
                    UPDATE Bookings 
                    SET BookingStatus = 'Completed' 
                    WHERE BookingId = @BookingId;

                    UPDATE Rooms 
                    SET RoomStatus = 'Cleaning' 
                    WHERE RoomID = (SELECT RoomId FROM Bookings WHERE BookingId = @BookingId);";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingId", bookingId);
                    cmd.ExecuteNonQuery();
                }
            }

            ShowAlert(string.Format("Booking #{0} successfully Checked-Out. Room status set to 'Cleaning' for Housekeeping.", bookingId), "success");
            LoadBookingMetrics();
            BindBookings();
        }
        catch (Exception ex)
        {
            ShowAlert("Check-out error: " + ex.Message, "danger");
        }
    }

    private void ExecuteCancelBooking(int bookingId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Update Booking status to 'Cancelled'
                // 2. If room was Occupied by this booking, reset room to 'Available'
                string sql = @"
                    UPDATE Bookings 
                    SET BookingStatus = 'Cancelled' 
                    WHERE BookingId = @BookingId;

                    UPDATE Rooms 
                    SET RoomStatus = 'Available' 
                    WHERE RoomID = (SELECT RoomId FROM Bookings WHERE BookingId = @BookingId)
                      AND RoomStatus = 'Occupied';";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingId", bookingId);
                    cmd.ExecuteNonQuery();
                }
            }

            ShowAlert(string.Format("Booking #{0} has been Cancelled. Reserved dates are now released and available for booking.", bookingId), "info");
            LoadBookingMetrics();
            BindBookings();
        }
        catch (Exception ex)
        {
            ShowAlert("Cancellation error: " + ex.Message, "danger");
        }
    }

    public string GetStatusBadgeHtml(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "Confirmed";
        switch (status.ToLower())
        {
            case "confirmed":
                return "<span class=\"badge badge-status-confirmed px-3 py-1.5 rounded-pill font-monospace small\">🟢 CONFIRMED</span>";
            case "checked-in":
                return "<span class=\"badge badge-status-checkedin px-3 py-1.5 rounded-pill font-monospace small\">🔵 IN-HOUSE</span>";
            case "completed":
                return "<span class=\"badge badge-status-completed px-3 py-1.5 rounded-pill font-monospace small\">🟣 COMPLETED</span>";
            case "cancelled":
                return "<span class=\"badge badge-status-cancelled px-3 py-1.5 rounded-pill font-monospace small\">🔴 CANCELLED</span>";
            default:
                return "<span class=\"badge bg-secondary px-3 py-1.5 rounded-pill font-monospace small\">" + status.ToUpper() + "</span>";
        }
    }

    private void ShowAlert(string message, string type)
    {
        pnlAlert.Visible = true;
        pnlAlert.CssClass = "alert alert-" + type + " alert-dismissible fade show d-flex align-items-center mb-4";
        lblAlertText.Text = message;
    }
}
