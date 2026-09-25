using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Admin_AddCategory : System.Web.UI.Page
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

            if (!string.IsNullOrEmpty(Request.QueryString["CategoryId"]))
            {
                int catId;
                if (int.TryParse(Request.QueryString["CategoryId"], out catId))
                {
                    LoadCategoryForEdit(catId);
                }
            }
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

    private void LoadCategoryForEdit(int categoryId)
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = "SELECT CategoryID, CategoryName, PublishingStatus FROM RoomCategories WHERE CategoryID = @CategoryId";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            hdnCategoryId.Value = dr["CategoryID"].ToString();
                            txtCategoryName.Text = dr["CategoryName"].ToString();
                            string status = dr["PublishingStatus"] != DBNull.Value ? dr["PublishingStatus"].ToString() : "Active";
                            ddlIsActive.SelectedValue = string.Equals(status, "Active", StringComparison.OrdinalIgnoreCase) ? "1" : "0";

                            pageTitleHeading.InnerText = "Edit Room Category: " + txtCategoryName.Text;
                            litBreadcrumb.Text = "Edit Category";
                            lblFormTitle.Text = "Edit Category Details";
                            btnSaveCategory.Text = "Update Category";
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error loading category: " + ex.Message, false);
        }
    }

    protected void btnSaveCategory_Click(object sender, EventArgs e)
    {
        string categoryName = txtCategoryName.Text.Trim().ToUpper();
        string publishingStatus = ddlIsActive.SelectedValue == "1" ? "Active" : "Inactive";
        int categoryId = 0;
        int.TryParse(hdnCategoryId.Value, out categoryId);

        if (string.IsNullOrWhiteSpace(categoryName))
        {
            ShowStatusMessage("Category Name is required. Please enter a valid room category name.", false);
            return;
        }

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (categoryId == 0)
                {
                    // Check duplicate
                    string checkSql = "SELECT COUNT(*) FROM RoomCategories WHERE UPPER(LTRIM(RTRIM(CategoryName))) = @CatName";
                    using (SqlCommand checkCmd = new SqlCommand(checkSql, con))
                    {
                        checkCmd.Parameters.AddWithValue("@CatName", categoryName);
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            ShowStatusMessage("A category with the name '" + categoryName + "' already exists in database.", false);
                            return;
                        }
                    }

                    // Insert new category into database
                    string insertSql = @"
                        INSERT INTO RoomCategories (CategoryName, PublishingStatus, CreatedAt)
                        VALUES (@CategoryName, @PublishingStatus, GETDATE())";

                    using (SqlCommand insertCmd = new SqlCommand(insertSql, con))
                    {
                        insertCmd.Parameters.AddWithValue("@CategoryName", categoryName);
                        insertCmd.Parameters.AddWithValue("@PublishingStatus", publishingStatus);
                        insertCmd.ExecuteNonQuery();
                    }

                    txtCategoryName.Text = "";
                    ddlIsActive.SelectedValue = "1";

                    ShowStatusMessage("Room Category '" + categoryName + "' has been successfully saved to database! It is now live in the system.", true);
                }
                else
                {
                    // Get old category name
                    string oldNameSql = "SELECT CategoryName FROM RoomCategories WHERE CategoryID = @CategoryId";
                    string oldCategoryName = "";
                    using (SqlCommand oldCmd = new SqlCommand(oldNameSql, con))
                    {
                        oldCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        object result = oldCmd.ExecuteScalar();
                        if (result != null) oldCategoryName = result.ToString();
                    }

                    // Check duplicate if name changed
                    if (!string.Equals(oldCategoryName, categoryName, StringComparison.OrdinalIgnoreCase))
                    {
                        string checkSql = "SELECT COUNT(*) FROM RoomCategories WHERE UPPER(LTRIM(RTRIM(CategoryName))) = @CatName AND CategoryID <> @CategoryId";
                        using (SqlCommand checkCmd = new SqlCommand(checkSql, con))
                        {
                            checkCmd.Parameters.AddWithValue("@CatName", categoryName);
                            checkCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                            int count = (int)checkCmd.ExecuteScalar();
                            if (count > 0)
                            {
                                ShowStatusMessage("Another category with the name '" + categoryName + "' already exists.", false);
                                return;
                            }
                        }
                    }

                    // Update category in database
                    string updateSql = @"
                        UPDATE RoomCategories 
                        SET CategoryName = @CategoryName,
                            PublishingStatus = @PublishingStatus,
                            UpdatedAt = GETDATE()
                        WHERE CategoryID = @CategoryId";

                    using (SqlCommand updateCmd = new SqlCommand(updateSql, con))
                    {
                        updateCmd.Parameters.AddWithValue("@CategoryName", categoryName);
                        updateCmd.Parameters.AddWithValue("@PublishingStatus", publishingStatus);
                        updateCmd.Parameters.AddWithValue("@CategoryId", categoryId);
                        updateCmd.ExecuteNonQuery();
                    }

                    // If category name changed, update associated rooms in Rooms table
                    if (!string.IsNullOrEmpty(oldCategoryName) && !string.Equals(oldCategoryName, categoryName, StringComparison.OrdinalIgnoreCase))
                    {
                        string updateRoomsSql = "UPDATE Rooms SET RoomCategory = @NewCategory WHERE UPPER(LTRIM(RTRIM(RoomCategory))) = @OldCategory";
                        using (SqlCommand updateRoomsCmd = new SqlCommand(updateRoomsSql, con))
                        {
                            updateRoomsCmd.Parameters.AddWithValue("@NewCategory", categoryName);
                            updateRoomsCmd.Parameters.AddWithValue("@OldCategory", oldCategoryName.ToUpper());
                            updateRoomsCmd.ExecuteNonQuery();
                        }
                    }

                    ShowStatusMessage("Room Category '" + categoryName + "' updated successfully in database!", true);
                }
            }
        }
        catch (Exception ex)
        {
            ShowStatusMessage("Error saving category to database: " + ex.Message, false);
        }
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
