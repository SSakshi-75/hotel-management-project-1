using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

public partial class Admin_Dashboard : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        SetDynamicHeader();

        string action = (Request["action"] ?? "").ToLowerInvariant();
        string idStr = Request["id"] ?? Request["bookingId"];
        int bookingId;
        if (!string.IsNullOrEmpty(action) && int.TryParse(idStr, out bookingId))
        {
            if (action == "checkin")
            {
                ExecuteCheckIn(bookingId);
                Response.Redirect("Dashboard.aspx", true);
                return;
            }
            else if (action == "checkout")
            {
                ExecuteCheckOut(bookingId);
                Response.Redirect("Dashboard.aspx", true);
                return;
            }
        }

        if (!IsPostBack)
        {
            LoadDashboardMetrics();
            LoadChartData();
            LoadArrivals();
            LoadDepartures();
            LoadRecentBookings();
            LoadDiningData();
            LoadRecentActivity();
        }
    }

    private void ExecuteCheckIn(int bookingId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
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
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    private void ExecuteCheckOut(int bookingId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
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
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    private void SetDynamicHeader()
    {
        try
        {
            int hour = DateTime.Now.Hour;
            string greeting = "Good Morning, Admin!";
            if (hour >= 5 && hour < 12)
            {
                greeting = "Good Morning, Admin!";
            }
            else if (hour >= 12 && hour < 17)
            {
                greeting = "Good Afternoon, Admin!";
            }
            else if (hour >= 17 && hour < 21)
            {
                greeting = "Good Evening, Admin!";
            }
            else
            {
                greeting = "Good Night, Admin!";
            }

            if (litGreeting != null)
            {
                litGreeting.Text = greeting;
            }

            if (litCurrentDate != null)
            {
                litCurrentDate.Text = DateTime.Now.ToString("dd MMM yyyy, dddd");
            }
        }
        catch
        {
            // fallback
        }
    }

    private void LoadDashboardMetrics()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                
                // 1. KPI Metrics
                string kpiSql = @"
                    DECLARE @Today DATE = CAST(GETDATE() AS DATE);
                    
                    -- Revenue Today
                    SELECT ISNULL(SUM(TotalAmount), 0) AS RevenueToday 
                    FROM Bookings WHERE CAST(BookingDate AS DATE) = @Today AND BookingStatus != 'Cancelled';
                    
                    -- Bookings Today
                    SELECT COUNT(CASE WHEN BookingStatus != 'Cancelled' THEN 1 END) AS TotalBookings,
                           SUM(CASE WHEN BookingStatus IN ('Confirmed', 'Checked-In', 'Completed') THEN 1 ELSE 0 END) AS ConfirmedBookings,
                           SUM(CASE WHEN BookingStatus = 'Pending' THEN 1 ELSE 0 END) AS PendingBookings
                    FROM Bookings WHERE CAST(BookingDate AS DATE) = @Today;
                    
                    -- Room Stats
                    SELECT COUNT(*) AS TotalRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Available' THEN 1 ELSE 0 END) AS AvailableRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Occupied' THEN 1 ELSE 0 END) AS OccupiedRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Cleaning' THEN 1 ELSE 0 END) AS CleaningRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Maintenance' THEN 1 ELSE 0 END) AS MaintenanceRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Blocked' THEN 1 ELSE 0 END) AS BlockedRooms
                    FROM Rooms;
                    
                    -- Check-ins Today
                    SELECT 
                        COUNT(CASE WHEN BookingStatus = 'Checked-In' OR (CAST(CheckInDate AS DATE) = @Today AND BookingStatus IN ('Confirmed', 'Pending')) THEN 1 END) AS TotalCheckins,
                        SUM(CASE WHEN BookingStatus = 'Checked-In' THEN 1 ELSE 0 END) AS CheckedInCount,
                        SUM(CASE WHEN BookingStatus IN ('Pending', 'Confirmed') AND CAST(CheckInDate AS DATE) <= @Today THEN 1 ELSE 0 END) AS PendingCheckins
                    FROM Bookings;
                    
                    -- Check-outs Today
                    SELECT 
                        COUNT(CASE WHEN CAST(CheckOutDate AS DATE) = @Today OR (BookingStatus = 'Checked-In' AND CAST(CheckOutDate AS DATE) <= @Today) THEN 1 END) AS TotalCheckouts,
                        SUM(CASE WHEN BookingStatus = 'Checked-In' AND CAST(CheckOutDate AS DATE) <= @Today THEN 1 ELSE 0 END) AS PendingCheckouts
                    FROM Bookings;
                    
                    -- Table Reservations Today
                    SELECT COUNT(*) AS TableResToday
                    FROM TableReservations WHERE CAST(ReservationDate AS DATE) = @Today;
                    
                    -- Table Stats
                    SELECT COUNT(*) AS TotalTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') = 'Available' THEN 1 ELSE 0 END) AS AvailableTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') IN ('Occupied', 'Booked') THEN 1 ELSE 0 END) AS OccupiedTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') = 'Reserved' THEN 1 ELSE 0 END) AS ReservedTables
                    FROM RestaurantTables WHERE ISNULL(IsActive, 1) = 1;
                ";

                using (SqlCommand cmd = new SqlCommand(kpiSql, con))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        // Revenue (Card removed from Dashboard UI)
                        if (rdr.Read())
                        {
                            // Card removed from dashboard
                        }
                        
                        // Bookings
                        if (rdr.NextResult() && rdr.Read())
                        {
                            lblTodayBookingsTotal.Text = rdr["TotalBookings"].ToString();
                            lblTodayBookingsConfirmed.Text = rdr["ConfirmedBookings"] != DBNull.Value ? rdr["ConfirmedBookings"].ToString() : "0";
                            lblTodayBookingsPending.Text = rdr["PendingBookings"] != DBNull.Value ? rdr["PendingBookings"].ToString() : "0";
                        }

                        // Room Stats
                        if (rdr.NextResult() && rdr.Read())
                        {
                            int totalR = Convert.ToInt32(rdr["TotalRooms"] != DBNull.Value ? rdr["TotalRooms"] : 0);
                            int occR = Convert.ToInt32(rdr["OccupiedRooms"] != DBNull.Value ? rdr["OccupiedRooms"] : 0);
                            
                            lblTotalRooms.Text = totalR.ToString();
                            lblOccupiedRooms.Text = occR.ToString();
                            
                            int occRate = totalR > 0 ? (int)Math.Round((double)occR * 100 / totalR) : 0;
                            lblOccupancyRate.Text = occRate.ToString();
                            
                            lblAvailableRooms.Text = rdr["AvailableRooms"] != DBNull.Value ? rdr["AvailableRooms"].ToString() : "0";
                            
                            // For Donut Chart
                            lblRoomAvailable.Text = lblAvailableRooms.Text;
                            lblRoomOccupied.Text = occR.ToString();
                            lblRoomCleaning.Text = rdr["CleaningRooms"] != DBNull.Value ? rdr["CleaningRooms"].ToString() : "0";
                            lblRoomMaintenance.Text = rdr["MaintenanceRooms"] != DBNull.Value ? rdr["MaintenanceRooms"].ToString() : "0";
                            lblRoomBlocked.Text = rdr["BlockedRooms"] != DBNull.Value ? rdr["BlockedRooms"].ToString() : "0";
                            
                            lblChartDonutCenter.Text = totalR.ToString();
                            hfDonutTotal.Value = totalR.ToString();
                            hfDonutData.Value = string.Format("[{0}, {1}, {2}, {3}, {4}]", lblRoomAvailable.Text, lblRoomOccupied.Text, lblRoomCleaning.Text, lblRoomMaintenance.Text, lblRoomBlocked.Text);
                        }
                        
                        // Check-ins
                        if (rdr.NextResult() && rdr.Read())
                        {
                            int checkedIn = Convert.ToInt32(rdr["CheckedInCount"] != DBNull.Value ? rdr["CheckedInCount"] : 0);
                            int pendingIn = Convert.ToInt32(rdr["PendingCheckins"] != DBNull.Value ? rdr["PendingCheckins"] : 0);
                            int totalCheckins = Convert.ToInt32(rdr["TotalCheckins"] != DBNull.Value ? rdr["TotalCheckins"] : 0);

                            lblCheckinsToday.Text = (checkedIn > 0 ? checkedIn : totalCheckins).ToString();
                            lblCheckinsPending.Text = pendingIn.ToString();
                        }
                        
                        // Check-outs
                        if (rdr.NextResult() && rdr.Read())
                        {
                            lblCheckoutsToday.Text = rdr["TotalCheckouts"] != DBNull.Value ? rdr["TotalCheckouts"].ToString() : "0";
                            lblCheckoutsPending.Text = rdr["PendingCheckouts"] != DBNull.Value ? rdr["PendingCheckouts"].ToString() : "0";
                        }
                        
                        // Table Reservations
                        if (rdr.NextResult() && rdr.Read())
                        {
                            lblTodayTableRes.Text = rdr["TableResToday"] != DBNull.Value ? rdr["TableResToday"].ToString() : "0";
                        }
                        
                        // Table Stats
                        if (rdr.NextResult() && rdr.Read())
                        {
                            lblTableAvailable.Text = rdr["AvailableTables"] != DBNull.Value ? rdr["AvailableTables"].ToString() : "0";
                            lblTableOccupied.Text = rdr["OccupiedTables"] != DBNull.Value ? rdr["OccupiedTables"].ToString() : "0";
                            lblTableReserved.Text = rdr["ReservedTables"] != DBNull.Value ? rdr["ReservedTables"].ToString() : "0";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    private void LoadChartData()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Last 7 days overview
                string sql = @"
                    WITH PastDays AS (
                        SELECT CAST(GETDATE() - 6 AS DATE) AS d
                        UNION ALL SELECT CAST(GETDATE() - 5 AS DATE)
                        UNION ALL SELECT CAST(GETDATE() - 4 AS DATE)
                        UNION ALL SELECT CAST(GETDATE() - 3 AS DATE)
                        UNION ALL SELECT CAST(GETDATE() - 2 AS DATE)
                        UNION ALL SELECT CAST(GETDATE() - 1 AS DATE)
                        UNION ALL SELECT CAST(GETDATE() AS DATE)
                    )
                    SELECT 
                        pd.d AS BookingDate,
                        COUNT(CASE WHEN b.BookingStatus != 'Cancelled' THEN b.BookingId END) AS TotalBookings,
                        SUM(CASE WHEN b.BookingStatus IN ('Confirmed', 'Checked-In', 'Completed') THEN 1 ELSE 0 END) AS ConfirmedBookings
                    FROM PastDays pd
                    LEFT JOIN Bookings b ON CAST(b.BookingDate AS DATE) = pd.d
                    GROUP BY pd.d
                    ORDER BY pd.d ASC";

                using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    string[] labels = new string[7];
                    int[] totals = new int[7];
                    int[] confirmed = new int[7];

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DateTime d = Convert.ToDateTime(dt.Rows[i]["BookingDate"]);
                        labels[i] = "'" + d.ToString("MMM d") + "'";
                        totals[i] = Convert.ToInt32(dt.Rows[i]["TotalBookings"]);
                        confirmed[i] = Convert.ToInt32(dt.Rows[i]["ConfirmedBookings"]);
                    }

                    hfChartLabels.Value = "[" + string.Join(",", labels) + "]";
                    hfChartTotalBookings.Value = "[" + string.Join(",", totals) + "]";
                    hfChartConfirmedBookings.Value = "[" + string.Join(",", confirmed) + "]";
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    private void LoadArrivals()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT TOP 10 
                        b.BookingId,
                        b.BookingReference, 
                        b.GuestName, 
                        ISNULL(r.RoomName, 'Room #' + CAST(b.RoomId AS VARCHAR(10))) AS RoomNo, 
                        b.CheckInDate, 
                        b.BookingStatus
                    FROM Bookings b
                    LEFT JOIN Rooms r ON b.RoomId = r.RoomID
                    WHERE CAST(b.CheckInDate AS DATE) = CAST(GETDATE() AS DATE)
                       OR (b.BookingStatus IN ('Confirmed', 'Pending') AND CAST(b.CheckInDate AS DATE) <= CAST(GETDATE() AS DATE))
                    ORDER BY b.BookingId DESC";
                
                using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptArrivals.DataSource = dt;
                    rptArrivals.DataBind();
                }
            }
        }
        catch { }
    }

    private void LoadDepartures()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT TOP 10 
                        b.BookingId,
                        b.BookingReference, 
                        b.GuestName, 
                        ISNULL(r.RoomName, 'Room #' + CAST(b.RoomId AS VARCHAR(10))) AS RoomNo, 
                        b.CheckOutDate, 
                        b.BookingStatus
                    FROM Bookings b
                    LEFT JOIN Rooms r ON b.RoomId = r.RoomID
                    WHERE CAST(b.CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)
                       OR (b.BookingStatus = 'Checked-In' AND CAST(b.CheckOutDate AS DATE) <= CAST(GETDATE() AS DATE))
                    ORDER BY b.BookingId DESC";
                
                using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptDepartures.DataSource = dt;
                    rptDepartures.DataBind();
                }
            }
        }
        catch { }
    }

    private void LoadRecentBookings()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"
                    SELECT TOP 5 
                        b.BookingId,
                        b.BookingReference, 
                        b.GuestName, 
                        ISNULL(r.RoomName, 'Room #' + CAST(b.RoomId AS VARCHAR(10))) AS RoomNo, 
                        b.CheckInDate, 
                        b.CheckOutDate, 
                        b.BookingStatus
                    FROM Bookings b
                    LEFT JOIN Rooms r ON b.RoomId = r.RoomID
                    ORDER BY b.BookingId DESC";
                
                using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptRecentBookings.DataSource = dt;
                    rptRecentBookings.DataBind();
                }
            }
        }
        catch { }
    }

    private void LoadRecentActivity()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Top 10 activities combining Bookings and Logins/Signups to simulate activity stream
                string sql = @"
                    SELECT TOP 10 ActivityType, Detail, SubDetail, TimeStr
                    FROM (
                        SELECT 'Booking' AS ActivityType, 
                               'New booking received' AS Detail, 
                               GuestName + ' - Room ' + ISNULL(CAST(RoomId AS VARCHAR), 'Any') AS SubDetail,
                               BookingDate AS ActivityTime,
                               CASE WHEN DATEDIFF(MINUTE, BookingDate, GETDATE()) < 60 
                                    THEN CAST(DATEDIFF(MINUTE, BookingDate, GETDATE()) AS VARCHAR) + ' minutes ago'
                                    ELSE CAST(DATEDIFF(HOUR, BookingDate, GETDATE()) AS VARCHAR) + ' hours ago' END AS TimeStr
                        FROM Bookings
                        
                        UNION ALL
                        
                        SELECT 'Customer' AS ActivityType,
                               'New customer registered' AS Detail,
                               FirstName + ' ' + LastName AS SubDetail,
                               CreatedAt AS ActivityTime,
                               CASE WHEN DATEDIFF(MINUTE, CreatedAt, GETDATE()) < 60 
                                    THEN CAST(DATEDIFF(MINUTE, CreatedAt, GETDATE()) AS VARCHAR) + ' minutes ago'
                                    ELSE CAST(DATEDIFF(HOUR, CreatedAt, GETDATE()) AS VARCHAR) + ' hours ago' END AS TimeStr
                        FROM Users
                    ) A
                    ORDER BY ActivityTime DESC";
                
                using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptActivity.DataSource = dt;
                    rptActivity.DataBind();
                }
            }
        }
        catch { }
    }
    
    // Helper function for UI badge formatting
    protected string GetStatusBadgeClass(string status)
    {
        if (string.IsNullOrEmpty(status)) return "status-pending";
        string s = status.ToLowerInvariant();
        if (s.Contains("confirm")) return "status-confirmed";
        if (s.Contains("pend")) return "status-pending";
        if (s.Contains("check-in") || s.Contains("checked-in")) return "status-checkedin";
        if (s.Contains("check-out") || s.Contains("checked-out") || s.Contains("complet")) return "status-checkedout";
        if (s.Contains("cancel")) return "status-cancelled";
        return "status-pending";
    }

    // Helper function for Arrivals action button/badge
    protected string GetArrivalActionHtml(object bookingId, object guestName, object status)
    {
        string s = status != null ? status.ToString() : "";
        if (s == "Checked-In")
        {
            return "<span class=\"badge bg-success-subtle text-success border px-1 py-0\" style=\"font-size:0.72rem;\"><i class=\"bi bi-check2\"></i> In-House</span>";
        }
        string id = bookingId != null ? bookingId.ToString() : "";
        string name = guestName != null ? guestName.ToString().Replace("'", "\\'") : "";
        return string.Format("<a href=\"Dashboard.aspx?action=checkin&id={0}\" class=\"action-btn btn-checkin\" onclick=\"return confirm('Check-In guest {1} now? Room will be marked Occupied.');\">Check-In</a>", id, name);
    }

    // Helper function for Departures action button/badge
    protected string GetDepartureActionHtml(object bookingId, object guestName, object status)
    {
        string s = status != null ? status.ToString() : "";
        if (s == "Completed")
        {
            return "<span class=\"badge bg-secondary-subtle text-muted border px-1 py-0\" style=\"font-size:0.72rem;\"><i class=\"bi bi-check-all\"></i> Done</span>";
        }
        string id = bookingId != null ? bookingId.ToString() : "";
        string name = guestName != null ? guestName.ToString().Replace("'", "\\'") : "";
        return string.Format("<a href=\"Dashboard.aspx?action=checkout&id={0}\" class=\"action-btn btn-checkout\" onclick=\"return confirm('Check-Out guest {1} now? Room will be sent to cleaning.');\">Check-Out</a>", id, name);
    }

    private void LoadDiningData()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Recent Table Reservations (Top 5)
                string sqlRes = @"
                    SELECT TOP 5 ReservationId, BookingCode, CustomerName, ReservationDate, TimeSlot, 
                                 ISNULL(GuestCount, 2) AS GuestCount, ISNULL(TableNumber, 'TBA') AS TableNumber, 
                                 ISNULL(Status, 'Pending') AS Status 
                    FROM TableReservations 
                    ORDER BY ReservationId DESC";

                using (SqlDataAdapter daRes = new SqlDataAdapter(sqlRes, con))
                {
                    DataTable dtRes = new DataTable();
                    daRes.Fill(dtRes);
                    rptDiningReservations.DataSource = dtRes;
                    rptDiningReservations.DataBind();
                    litDiningResCount.Text = dtRes.Rows.Count.ToString();
                }

                // 2. Restaurant Tables Inventory (Top 5)
                string sqlTables = @"
                    SELECT TOP 5 TableId, TableNumber, TableName, Capacity, 
                                 ISNULL(Section, 'Main Dining') AS Section, 
                                 ISNULL(TableStatus, 'Available') AS TableStatus 
                    FROM RestaurantTables 
                    WHERE ISNULL(IsActive, 1) = 1 
                    ORDER BY TableId ASC";

                using (SqlDataAdapter daTbl = new SqlDataAdapter(sqlTables, con))
                {
                    DataTable dtTbl = new DataTable();
                    daTbl.Fill(dtTbl);
                    rptRestaurantTables.DataSource = dtTbl;
                    rptRestaurantTables.DataBind();
                    litDiningTablesCount.Text = dtTbl.Rows.Count.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    protected string GetDiningStatusBadgeClass(string status)
    {
        if (string.IsNullOrEmpty(status)) return "status-pending";
        string s = status.ToLowerInvariant();
        if (s.Contains("confirm")) return "status-confirmed";
        if (s.Contains("pend")) return "status-pending";
        if (s.Contains("seat")) return "status-checkedin";
        if (s.Contains("complet")) return "status-checkedout";
        if (s.Contains("cancel")) return "status-cancelled";
        return "status-pending";
    }

    protected string GetTableStatusBadgeClass(string status)
    {
        if (string.IsNullOrEmpty(status)) return "status-confirmed";
        string s = status.ToLowerInvariant();
        if (s.Contains("avail")) return "status-confirmed";
        if (s.Contains("book") || s.Contains("occup")) return "status-checkedin";
        if (s.Contains("reserv")) return "status-pending";
        return "status-checkedout";
    }
}