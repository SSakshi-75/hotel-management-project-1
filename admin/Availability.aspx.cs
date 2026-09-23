using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Availability : Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtCheckIn.Text = DateTime.Today.ToString("yyyy-MM-dd");
            txtCheckOut.Text = DateTime.Today.AddDays(1).ToString("yyyy-MM-dd");
            LoadInventoryMetrics();
            BindRoomInventory();
        }
    }

    private void LoadInventoryMetrics()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = @"
                    SELECT 
                        COUNT(*) AS TotalRooms,
                        SUM(CASE WHEN ISNULL(RoomStatus, 'Available') = 'Available' THEN 1 ELSE 0 END) AS AvailableRooms,
                        SUM(CASE WHEN RoomStatus = 'Occupied' THEN 1 ELSE 0 END) AS OccupiedRooms,
                        SUM(CASE WHEN RoomStatus = 'Cleaning' THEN 1 ELSE 0 END) AS CleaningRooms,
                        SUM(CASE WHEN RoomStatus IN ('Maintenance', 'Blocked') THEN 1 ELSE 0 END) AS MaintenanceRooms
                    FROM Rooms
                    WHERE ISNULL(IsActive, 1) = 1";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            lblTotalSuites.Text = rdr["TotalRooms"] != DBNull.Value ? rdr["TotalRooms"].ToString() : "0";
                            lblAvailableSuites.Text = rdr["AvailableRooms"] != DBNull.Value ? rdr["AvailableRooms"].ToString() : "0";
                            lblOccupiedSuites.Text = rdr["OccupiedRooms"] != DBNull.Value ? rdr["OccupiedRooms"].ToString() : "0";
                            lblCleaningSuites.Text = rdr["CleaningRooms"] != DBNull.Value ? rdr["CleaningRooms"].ToString() : "0";
                            lblMaintenanceSuites.Text = rdr["MaintenanceRooms"] != DBNull.Value ? rdr["MaintenanceRooms"].ToString() : "0";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error loading inventory metrics: " + ex.Message, "danger");
        }
    }

    private void BindRoomInventory()
    {
        try
        {
            DateTime checkIn = DateTime.MinValue;
            DateTime checkOut = DateTime.MinValue;
            bool hasValidDates = DateTime.TryParse(txtCheckIn.Text, out checkIn) && DateTime.TryParse(txtCheckOut.Text, out checkOut);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string sql;
                if (hasValidDates && checkOut > checkIn)
                {
                    sql = @"
                        SELECT 
                            r.RoomID,
                            r.RoomName,
                            r.RoomCategory,
                            r.PricePerNight,
                            r.MaxGuests,
                            r.RoomArea,
                            ISNULL(r.RoomStatus, 'Available') AS RoomStatus,
                            ISNULL(r.IsActive, 1) AS IsActive,
                            r.PrimaryRoomImage,
                            (SELECT COUNT(*) FROM Bookings b 
                             WHERE b.RoomId = r.RoomID 
                               AND b.BookingStatus IN ('Pending', 'Confirmed', 'Checked-In')
                               AND b.CheckInDate < @CheckOutDate
                               AND b.CheckOutDate > @CheckInDate) AS OverlapBookingsCount
                        FROM Rooms r
                        ORDER BY r.RoomID ASC";
                }
                else
                {
                    sql = @"
                        SELECT 
                            r.RoomID,
                            r.RoomName,
                            r.RoomCategory,
                            r.PricePerNight,
                            r.MaxGuests,
                            r.RoomArea,
                            ISNULL(r.RoomStatus, 'Available') AS RoomStatus,
                            ISNULL(r.IsActive, 1) AS IsActive,
                            r.PrimaryRoomImage,
                            0 AS OverlapBookingsCount
                        FROM Rooms r
                        ORDER BY r.RoomID ASC";
                }

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (hasValidDates && checkOut > checkIn)
                    {
                        cmd.Parameters.AddWithValue("@CheckInDate", checkIn.Date);
                        cmd.Parameters.AddWithValue("@CheckOutDate", checkOut.Date);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptRoomInventory.DataSource = dt;
                        rptRoomInventory.DataBind();
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowAlert("Error loading room inventory: " + ex.Message, "danger");
        }
    }

    protected void btnFilterDates_Click(object sender, EventArgs e)
    {
        DateTime checkIn = DateTime.MinValue;
        DateTime checkOut = DateTime.MinValue;

        if (!DateTime.TryParse(txtCheckIn.Text, out checkIn) || !DateTime.TryParse(txtCheckOut.Text, out checkOut))
        {
            ShowAlert("Please enter valid check-in and check-out dates.", "warning");
            return;
        }

        if (checkOut <= checkIn)
        {
            ShowAlert("Check-out date must be strictly after check-in date.", "warning");
            return;
        }

        pnlDateSearchInfo.Visible = true;
        lblDateSearchInfo.Text = string.Format("Displaying room availability and active reservations for {0} to {1}.",
            checkIn.ToString("dd MMM yyyy"), checkOut.ToString("dd MMM yyyy"));

        BindRoomInventory();
    }

    protected void btnResetDates_Click(object sender, EventArgs e)
    {
        txtCheckIn.Text = DateTime.Today.ToString("yyyy-MM-dd");
        txtCheckOut.Text = DateTime.Today.AddDays(1).ToString("yyyy-MM-dd");
        pnlDateSearchInfo.Visible = false;
        LoadInventoryMetrics();
        BindRoomInventory();
    }

    protected void rptRoomInventory_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "SetStatus")
        {
            string argument = e.CommandArgument != null ? e.CommandArgument.ToString() : "";
            string[] parts = argument.Split(':');
            if (parts.Length == 2)
            {
                int roomId;
                if (int.TryParse(parts[0], out roomId))
                {
                    string newStatus = parts[1];
                    UpdateRoomStatus(roomId, newStatus);
                }
            }
        }
    }

    private void UpdateRoomStatus(int roomId, string newStatus)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = "UPDATE Rooms SET RoomStatus = @NewStatus WHERE RoomID = @RoomId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@NewStatus", newStatus);
                    cmd.Parameters.AddWithValue("@RoomId", roomId);
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        ShowAlert(string.Format("Room #{0} operational status successfully updated to '{1}'.", roomId, newStatus), "success");
                    }
                    else
                    {
                        ShowAlert(string.Format("Room #{0} could not be updated.", roomId), "warning");
                    }
                }
            }

            LoadInventoryMetrics();
            BindRoomInventory();
        }
        catch (Exception ex)
        {
            ShowAlert("Error updating room status: " + ex.Message, "danger");
        }
    }

    public string GetRoomThumbnail(object imgObj)
    {
        if (imgObj == null || imgObj == DBNull.Value || string.IsNullOrWhiteSpace(imgObj.ToString()))
        {
            return ResolveUrl("~/images/room-classic-double.jpg");
        }
        string img = imgObj.ToString().Trim();
        if (img.StartsWith("~") || img.StartsWith("/") || img.StartsWith("http")) return ResolveUrl(img);
        return ResolveUrl("~/images/" + img);
    }

    public string GetStatusBadgeHtml(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString() : "Available";
        switch (status.ToLower())
        {
            case "available":
                return "<span class=\"badge bg-success-subtle text-success border border-success-subtle px-2 py-1\"><i class=\"bi bi-check-circle-fill me-1\"></i> Available</span>";
            case "occupied":
                return "<span class=\"badge bg-primary-subtle text-primary border border-primary-subtle px-2 py-1\"><i class=\"bi bi-person-fill me-1\"></i> Occupied</span>";
            case "cleaning":
                return "<span class=\"badge bg-warning-subtle text-dark border border-warning px-2 py-1\"><i class=\"bi bi-brush-fill me-1 text-warning\"></i> Cleaning</span>";
            case "maintenance":
                return "<span class=\"badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1\"><i class=\"bi bi-tools me-1\"></i> Maintenance</span>";
            case "blocked":
                return "<span class=\"badge bg-dark text-white px-2 py-1\"><i class=\"bi bi-slash-circle me-1\"></i> Blocked</span>";
            default:
                return "<span class=\"badge bg-secondary px-2 py-1\">" + status + "</span>";
        }
    }

    public string GetDateAvailabilityBadgeHtml(object overlapCountObj, object statusObj)
    {
        int count = 0;
        if (overlapCountObj != null && overlapCountObj != DBNull.Value)
        {
            int.TryParse(overlapCountObj.ToString(), out count);
        }

        string masterStatus = statusObj != null ? statusObj.ToString().ToLower() : "available";

        if (masterStatus == "maintenance" || masterStatus == "blocked" || masterStatus == "inactive")
        {
            return "<span class=\"badge bg-danger text-white\"><i class=\"bi bi-x-octagon-fill me-1\"></i> Out of Service</span>";
        }

        if (count > 0)
        {
            return "<span class=\"badge bg-danger-subtle text-danger border border-danger-subtle\"><i class=\"bi bi-calendar-x-fill me-1\"></i> Booked For Dates</span>";
        }

        return "<span class=\"badge bg-success-subtle text-success border border-success-subtle\"><i class=\"bi bi-check2-circle me-1\"></i> Free For Dates</span>";
    }

    private void ShowAlert(string message, string type)
    {
        pnlAlert.Visible = true;
        pnlAlert.CssClass = "alert alert-" + type + " alert-dismissible fade show d-flex align-items-center mb-4";
        lblAlertText.Text = message;
    }
}
