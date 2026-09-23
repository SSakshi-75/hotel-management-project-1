using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageHotel : Page
{
    private readonly string conStr = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string status = Request.QueryString["status"] ?? Request.QueryString["msg"];
            if (status == "deleted")
            {
                ShowStatusMessage("Room was successfully deleted from inventory.", true);
            }
            else if (status == "deactivated")
            {
                ShowStatusMessage("Room deactivated successfully. Existing booking history has been preserved.", true);
            }

            LoadRooms();
            LoadRoomKPI();
        }
    }

    protected void grdrooms_PreRender(object sender, EventArgs e)
    {
        if (grdrooms.HeaderRow != null)
        {
            grdrooms.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    // ==========================================
    // LOAD ROOMS INTO GRIDVIEW
    // ==========================================
    private void LoadRooms()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    SELECT 
                        RoomID, 
                        RoomName, 
                        RoomCategory, 
                        PricePerNight, 
                        CategoryBadge, 
                        Rating, 
                        MaxGuests, 
                        RoomArea, 
                        ViewType, 
                        PrimaryRoomImage 
                    FROM Rooms 
                    WHERE ISNULL(IsActive, 1) = 1
                    ORDER BY RoomID DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    grdrooms.DataSource = dt;
                    grdrooms.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error loading hotel inventory: " + ex.Message, false);
        }
    }

    // ==========================================
    // KPI METRICS CALCULATION
    // ==========================================
    private void LoadRoomKPI()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                // 1. Total Rooms
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Rooms WHERE ISNULL(IsActive, 1) = 1", con))
                {
                    int totalRooms = Convert.ToInt32(cmd.ExecuteScalar());
                    kpiTotalRooms.InnerText = totalRooms.ToString();
                    kpiLiveRooms.InnerText = totalRooms + " Live";
                    lblRoomCountPill.InnerHtml = "<i class=\"bi bi-shield-check me-1\"></i> " + totalRooms + (totalRooms == 1 ? " Room Active" : " Rooms Active");
                }

                // 2. Average Tariff
                using (SqlCommand cmd = new SqlCommand("SELECT PricePerNight FROM Rooms WHERE ISNULL(IsActive, 1) = 1 AND PricePerNight IS NOT NULL", con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        decimal totalTariff = 0;
                        int validCount = 0;
                        while (reader.Read())
                        {
                            decimal price;
                            if (decimal.TryParse(reader["PricePerNight"].ToString(), out price))
                            {
                                totalTariff += price;
                                validCount++;
                            }
                        }
                        decimal avgTariff = validCount > 0 ? (totalTariff / validCount) : 0;
                        kpiAvgTariff.InnerHtml = "&#8377; " + string.Format("{0:N0}", avgTariff);
                    }
                }

                // 3. Distinct Categories
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(DISTINCT RoomCategory) FROM Rooms WHERE ISNULL(IsActive, 1) = 1 AND RoomCategory IS NOT NULL AND LTRIM(RTRIM(RoomCategory)) <> ''", con))
                {
                    int categories = Convert.ToInt32(cmd.ExecuteScalar());
                    kpiTotalCategories.InnerText = categories + (categories == 1 ? " Tier" : " Tiers");
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error loading room metrics: " + ex.Message, false);
        }
    }

    // ==========================================
    // GRIDVIEW PAGING
    // ==========================================
    protected void grdrooms_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdrooms.PageIndex = e.NewPageIndex;
        LoadRooms();
    }

    // ==========================================
    // ROW DATA BOUND (FOR CLIENT-SIDE FILTERING)
    // ==========================================
    protected void grdrooms_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.CssClass += " hotel-room-row";
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string category = drv["RoomCategory"] != DBNull.Value ? drv["RoomCategory"].ToString().Trim().ToUpper() : "";
                string name = drv["RoomName"] != DBNull.Value ? drv["RoomName"].ToString().Trim().ToLower() : "";

                e.Row.Attributes["data-category"] = category;
                e.Row.Attributes["data-name"] = name;
            }
        }
    }

    // ==========================================
    // CONFIRM DELETE ROOM (FROM BOOTSTRAP MODAL)
    // ==========================================
    protected void btnConfirmDeleteRoom_Click(object sender, EventArgs e)
    {
        int roomId;
        if (int.TryParse(hdnDeleteRoomId.Value, out roomId) && roomId > 0)
        {
            DeleteOrDeactivateRoom(roomId);
            hdnDeleteRoomId.Value = "0";
        }
        else
        {
            ShowStatusMessage("Unable to delete this room. Please select a valid room and try again.", false);
        }
    }

    // ==========================================
    // SINGLE ROOM DELETE (DIRECT / BACKWARD COMPATIBLE)
    // ==========================================
    protected void btnDeleteRoom_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        if (btn == null) return;

        int roomId;
        if (int.TryParse(btn.CommandArgument, out roomId))
        {
            DeleteOrDeactivateRoom(roomId);
        }
        else
        {
            ShowStatusMessage("Invalid room identifier.", false);
        }
    }

    // ==========================================
    // CORE DELETE / DEACTIVATE LOGIC
    // ==========================================
    private void DeleteOrDeactivateRoom(int roomId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                // Check whether the room has existing dependent booking/reservation records
                bool hasHistory = HasDependentBookings(con, roomId);

                if (hasHistory)
                {
                    // SAFE SOFT DELETE: Preserve historical bookings
                    string softQuery = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                    using (SqlCommand cmd = new SqlCommand(softQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomId);
                        int affected = cmd.ExecuteNonQuery();
                        if (affected > 0)
                        {
                            ShowStatusMessage("Room deactivated successfully. Existing booking history has been preserved.", true);
                        }
                        else
                        {
                            ShowStatusMessage("Room #" + roomId + " could not be found.", false);
                        }
                    }
                }
                else
                {
                    // PERMANENT DELETE: No booking history exists
                    try
                    {
                        string permQuery = "DELETE FROM Rooms WHERE RoomID = @RoomID";
                        using (SqlCommand cmd = new SqlCommand(permQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@RoomID", roomId);
                            int affected = cmd.ExecuteNonQuery();
                            if (affected > 0)
                            {
                                ShowStatusMessage("Room deleted successfully.", true);
                            }
                            else
                            {
                                ShowStatusMessage("Room #" + roomId + " could not be found.", false);
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        // SQL Error 547 indicates a foreign key constraint violation
                        if (sqlEx.Number == 547)
                        {
                            string softQuery = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                            using (SqlCommand cmd = new SqlCommand(softQuery, con))
                            {
                                cmd.Parameters.AddWithValue("@RoomID", roomId);
                                cmd.ExecuteNonQuery();
                                ShowStatusMessage("Room deactivated successfully. Existing booking history has been preserved.", true);
                            }
                        }
                        else
                        {
                            throw;
                        }
                    }
                }
            }

            // Instantly refresh GridView and KPI metrics
            LoadRooms();
            LoadRoomKPI();
        }
        catch (Exception)
        {
            // Requirement 5: Do not expose raw SQL exception details to the admin UI
            ShowStatusMessage("Unable to delete this room. Please try again.", false);
        }
    }

    // ==========================================
    // CHECK DEPENDENT BOOKING / RESERVATION RECORDS
    // ==========================================
    private bool HasDependentBookings(SqlConnection con, int roomId)
    {
        try
        {
            // 1. Check foreign key relationships pointing to Rooms table
            string fkSql = @"
                SELECT 
                    tp.name AS ParentTable, 
                    cp.name AS ColumnName
                FROM sys.foreign_keys fk
                INNER JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
                INNER JOIN sys.tables ref ON fk.referenced_object_id = ref.object_id
                INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
                INNER JOIN sys.columns cp ON fkc.parent_object_id = cp.object_id AND fkc.parent_column_id = cp.column_id
                WHERE ref.name = 'Rooms'";

            using (SqlCommand cmdFk = new SqlCommand(fkSql, con))
            {
                using (SqlDataReader rdr = cmdFk.ExecuteReader())
                {
                    List<Tuple<string, string>> fkList = new List<Tuple<string, string>>();
                    while (rdr.Read())
                    {
                        fkList.Add(new Tuple<string, string>(rdr["ParentTable"].ToString(), rdr["ColumnName"].ToString()));
                    }
                    rdr.Close();

                    foreach (var dep in fkList)
                    {
                        string checkSql = string.Format("SELECT COUNT(*) FROM [{0}] WHERE [{1}] = @RoomID", dep.Item1, dep.Item2);
                        using (SqlCommand cmdCheck = new SqlCommand(checkSql, con))
                        {
                            cmdCheck.Parameters.AddWithValue("@RoomID", roomId);
                            int count = Convert.ToInt32(cmdCheck.ExecuteScalar());
                            if (count > 0) return true;
                        }
                    }
                }
            }

            // 2. Check common hotel booking tables dynamically if they exist in schema
            string[] bookingTables = new string[] { 
                "Bookings", "Reservations", "RoomBookings", "BookingDetails", 
                "CheckIn", "CheckOut", "RoomReservations", "Orders" 
            };

            foreach (string tbl in bookingTables)
            {
                string existsSql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @Tbl AND COLUMN_NAME IN ('RoomID', 'RoomId')";
                using (SqlCommand cmdExists = new SqlCommand(existsSql, con))
                {
                    cmdExists.Parameters.AddWithValue("@Tbl", tbl);
                    int colExists = Convert.ToInt32(cmdExists.ExecuteScalar());
                    if (colExists > 0)
                    {
                        string checkSql = string.Format("SELECT COUNT(*) FROM [{0}] WHERE RoomID = @RoomID", tbl);
                        using (SqlCommand cmdCheck = new SqlCommand(checkSql, con))
                        {
                            cmdCheck.Parameters.AddWithValue("@RoomID", roomId);
                            int count = Convert.ToInt32(cmdCheck.ExecuteScalar());
                            if (count > 0) return true;
                        }
                    }
                }
            }
        }
        catch
        {
            // If any lookup query encounters an issue, proceed safely
        }

        return false;
    }

    // ==========================================
    // BULK DELETE
    // ==========================================
    protected void btnBulkDelete_Click(object sender, EventArgs e)
    {
        int processedCount = 0;
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                for (int i = 0; i < grdrooms.Rows.Count; i++)
                {
                    GridViewRow row = grdrooms.Rows[i];
                    CheckBox chk = row.FindControl("chkRoomSelect") as CheckBox;
                    if (chk != null && chk.Checked)
                    {
                        int roomId = Convert.ToInt32(grdrooms.DataKeys[i].Value);
                        bool hasHistory = HasDependentBookings(con, roomId);

                        if (hasHistory)
                        {
                            string query = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                            using (SqlCommand cmd = new SqlCommand(query, con))
                            {
                                cmd.Parameters.AddWithValue("@RoomID", roomId);
                                processedCount += cmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            try
                            {
                                string query = "DELETE FROM Rooms WHERE RoomID = @RoomID";
                                using (SqlCommand cmd = new SqlCommand(query, con))
                                {
                                    cmd.Parameters.AddWithValue("@RoomID", roomId);
                                    processedCount += cmd.ExecuteNonQuery();
                                }
                            }
                            catch (SqlException sqlEx)
                            {
                                if (sqlEx.Number == 547)
                                {
                                    string query = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                                    using (SqlCommand cmd = new SqlCommand(query, con))
                                    {
                                        cmd.Parameters.AddWithValue("@RoomID", roomId);
                                        processedCount += cmd.ExecuteNonQuery();
                                    }
                                }
                                else
                                {
                                    throw;
                                }
                            }
                        }
                    }
                }
            }

            if (processedCount > 0)
            {
                ShowStatusMessage("Successfully processed " + processedCount + " room(s) from inventory.", true);
            }
            else
            {
                ShowStatusMessage("Please select at least one room checkbox to delete.", false);
            }

            LoadRooms();
            LoadRoomKPI();
        }
        catch (Exception)
        {
            ShowStatusMessage("Unable to delete selected rooms. Please try again.", false);
        }
    }

    // ==========================================
    // HELPER: IMAGE URL RESOLUTION
    // ==========================================
    public string GetRoomImage(object imgObj)
    {
        if (imgObj == null || imgObj == DBNull.Value || string.IsNullOrWhiteSpace(imgObj.ToString()))
        {
            return ResolveUrl("~/images/rooms/room-ocean-view.jpg");
        }

        string img = imgObj.ToString().Trim();

        if (img.StartsWith("~"))
        {
            return ResolveUrl(img);
        }

        if (!img.StartsWith("/") && !img.StartsWith("http") && !img.StartsWith("../"))
        {
            return ResolveUrl("~/images/rooms/" + img);
        }

        return ResolveUrl(img);
    }

    // ==========================================
    // HELPER: CATEGORY BADGE CSS CLASS
    // ==========================================
    public string GetCategoryBadgeClass(object categoryObj)
    {
        if (categoryObj == null || categoryObj == DBNull.Value)
        {
            return "badge-category-deluxe";
        }

        string cat = categoryObj.ToString().Trim().ToUpper();
        if (cat.Contains("PENTHOUSE")) return "badge-category-penthouse";
        if (cat.Contains("FAMILY")) return "badge-category-family";
        if (cat.Contains("EXECUTIVE")) return "badge-category-executive";
        return "badge-category-deluxe";
    }

    // ==========================================
    // HELPER: STATUS NOTIFICATION
    // ==========================================
    private void ShowStatusMessage(string message, bool isSuccess)
    {
        pnlStatusMsg.Visible = true;
        lblStatusMessage.Text = message;
        if (isSuccess)
        {
            pnlStatusMsg.CssClass = "alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4";
            msgIcon.Attributes["class"] = "bi bi-check-circle-fill fs-4 text-success";
        }
        else
        {
            pnlStatusMsg.CssClass = "alert alert-danger alert-dismissible fade show mb-4 shadow-sm rounded-4";
            msgIcon.Attributes["class"] = "bi bi-exclamation-triangle-fill fs-4 text-danger";
        }
    }
}