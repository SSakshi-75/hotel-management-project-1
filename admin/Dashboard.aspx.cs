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
        if (!IsPostBack)
        {
            LoadDashboardMetrics();
            LoadChartData();
            LoadArrivals();
            LoadDepartures();
            LoadRecentBookings();
            LoadRecentActivity();
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
                    SELECT COUNT(*) AS TotalBookings,
                           SUM(CASE WHEN BookingStatus = 'Confirmed' THEN 1 ELSE 0 END) AS ConfirmedBookings,
                           SUM(CASE WHEN BookingStatus = 'Pending' THEN 1 ELSE 0 END) AS PendingBookings
                    FROM Bookings WHERE CAST(BookingDate AS DATE) = @Today;
                    
                    -- Room Stats
                    SELECT COUNT(*) AS TotalRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Available' THEN 1 ELSE 0 END) AS AvailableRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Occupied' THEN 1 ELSE 0 END) AS OccupiedRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Cleaning' THEN 1 ELSE 0 END) AS CleaningRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Maintenance' THEN 1 ELSE 0 END) AS MaintenanceRooms,
                           SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Blocked' THEN 1 ELSE 0 END) AS BlockedRooms
                    FROM Rooms WHERE ISNULL(IsActive, 1) = 1;
                    
                    -- Check-ins Today
                    SELECT COUNT(*) AS TotalCheckins,
                           SUM(CASE WHEN BookingStatus IN ('Pending', 'Confirmed') THEN 1 ELSE 0 END) AS PendingCheckins
                    FROM Bookings WHERE CAST(CheckInDate AS DATE) = @Today;
                    
                    -- Check-outs Today
                    SELECT COUNT(*) AS TotalCheckouts,
                           SUM(CASE WHEN BookingStatus = 'Checked-In' THEN 1 ELSE 0 END) AS PendingCheckouts
                    FROM Bookings WHERE CAST(CheckOutDate AS DATE) = @Today;
                    -- Table Reservations Today
                    SELECT COUNT(*) AS TableResToday
                    FROM TableReservations WHERE CAST(ReservationDate AS DATE) = @Today;
                    
                    -- Table Stats
                    SELECT COUNT(*) AS TotalTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') = 'Available' THEN 1 ELSE 0 END) AS AvailableTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') = 'Occupied' THEN 1 ELSE 0 END) AS OccupiedTables,
                           SUM(CASE WHEN ISNULL(TableStatus, 'Available') = 'Reserved' THEN 1 ELSE 0 END) AS ReservedTables
                    FROM Tables WHERE ISNULL(IsActive, 1) = 1;
                ";

                using (SqlCommand cmd = new SqlCommand(kpiSql, con))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        // Revenue
                        if (rdr.Read())
                        {
                            decimal rev = Convert.ToDecimal(rdr["RevenueToday"]);
                            lblTodayRevenue.Text = rev.ToString("N0");
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
                            
                            hfDonutTotal.Value = totalR.ToString();
                            hfDonutData.Value = string.Format("[{0}, {1}, {2}, {3}, {4}]", lblRoomAvailable.Text, lblRoomOccupied.Text, lblRoomCleaning.Text, lblRoomMaintenance.Text, lblRoomBlocked.Text);
                        }
                        
                        // Check-ins
                        if (rdr.NextResult() && rdr.Read())
                        {
                            lblCheckinsToday.Text = rdr["TotalCheckins"] != DBNull.Value ? rdr["TotalCheckins"].ToString() : "0";
                            lblCheckinsPending.Text = rdr["PendingCheckins"] != DBNull.Value ? rdr["PendingCheckins"].ToString() : "0";
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
                        COUNT(b.BookingId) AS TotalBookings,
                        SUM(CASE WHEN b.BookingStatus = 'Confirmed' THEN 1 ELSE 0 END) AS ConfirmedBookings
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
                    SELECT TOP 10 BookingReference, GuestName, ISNULL(RoomId, 'N/A') AS RoomNo, 
                           CheckInDate, BookingStatus
                    FROM Bookings
                    WHERE CAST(CheckInDate AS DATE) = CAST(GETDATE() AS DATE)
                    ORDER BY BookingId DESC";
                
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
                    SELECT TOP 10 BookingReference, GuestName, ISNULL(RoomId, 'N/A') AS RoomNo, 
                           CheckOutDate, BookingStatus
                    FROM Bookings
                    WHERE CAST(CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)
                    ORDER BY BookingId DESC";
                
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
                    SELECT TOP 5 BookingReference, GuestName, ISNULL(RoomId, 'N/A') AS RoomNo, 
                           CheckInDate, CheckOutDate, BookingStatus
                    FROM Bookings
                    ORDER BY BookingId DESC";
                
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
}