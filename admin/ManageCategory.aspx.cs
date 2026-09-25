using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageCategory : System.Web.UI.Page
{
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!IsPostBack)
        {
            EnsureRoomCategoriesTableExists();
            LoadCategories();
        }
    }

    private void EnsureRoomCategoriesTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            string checkTableSql = @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RoomCategories')
                BEGIN
                    CREATE TABLE RoomCategories (
                        CategoryID INT IDENTITY(1,1) PRIMARY KEY,
                        CategoryName NVARCHAR(100) NOT NULL UNIQUE,
                        PublishingStatus NVARCHAR(50) NOT NULL DEFAULT 'Active',
                        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
                        UpdatedAt DATETIME NULL
                    );
                END
                ELSE
                BEGIN
                    -- Clean up any auto-seeded system categories so only admin explicitly inserted categories appear
                    DELETE FROM RoomCategories 
                    WHERE UPPER(LTRIM(RTRIM(CategoryName))) IN ('EXECUTIVE', 'DELUXE', 'FAMILY', 'PENTHOUSE', 'ROYAL KING')
                      AND CategoryName <> 'HERITAGE SUITE';
                END";

            using (SqlCommand cmd = new SqlCommand(checkTableSql, con))
            {
                cmd.ExecuteNonQuery();
            }
        }
    }

    private void LoadCategories()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                    SELECT 
                        c.CategoryID AS CategoryId,
                        c.CategoryName,
                        c.PublishingStatus,
                        CASE WHEN LOWER(LTRIM(RTRIM(c.PublishingStatus))) = 'active' THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS IsActive,
                        c.CreatedAt AS CreatedDate,
                        COUNT(r.RoomId) AS RoomCount
                    FROM RoomCategories c
                    LEFT JOIN Rooms r ON UPPER(LTRIM(RTRIM(r.RoomCategory))) = UPPER(LTRIM(RTRIM(c.CategoryName)))
                    GROUP BY c.CategoryID, c.CategoryName, c.PublishingStatus, c.CreatedAt
                    ORDER BY c.CategoryID DESC";

                DataTable dt = new DataTable();
                using (SqlDataAdapter da = new SqlDataAdapter(query, con))
                {
                    da.Fill(dt);
                }

                gvCategories.DataSource = dt;
                gvCategories.DataBind();

                // Calculate KPIs
                int totalCategories = dt.Rows.Count;
                int activeCategories = 0;
                int totalRooms = 0;

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToBoolean(row["IsActive"]))
                    {
                        activeCategories++;
                    }
                    totalRooms += Convert.ToInt32(row["RoomCount"]);
                }

                kpiTotalCategories.InnerText = totalCategories.ToString();
                kpiActiveCategories.InnerText = activeCategories.ToString() + " Live";
                kpiInactiveCategories.InnerText = (totalCategories - activeCategories).ToString();
                kpiTotalRooms.InnerText = totalRooms.ToString() + " Rooms";
                lblCategoryCountPill.InnerHtml = "<i class=\"bi bi-shield-check me-1\"></i> " + totalCategories + " Categories Registered";
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error loading room categories: " + ex.Message, false);
        }
    }

    protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ToggleStatus")
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string toggleSql = @"
                        UPDATE RoomCategories 
                        SET PublishingStatus = CASE WHEN LOWER(LTRIM(RTRIM(PublishingStatus))) = 'active' THEN 'Inactive' ELSE 'Active' END,
                            UpdatedAt = GETDATE()
                        WHERE CategoryID = @CategoryId";

                    using (SqlCommand cmd = new SqlCommand(toggleSql, con))
                    {
                        cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowStatusMessage("Category status updated successfully.", true);
                LoadCategories();
            }
            catch (Exception ex)
            {
                ShowStatusMessage("Error updating status: " + ex.Message, false);
            }
        }
        else if (e.CommandName == "DeleteCategory")
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Check if any rooms currently use this category
                    string checkSql = @"
                        SELECT COUNT(*) 
                        FROM Rooms r
                        INNER JOIN RoomCategories c ON UPPER(LTRIM(RTRIM(r.RoomCategory))) = UPPER(LTRIM(RTRIM(c.CategoryName)))
                        WHERE c.CategoryID = @CategoryId";

                    using (SqlCommand checkCmd = new SqlCommand(checkSql, con))
                    {
                        checkCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        int roomCount = (int)checkCmd.ExecuteScalar();
                        if (roomCount > 0)
                        {
                            // Safety: Do not hard delete category if rooms are mapped to it; deactivate it instead
                            string deactivateSql = @"
                                UPDATE RoomCategories 
                                SET PublishingStatus = 'Inactive',
                                    UpdatedAt = GETDATE()
                                WHERE CategoryID = @CategoryId";

                            using (SqlCommand deactCmd = new SqlCommand(deactivateSql, con))
                            {
                                deactCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                                deactCmd.ExecuteNonQuery();
                            }
                            ShowStatusMessage("Category has " + roomCount + " room(s) assigned to it. It has been deactivated instead of permanently deleted to preserve room associations.", false);
                            LoadCategories();
                            return;
                        }
                    }

                    // Delete category
                    string deleteSql = "DELETE FROM RoomCategories WHERE CategoryID = @CategoryId";
                    using (SqlCommand deleteCmd = new SqlCommand(deleteSql, con))
                    {
                        deleteCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        deleteCmd.ExecuteNonQuery();
                    }
                }

                ShowStatusMessage("Room category deleted successfully.", true);
                LoadCategories();
            }
            catch (Exception ex)
            {
                ShowStatusMessage("Error deleting category: " + ex.Message, false);
            }
        }
    }

    protected void gvCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvCategories.PageIndex = e.NewPageIndex;
        LoadCategories();
    }

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
