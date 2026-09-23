using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_DeleteRoom : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string reqRoomId = Request.QueryString["RoomId"] ?? Request.QueryString["id"];
            int roomId;

            if (!string.IsNullOrEmpty(reqRoomId) && int.TryParse(reqRoomId, out roomId) && roomId > 0)
            {
                hdnRoomId.Value = roomId.ToString();
                LoadRoomData(roomId);
            }
            else
            {
                Response.Redirect("ManageHotel.aspx", true);
            }
        }
    }

    // ==========================================
    // LOAD ROOM DETAILS FOR DELETION PREVIEW
    // ==========================================
    private void LoadRoomData(int roomId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT * FROM Rooms WHERE RoomID = @RoomID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RoomID", roomId);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            lblHeaderRoomId.InnerText = roomId.ToString();
                            lblRoomName.InnerText = dr["RoomName"] != DBNull.Value ? dr["RoomName"].ToString() : ("Room #" + roomId);
                            lblRoomCategory.InnerText = dr["RoomCategory"] != DBNull.Value ? dr["RoomCategory"].ToString() : "Standard";

                            decimal price;
                            if (dr["PricePerNight"] != DBNull.Value && decimal.TryParse(dr["PricePerNight"].ToString(), out price))
                            {
                                lblPrice.InnerText = string.Format("{0:N0}", price);
                            }
                            else
                            {
                                lblPrice.InnerText = "0";
                            }

                            lblOccupancy.InnerText = dr["MaxGuests"] != DBNull.Value && !string.IsNullOrWhiteSpace(dr["MaxGuests"].ToString()) 
                                ? (dr["MaxGuests"].ToString() + " Guests") 
                                : "2 Guests";

                            lblArea.InnerText = dr["RoomArea"] != DBNull.Value && !string.IsNullOrWhiteSpace(dr["RoomArea"].ToString()) 
                                ? (dr["RoomArea"].ToString() + " sq ft") 
                                : "N/A";

                            lblViewType.InnerText = dr["ViewType"] != DBNull.Value && !string.IsNullOrWhiteSpace(dr["ViewType"].ToString()) 
                                ? dr["ViewType"].ToString() 
                                : "Standard View";

                            lblShortDesc.InnerText = dr["ShortDescription"] != DBNull.Value && !string.IsNullOrWhiteSpace(dr["ShortDescription"].ToString()) 
                                ? dr["ShortDescription"].ToString() 
                                : "No description registered for this room.";

                            string primaryImg = dr["PrimaryRoomImage"] != DBNull.Value ? dr["PrimaryRoomImage"].ToString().Trim() : "";
                            imgRoomThumb.ImageUrl = GetRoomImageUrl(primaryImg);
                        }
                        else
                        {
                            ShowStatus("Room #" + roomId + " could not be found.", false);
                            pnlDeleteConfirm.Visible = false;
                            return;
                        }
                    }
                }

                // Check dependencies (Bookings / Reservations)
                bool hasHistory = HasDependentBookings(con, roomId);
                if (hasHistory)
                {
                    pnlBookingWarning.Visible = true;
                    pnlPermanentNotice.Visible = false;
                }
                else
                {
                    pnlBookingWarning.Visible = false;
                    pnlPermanentNotice.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatus("Error retrieving room details: " + ex.Message, false);
            pnlDeleteConfirm.Visible = false;
        }
    }

    // ==========================================
    // CONFIRM DELETE ACTION
    // ==========================================
    protected void btnConfirmDelete_Click(object sender, EventArgs e)
    {
        int roomId;
        if (!int.TryParse(hdnRoomId.Value, out roomId) || roomId <= 0)
        {
            ShowStatus("Invalid room identifier.", false);
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                bool hasHistory = HasDependentBookings(con, roomId);

                if (hasHistory)
                {
                    // SAFE SOFT DELETE
                    string softSql = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                    using (SqlCommand cmd = new SqlCommand(softSql, con))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomId);
                        cmd.ExecuteNonQuery();
                    }

                    Response.Redirect("ManageHotel.aspx?status=deactivated", true);
                }
                else
                {
                    // PERMANENT DELETE
                    try
                    {
                        string permSql = "DELETE FROM Rooms WHERE RoomID = @RoomID";
                        using (SqlCommand cmd = new SqlCommand(permSql, con))
                        {
                            cmd.Parameters.AddWithValue("@RoomID", roomId);
                            cmd.ExecuteNonQuery();
                        }

                        Response.Redirect("ManageHotel.aspx?status=deleted", true);
                    }
                    catch (SqlException sqlEx)
                    {
                        // 547 = Foreign key constraint violation
                        if (sqlEx.Number == 547)
                        {
                            string softSql = "UPDATE Rooms SET IsActive = 0, RoomStatus = 'Inactive' WHERE RoomID = @RoomID";
                            using (SqlCommand cmd = new SqlCommand(softSql, con))
                            {
                                cmd.Parameters.AddWithValue("@RoomID", roomId);
                                cmd.ExecuteNonQuery();
                            }

                            Response.Redirect("ManageHotel.aspx?status=deactivated", true);
                        }
                        else
                        {
                            throw;
                        }
                    }
                }
            }
        }
        catch (System.Threading.ThreadAbortException)
        {
            // Expected during Response.Redirect
        }
        catch (Exception)
        {
            ShowStatus("Unable to delete this room. Please try again.", false);
        }
    }

    // ==========================================
    // DEPENDENT BOOKING CHECK
    // ==========================================
    private bool HasDependentBookings(SqlConnection con, int roomId)
    {
        try
        {
            // 1. Check foreign key relationships
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

            // 2. Check common hotel booking tables
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
            // Safe fallback
        }

        return false;
    }

    // ==========================================
    // HELPER: IMAGE URL
    // ==========================================
    private string GetRoomImageUrl(string img)
    {
        if (string.IsNullOrWhiteSpace(img))
        {
            return ResolveUrl("~/images/rooms/room-ocean-view.jpg");
        }

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
    // HELPER: STATUS MESSAGE
    // ==========================================
    private void ShowStatus(string message, bool isSuccess)
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
