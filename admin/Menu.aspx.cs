using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class Admin_Menu : System.Web.UI.Page
{
    // ==========================================
    // PAGE LOAD
    // ==========================================

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMenuItems();
        }
    }


    // ==========================================
    // LOAD DINING MENU ITEMS
    // ==========================================

    private void LoadMenuItems()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
                SELECT
                    MenuItemId,
                    Category,
                    ItemName,
                    Price,
                    DietaryType,
                    Badge,
                    Description,
                    PairingNote,
                    ImageUrl,
                    IsActive
                FROM MenuItems
                ORDER BY MenuItemId DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptMenuItems.DataSource = dt;
                    rptMenuItems.DataBind();

                    lblTotalCount.Text = dt.Rows.Count + (dt.Rows.Count == 1 ? " Dish" : " Dishes");

                    if (dt.Rows.Count == 0)
                    {
                        phEmptyState.Visible = true;
                    }
                    else
                    {
                        phEmptyState.Visible = false;
                    }
                }
            }
        }
    }


    // ==========================================
    // SAVE MENU ITEM (INSERT USER INPUT)
    // ==========================================

    protected void btnSaveMenuItem_Click(object sender, EventArgs e)
    {
        string savedFilePath = "";

        try
        {
            string dishName = txtDishName.Text.Trim();
            if (string.IsNullOrEmpty(dishName))
            {
                ShowError("Please enter the dish title / name.");
                return;
            }

            string category = ddlCategory.SelectedValue.Trim();
            if (string.IsNullOrEmpty(category))
            {
                ShowError("Please select a valid menu category.");
                return;
            }

            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim().Replace(",", ""), out price) || price < 0)
            {
                ShowError("Please enter a valid price (e.g. 850).");
                return;
            }

            string dietaryType = ddlDietaryType.SelectedValue.Trim();
            string badge = txtBadge.Text.Trim();
            string pairingNote = txtPairingNote.Text.Trim();

            string description = txtDescription.Text.Trim();
            if (string.IsNullOrEmpty(description))
            {
                ShowError("Please provide a short description for the dish.");
                return;
            }

            if (!fileDishImage.HasFile)
            {
                ShowError("Please select an image file for this dish.");
                return;
            }

            string extension = Path.GetExtension(fileDishImage.FileName).ToLower();
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".webp")
            {
                ShowError("Only JPG, JPEG, PNG, and WEBP image formats are allowed.");
                return;
            }

            if (fileDishImage.PostedFile.ContentLength > 10 * 1024 * 1024)
            {
                ShowError("Image size must be less than 10 MB.");
                return;
            }

            string folderPath = Server.MapPath("~/images/dining/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = "dish_" + Guid.NewGuid().ToString("N") + extension;
            savedFilePath = Path.Combine(folderPath, fileName);
            fileDishImage.SaveAs(savedFilePath);

            string imageUrl = "images/dining/" + fileName;

            string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO MenuItems
                    (Category, ItemName, Price, DietaryType, Badge, Description, PairingNote, ImageUrl, IsActive)
                    VALUES
                    (@Category, @ItemName, @Price, @DietaryType, @Badge, @Description, @PairingNote, @ImageUrl, 1)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 100).Value = category;
                    cmd.Parameters.Add("@ItemName", SqlDbType.NVarChar, 200).Value = dishName;
                    cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = price;
                    cmd.Parameters.Add("@DietaryType", SqlDbType.NVarChar, 100).Value = dietaryType;
                    cmd.Parameters.Add("@Badge", SqlDbType.NVarChar, 100).Value = string.IsNullOrEmpty(badge) ? (object)DBNull.Value : badge;
                    cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 500).Value = description.Length > 500 ? description.Substring(0, 500) : description;
                    cmd.Parameters.Add("@PairingNote", SqlDbType.NVarChar, 500).Value = string.IsNullOrEmpty(pairingNote) ? (object)DBNull.Value : (pairingNote.Length > 500 ? pairingNote.Substring(0, 500) : pairingNote);
                    cmd.Parameters.Add("@ImageUrl", SqlDbType.NVarChar, 500).Value = imageUrl;

                    con.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows <= 0)
                    {
                        if (File.Exists(savedFilePath))
                        {
                            File.Delete(savedFilePath);
                        }
                        ShowError("Failed to save menu dish into the database.");
                        return;
                    }
                }
            }

            // Reset form fields
            txtDishName.Text = "";
            txtPrice.Text = "";
            txtBadge.Text = "";
            txtPairingNote.Text = "";
            txtDescription.Text = "";

            LoadMenuItems();
            ShowSuccess("Dish Added Successfully!", "The menu item '" + dishName + "' has been saved to the database.");
        }
        catch (Exception ex)
        {
            if (!string.IsNullOrEmpty(savedFilePath) && File.Exists(savedFilePath))
            {
                try { File.Delete(savedFilePath); } catch { }
            }
            ShowError("Error saving menu dish: " + ex.Message);
        }
    }


    // ==========================================
    // REPEATER COMMAND (DELETE MENU ITEM)
    // ==========================================

    protected void rptMenuItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "DeleteMenuItem")
        {
            int menuItemId = Convert.ToInt32(e.CommandArgument);

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                string relativeImageUrl = "";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Step 1: Query image path
                    string selectQuery = "SELECT ImageUrl FROM MenuItems WHERE MenuItemId = @MenuItemId";
                    using (SqlCommand selectCmd = new SqlCommand(selectQuery, con))
                    {
                        selectCmd.Parameters.AddWithValue("@MenuItemId", menuItemId);
                        object res = selectCmd.ExecuteScalar();
                        if (res != null && res != DBNull.Value)
                        {
                            relativeImageUrl = res.ToString();
                        }
                    }

                    // Step 2: Delete from DB
                    string deleteQuery = "DELETE FROM MenuItems WHERE MenuItemId = @MenuItemId";
                    using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, con))
                    {
                        deleteCmd.Parameters.AddWithValue("@MenuItemId", menuItemId);
                        deleteCmd.ExecuteNonQuery();
                    }
                }

                // Step 3: Delete physical file if inside images/dining/
                if (!string.IsNullOrEmpty(relativeImageUrl) && relativeImageUrl.StartsWith("images/dining/"))
                {
                    string physicalPath = Server.MapPath("~/" + relativeImageUrl);
                    if (File.Exists(physicalPath))
                    {
                        try { File.Delete(physicalPath); } catch { }
                    }
                }

                LoadMenuItems();
                ShowSuccess("Dish Deleted Successfully!", "The menu dish has been removed from the database.");
            }
            catch (Exception ex)
            {
                ShowError("Error deleting menu item: " + ex.Message);
            }
        }
    }


    // ==========================================
    // NOTIFICATION BANNERS (NO JS ALERT POPUPS)
    // ==========================================

    private void ShowSuccess(string title, string message)
    {
        pnlErrorMessage.Visible = false;
        pnlSuccessMessage.Visible = true;
        lblSuccessTitle.Text = title;
        lblSuccessMessage.Text = message;
    }

    private void ShowError(string message)
    {
        pnlSuccessMessage.Visible = false;
        pnlErrorMessage.Visible = true;
        lblErrorMessage.Text = message;
    }


    // ==========================================
    // CATEGORY DISPLAY NAME HELPER
    // ==========================================

    public string GetCategoryDisplayName(object categoryObj)
    {
        if (categoryObj == null) return "";
        string cat = categoryObj.ToString().ToLower();
        switch (cat)
        {
            case "kebabs": return "Starters & Kebabs";
            case "mains": return "Royal Curries";
            case "biryani": return "Dum Biryani";
            case "breads": return "Breads & Naan";
            case "desserts": return "Mithai & Desserts";
            case "beverages": return "Beverages & Chai";
            default: return categoryObj.ToString();
        }
    }
}
