using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Close mobile sidebar on fresh page navigation
            Session["AdminSidebarOpen"] = false;
            LoadRecentNotifications();
        }
    }

    private void LoadRecentNotifications()
    {
        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
                ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
                : "";
            if (string.IsNullOrEmpty(connStr)) return;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                string checkSql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bookings'";
                using (SqlCommand chkCmd = new SqlCommand(checkSql, con))
                {
                    int tableCount = Convert.ToInt32(chkCmd.ExecuteScalar());
                    if (tableCount == 0) return;
                }

                int lastReadBookingId = 0;
                if (Request.Cookies["LastReadBookingId"] != null)
                {
                    int.TryParse(Request.Cookies["LastReadBookingId"].Value, out lastReadBookingId);
                }

                string sql = @"
                    SELECT TOP 5
                        b.BookingId,
                        b.BookingReference,
                        b.GuestName,
                        ISNULL(r.RoomName, 'Room #' + CAST(b.RoomId AS VARCHAR(10))) AS RoomName,
                        ISNULL(b.CreatedAt, b.BookingDate) AS NotifTime,
                        b.BookingStatus
                    FROM Bookings b
                    LEFT JOIN Rooms r ON b.RoomId = r.RoomID
                    WHERE b.BookingId > @LastReadId
                    ORDER BY b.BookingId DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@LastReadId", lastReadBookingId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        int count = 0;
                        int maxBookingId = lastReadBookingId;

                        while (reader.Read())
                        {
                            count++;
                            int curId = Convert.ToInt32(reader["BookingId"]);
                            if (curId > maxBookingId) maxBookingId = curId;

                            string bRef = reader["BookingReference"] != null ? reader["BookingReference"].ToString() : "";
                            string gName = reader["GuestName"] != null ? reader["GuestName"].ToString() : "Guest";
                            string rName = reader["RoomName"] != null ? reader["RoomName"].ToString() : "Room";
                            DateTime notifDate = DateTime.Now;
                            if (reader["NotifTime"] != DBNull.Value)
                            {
                                DateTime.TryParse(reader["NotifTime"].ToString(), out notifDate);
                            }
                            string timeAgo = GetTimeAgo(notifDate);

                            sb.Append(string.Format(
                                "<a href=\"Bookings.aspx\" class=\"text-decoration-none d-block notification-item-link\" data-id=\"{0}\">" +
                                    "<div class=\"notification-item p-3 border-bottom unread bg-light\">" +
                                        "<div class=\"d-flex align-items-start gap-3\">" +
                                            "<div class=\"notif-icon rounded-circle p-2 bg-primary-subtle\" style=\"width: 36px; height: 36px; display: flex; align-items: center; justify-content: center;\">" +
                                                "<i class=\"bi bi-door-open-fill text-primary\"></i>" +
                                            "</div>" +
                                            "<div class=\"notif-content flex-grow-1\">" +
                                                "<h6 class=\"mb-1 text-dark small fw-bold\">New Room Booking Alert</h6>" +
                                                "<p class=\"mb-1 text-muted small\" style=\"line-height: 1.4; word-break: break-word;\">New booking received: {1} | Guest: {2} | Room: {3}</p>" +
                                                "<span class=\"notif-time text-muted\" style=\"font-size: 0.7rem;\"><i class=\"bi bi-clock me-1\"></i>{4}</span>" +
                                            "</div>" +
                                        "</div>" +
                                    "</div>" +
                                "</a>",
                                curId,
                                HttpUtility.HtmlEncode(bRef),
                                HttpUtility.HtmlEncode(gName),
                                HttpUtility.HtmlEncode(rName),
                                HttpUtility.HtmlEncode(timeAgo)
                            ));
                        }

                        if (count > 0)
                        {
                            notifBadge.InnerText = count.ToString();
                            notifBadge.Attributes["class"] = "notif-badge-pill";
                            notifBadge.Attributes["data-max-id"] = maxBookingId.ToString();
                            notifCountText.InnerText = count + " New";
                            noNotifications.Style["display"] = "none";
                            notificationList.InnerHtml = sb.ToString();
                        }
                        else
                        {
                            notifBadge.InnerText = "0";
                            notifBadge.Attributes["class"] = "notif-badge-pill d-none";
                            notifCountText.InnerText = "0 New";
                            noNotifications.Style["display"] = "block";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("LoadRecentNotifications error: " + ex.Message);
        }
    }

    private string GetTimeAgo(DateTime dt)
    {
        TimeSpan span = DateTime.Now - dt;
        if (span.TotalMinutes < 1) return "Just now";
        if (span.TotalMinutes < 60) return string.Format("{0} mins ago", (int)span.TotalMinutes);
        if (span.TotalHours < 24) return string.Format("{0} hours ago", (int)span.TotalHours);
        if (span.TotalDays < 7) return string.Format("{0} days ago", (int)span.TotalDays);
        return dt.ToString("dd MMM yyyy");
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ApplySidebarState();
    }

    private void ApplySidebarState()
    {
        bool isOpen = Session["AdminSidebarOpen"] != null && (bool)Session["AdminSidebarOpen"];
        if (isOpen)
        {
            adminSidebar.Attributes["class"] = "admin-sidebar open";
            sidebarOverlay.CssClass = "admin-sidebar-overlay active";
        }
        else
        {
            adminSidebar.Attributes["class"] = "admin-sidebar";
            sidebarOverlay.CssClass = "admin-sidebar-overlay";
        }
    }

    protected void btnSidebarToggle_Click(object sender, EventArgs e)
    {
        bool isOpen = Session["AdminSidebarOpen"] != null && (bool)Session["AdminSidebarOpen"];
        Session["AdminSidebarOpen"] = !isOpen;
    }

    protected void btnSidebarClose_Click(object sender, EventArgs e)
    {
        Session["AdminSidebarOpen"] = false;
    }
}
