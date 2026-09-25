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
            PopulateMenuCategories();
            LoadMenuItems();
        }
    }

    private void PopulateMenuCategories()
    {
        string selectedVal = ddlCategory.SelectedValue;
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new ListItem("Tandoori Starters & Kebabs", "kebabs"));
        ddlCategory.Items.Add(new ListItem("Royal Indian Curries", "mains"));
        ddlCategory.Items.Add(new ListItem("Dum Biryani & Rice", "biryani"));
        ddlCategory.Items.Add(new ListItem("Tandoori Breads & Naan", "breads"));
        ddlCategory.Items.Add(new ListItem("Traditional Mithai & Desserts", "desserts"));
        ddlCategory.Items.Add(new ListItem("Chai, Lassi & Beverages", "beverages"));

        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!string.IsNullOrEmpty(connectionString))
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT Category FROM MenuItems WHERE Category IS NOT NULL AND LTRIM(RTRIM(Category)) <> '' ORDER BY Category", con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string cat = dr["Category"].ToString().Trim();
                            if (ddlCategory.Items.FindByValue(cat) == null && ddlCategory.Items.FindByText(cat) == null)
                            {
                                ddlCategory.Items.Add(new ListItem(cat, cat));
                            }
                        }
                    }
                }
            }
        }

        ddlCategory.Items.Add(new ListItem("+ Add New Category...", "__NEW__"));

        if (!string.IsNullOrEmpty(selectedVal) && ddlCategory.Items.FindByValue(selectedVal) != null)
        {
            ddlCategory.SelectedValue = selectedVal;
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
    // SAVE / UPDATE MENU ITEM
    // ==========================================

    protected void btnSaveMenuItem_Click(object sender, EventArgs e)
    {
        string savedFilePath = "";
        int editId = 0;
        int.TryParse(hdnEditMenuItemId.Value, out editId);
        bool isEditMode = (editId > 0);

        try
        {
            string dishName = txtDishName.Text.Trim();
            if (string.IsNullOrEmpty(dishName))
            {
                ShowError("Please enter the dish title / name.");
                return;
            }

            string category = ddlCategory.SelectedValue.Trim();
            if (category == "__NEW__" || category == "NEW" || !string.IsNullOrWhiteSpace(txtNewCategory.Text))
            {
                category = txtNewCategory.Text.Trim();
            }

            if (string.IsNullOrEmpty(category))
            {
                ShowError("Please select or enter a valid menu category.");
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

            // Image file handling
            bool hasNewFile = fileDishImage.HasFile;
            if (!isEditMode && !hasNewFile)
            {
                ShowError("Please select an image file for this dish.");
                return;
            }

            string imageUrl = "";

            if (hasNewFile)
            {
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
                imageUrl = "images/dining/" + fileName;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (isEditMode)
                {
                    // If uploading new image, retrieve old image path to delete after update
                    string oldImageUrl = "";
                    if (hasNewFile)
                    {
                        string selectOld = "SELECT ImageUrl FROM MenuItems WHERE MenuItemId = @MenuItemId";
                        using (SqlCommand cmdOld = new SqlCommand(selectOld, con))
                        {
                            cmdOld.Parameters.AddWithValue("@MenuItemId", editId);
                            object res = cmdOld.ExecuteScalar();
                            if (res != null && res != DBNull.Value)
                            {
                                oldImageUrl = res.ToString();
                            }
                        }
                    }

                    string updateQuery = @"
                        UPDATE MenuItems
                        SET Category = @Category,
                            ItemName = @ItemName,
                            Price = @Price,
                            DietaryType = @DietaryType,
                            Badge = @Badge,
                            Description = @Description,
                            PairingNote = @PairingNote,
                            IsActive = @IsActive"
                        + (hasNewFile ? ", ImageUrl = @ImageUrl" : "") +
                        " WHERE MenuItemId = @MenuItemId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 100).Value = category;
                        cmd.Parameters.Add("@ItemName", SqlDbType.NVarChar, 200).Value = dishName;
                        cmd.Parameters.Add("@Price", SqlDbType.Decimal).Value = price;
                        cmd.Parameters.Add("@DietaryType", SqlDbType.NVarChar, 100).Value = dietaryType;
                        cmd.Parameters.Add("@Badge", SqlDbType.NVarChar, 100).Value = string.IsNullOrEmpty(badge) ? (object)DBNull.Value : badge;
                        cmd.Parameters.Add("@Description", SqlDbType.NVarChar, 500).Value = description.Length > 500 ? description.Substring(0, 500) : description;
                        cmd.Parameters.Add("@PairingNote", SqlDbType.NVarChar, 500).Value = string.IsNullOrEmpty(pairingNote) ? (object)DBNull.Value : (pairingNote.Length > 500 ? pairingNote.Substring(0, 500) : pairingNote);
                        cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = (ddlIsActive.SelectedValue == "1");
                        if (hasNewFile)
                        {
                            cmd.Parameters.Add("@ImageUrl", SqlDbType.NVarChar, 500).Value = imageUrl;
                        }
                        cmd.Parameters.Add("@MenuItemId", SqlDbType.Int).Value = editId;

                        int rows = cmd.ExecuteNonQuery();

                        if (rows <= 0)
                        {
                            if (!string.IsNullOrEmpty(savedFilePath) && File.Exists(savedFilePath))
                            {
                                try { File.Delete(savedFilePath); } catch { }
                            }
                            ShowError("Failed to update menu dish in the database.");
                            return;
                        }
                    }

                    // Delete old image file if replaced
                    if (hasNewFile && !string.IsNullOrEmpty(oldImageUrl) && oldImageUrl.StartsWith("images/dining/"))
                    {
                        string oldPhysicalPath = Server.MapPath("~/" + oldImageUrl);
                        if (File.Exists(oldPhysicalPath))
                        {
                            try { File.Delete(oldPhysicalPath); } catch { }
                        }
                    }

                    ResetEditMode();
                    PopulateMenuCategories();
                    LoadMenuItems();
                    ShowSuccess("Dish Updated Successfully!", "The menu item '" + dishName + "' has been updated in the database.");
                }
                else
                {
                    // INSERT new menu item
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
                        cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = (ddlIsActive.SelectedValue == "1");

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

                    ResetEditMode();
                    PopulateMenuCategories();
                    LoadMenuItems();
                    ShowSuccess("Dish Added Successfully!", "The menu item '" + dishName + "' has been saved to the database.");
                }
            }
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
    // REPEATER COMMAND (EDIT & DELETE MENU ITEM)
    // ==========================================

    protected void rptMenuItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int menuItemId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ToggleStatusMenuItem")
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string sql = "UPDATE MenuItems SET IsActive = CASE WHEN ISNULL(IsActive, 1) = 1 THEN 0 ELSE 1 END WHERE MenuItemId = @MenuItemId";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@MenuItemId", menuItemId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadMenuItems();
                ShowSuccess("Status Updated!", "Dining dish active status toggled successfully.");
            }
            catch (Exception ex)
            {
                ShowError("Error updating status: " + ex.Message);
            }
        }
        else if (e.CommandName == "EditMenuItem")
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT MenuItemId, Category, ItemName, Price, DietaryType, Badge, Description, PairingNote, ImageUrl, ISNULL(IsActive, 1) AS IsActive FROM MenuItems WHERE MenuItemId = @MenuItemId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@MenuItemId", menuItemId);
                        con.Open();
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            if (dt.Rows.Count > 0)
                            {
                                DataRow dr = dt.Rows[0];
                                txtDishName.Text = dr["ItemName"].ToString();
                                txtPrice.Text = Convert.ToDecimal(dr["Price"]).ToString("0.##");
                                txtBadge.Text = dr["Badge"] != DBNull.Value ? dr["Badge"].ToString() : "";
                                txtPairingNote.Text = dr["PairingNote"] != DBNull.Value ? dr["PairingNote"].ToString() : "";
                                txtDescription.Text = dr["Description"].ToString();

                                string cat = dr["Category"].ToString().Trim();
                                if (!string.IsNullOrEmpty(cat))
                                {
                                    if (ddlCategory.Items.FindByValue(cat) == null && ddlCategory.Items.FindByText(cat) == null)
                                    {
                                        int insertIdx = Math.Max(0, ddlCategory.Items.Count - 1);
                                        ddlCategory.Items.Insert(insertIdx, new ListItem(cat, cat));
                                    }
                                    if (ddlCategory.Items.FindByValue(cat) != null)
                                    {
                                        ddlCategory.SelectedValue = cat;
                                    }
                                }
                                txtNewCategory.Text = "";

                                string dietary = dr["DietaryType"].ToString();
                                if (ddlDietaryType.Items.FindByValue(dietary) != null)
                                {
                                    ddlDietaryType.SelectedValue = dietary;
                                }

                                bool isAct = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                                ddlIsActive.SelectedValue = isAct ? "1" : "0";

                                hdnEditMenuItemId.Value = menuItemId.ToString();
                                lblFormTitle.Text = "Edit Dining Menu Dish (ID #" + menuItemId + ")";
                                btnSaveMenuItem.Text = "Update Menu Dish";
                                btnCancelEdit.Visible = true;
                                lblImageReq.Text = " (Optional)";

                                ShowSuccess("Edit Mode Active", "Loaded details for '" + txtDishName.Text + "'. Make your changes and click Update Menu Dish.");
                            }
                            else
                            {
                                ShowError("Dish not found in database.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading dish for edit: " + ex.Message);
            }
        }
        else if (e.CommandName == "DeleteMenuItem")
        {
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

                if (hdnEditMenuItemId.Value == menuItemId.ToString())
                {
                    ResetEditMode();
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
    // CANCEL EDIT & RESET FORM
    // ==========================================

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        ResetEditMode();
        pnlSuccessMessage.Visible = false;
        pnlErrorMessage.Visible = false;
    }

    private void ResetEditMode()
    {
        hdnEditMenuItemId.Value = "0";
        lblFormTitle.Text = "Add New Dining Menu Dish";
        btnSaveMenuItem.Text = "Save Menu Dish";
        btnCancelEdit.Visible = false;
        lblImageReq.Text = "*";

        txtDishName.Text = "";
        txtPrice.Text = "";
        txtBadge.Text = "";
        txtPairingNote.Text = "";
        txtDescription.Text = "";
        txtNewCategory.Text = "";
        if (ddlCategory.Items.Count > 0) ddlCategory.SelectedIndex = 0;
        if (ddlDietaryType.Items.Count > 0) ddlDietaryType.SelectedIndex = 0;
        if (ddlIsActive.Items.Count > 0) ddlIsActive.SelectedIndex = 0;
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
