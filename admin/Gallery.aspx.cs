using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class Admin_Gallery : System.Web.UI.Page
{
    // ==========================================
    // PAGE LOAD
    // ==========================================

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateGalleryCategories();
            LoadGalleryPhotos();
        }
    }

    private void PopulateGalleryCategories()
    {
        string selectedVal = ddlCategory.SelectedValue;
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new ListItem("Rooms", "Rooms"));
        ddlCategory.Items.Add(new ListItem("Amenities", "Amenities"));
        ddlCategory.Items.Add(new ListItem("Dining", "Dining"));
        ddlCategory.Items.Add(new ListItem("Exterior", "Exterior"));

        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (!string.IsNullOrEmpty(connectionString))
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT DISTINCT Category FROM GalleryPhotos WHERE Category IS NOT NULL AND LTRIM(RTRIM(Category)) <> '' ORDER BY Category", con))
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
    // LOAD GALLERY PHOTOS
    // ==========================================

    private void LoadGalleryPhotos()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
            ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
            : "";

        if (string.IsNullOrEmpty(connectionString)) return;

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            string query = @"
                SELECT
                    GalleryId,
                    PhotoTitle,
                    Category,
                    ImageUrl,
                    ISNULL(IsActive, 1) AS IsActive
                FROM GalleryPhotos
                ORDER BY GalleryId DESC";

            DataTable dt = new DataTable();
            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                da.Fill(dt);
                gvAdminGallery.DataSource = dt;
                gvAdminGallery.DataBind();
            }

            int totalCount = dt.Rows.Count;
            int activeCount = 0;
            using (SqlCommand cmdAct = new SqlCommand("SELECT COUNT(*) FROM GalleryPhotos WHERE ISNULL(IsActive, 1) = 1", con))
            {
                activeCount = Convert.ToInt32(cmdAct.ExecuteScalar());
            }

            if (lblGalleryCountPill != null)
            {
                lblGalleryCountPill.InnerHtml = "<i class=\"bi bi-shield-check me-1\"></i> " + activeCount + " Photos Active";
            }

            if (kpiTotalPhotos != null)
            {
                kpiTotalPhotos.InnerText = totalCount.ToString();
            }

            if (kpiLivePhotos != null)
            {
                kpiLivePhotos.InnerText = activeCount + " Active";
            }

            using (SqlCommand cmdCat = new SqlCommand("SELECT COUNT(DISTINCT Category) FROM GalleryPhotos WHERE ISNULL(IsActive, 1) = 1 AND Category IS NOT NULL AND LTRIM(RTRIM(Category)) <> ''", con))
            {
                int categoriesCount = Convert.ToInt32(cmdCat.ExecuteScalar());
                if (kpiTotalCategories != null)
                {
                    kpiTotalCategories.InnerText = categoriesCount + (categoriesCount == 1 ? " Category" : " Categories");
                }
            }

            using (SqlCommand cmdTopCat = new SqlCommand("SELECT TOP 1 Category FROM GalleryPhotos WHERE ISNULL(IsActive, 1) = 1 GROUP BY Category ORDER BY COUNT(*) DESC", con))
            {
                object result = cmdTopCat.ExecuteScalar();
                string topCategory = (result != null && result != DBNull.Value) ? result.ToString() : "None";
                if (kpiTopCategory != null)
                {
                    kpiTopCategory.InnerText = GetCategoryDisplayName(topCategory);
                }
            }
        }
    }


    // ==========================================
    // GRIDVIEW PAGING & ROW DATA BOUND
    // ==========================================

    protected void gvAdminGallery_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAdminGallery.PageIndex = e.NewPageIndex;
        LoadGalleryPhotos();
    }

    protected void gvAdminGallery_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.CssClass += " gallery-photo-row";
            DataRowView drv = e.Row.DataItem as DataRowView;
            if (drv != null)
            {
                string category = drv["Category"] != DBNull.Value ? drv["Category"].ToString().Trim().ToUpper() : "";
                string title = drv["PhotoTitle"] != DBNull.Value ? drv["PhotoTitle"].ToString().Trim().ToLower() : "";
                e.Row.Attributes["data-category"] = category;
                e.Row.Attributes["data-title"] = title;
            }
        }
    }


    // ==========================================
    // BULK DELETE SELECTED PHOTOS
    // ==========================================

    protected void btnBulkDeletePhotos_Click(object sender, EventArgs e)
    {
        int deletedCount = 0;
        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

        foreach (GridViewRow row in gvAdminGallery.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chkPhotoSelect");
            if (chk != null && chk.Checked)
            {
                int galleryId = Convert.ToInt32(gvAdminGallery.DataKeys[row.RowIndex].Value);
                string relativeImageUrl = "";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();
                    string selectQuery = "SELECT ImageUrl FROM GalleryPhotos WHERE GalleryId = @GalleryId";
                    using (SqlCommand selectCmd = new SqlCommand(selectQuery, con))
                    {
                        selectCmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        object res = selectCmd.ExecuteScalar();
                        if (res != null && res != DBNull.Value) relativeImageUrl = res.ToString();
                    }

                    string deleteQuery = "DELETE FROM GalleryPhotos WHERE GalleryId = @GalleryId";
                    using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, con))
                    {
                        deleteCmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        deleteCmd.ExecuteNonQuery();
                        deletedCount++;
                    }
                }

                if (!string.IsNullOrEmpty(relativeImageUrl))
                {
                    string physicalPath = Server.MapPath("~/" + relativeImageUrl);
                    if (File.Exists(physicalPath))
                    {
                        try { File.Delete(physicalPath); } catch { }
                    }
                }
            }
        }

        LoadGalleryPhotos();
        if (deletedCount > 0)
        {
            ShowSuccess("Photos Deleted Successfully!", deletedCount + " gallery photo(s) deleted successfully.");
        }
        else
        {
            ShowError("Please select at least one photo checkbox from the table to delete.");
        }
    }


    // ==========================================
    // UPLOAD / UPDATE GALLERY PHOTO
    // ==========================================

    protected void btnUploadGallery_Click(object sender, EventArgs e)
    {
        int editGalleryId = 0;
        int.TryParse(hdnEditGalleryId.Value, out editGalleryId);

        string savedFilePath = "";

        try
        {
            string photoTitle = txtPhotoTitle.Text.Trim();
            if (string.IsNullOrEmpty(photoTitle))
            {
                ShowError("Please enter a photo title.");
                return;
            }

            string category = ddlCategory.SelectedValue.Trim();
            if (category == "__NEW__" || category == "NEW" || !string.IsNullOrWhiteSpace(txtNewCategory.Text))
            {
                category = txtNewCategory.Text.Trim();
            }

            if (string.IsNullOrEmpty(category))
            {
                ShowError("Please select or enter a category.");
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

            if (editGalleryId > 0)
            {
                // ================= UPDATE EXISTING PHOTO =================
                if (fileImage.HasFile)
                {
                    string extension = Path.GetExtension(fileImage.FileName).ToLower();
                    if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".webp")
                    {
                        ShowError("Only JPG, JPEG, PNG, and WEBP image formats are allowed.");
                        return;
                    }

                    if (fileImage.PostedFile.ContentLength > 10 * 1024 * 1024)
                    {
                        ShowError("Image size must be less than 10 MB.");
                        return;
                    }

                    string folderPath = Server.MapPath("~/images/gallery/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = Guid.NewGuid().ToString("N") + extension;
                    savedFilePath = Path.Combine(folderPath, fileName);
                    fileImage.SaveAs(savedFilePath);
                    string newImageUrl = "images/gallery/" + fileName;

                    // Fetch old image to delete physical file
                    string oldImageUrl = "";
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();
                        using (SqlCommand cmdOld = new SqlCommand("SELECT ImageUrl FROM GalleryPhotos WHERE GalleryId = @GalleryId", con))
                        {
                            cmdOld.Parameters.AddWithValue("@GalleryId", editGalleryId);
                            object res = cmdOld.ExecuteScalar();
                            if (res != null && res != DBNull.Value) oldImageUrl = res.ToString();
                        }

                        using (SqlCommand cmdUpdate = new SqlCommand("UPDATE GalleryPhotos SET PhotoTitle = @PhotoTitle, Category = @Category, ImageUrl = @ImageUrl, IsActive = @IsActive WHERE GalleryId = @GalleryId", con))
                        {
                            cmdUpdate.Parameters.AddWithValue("@PhotoTitle", photoTitle);
                            cmdUpdate.Parameters.AddWithValue("@Category", category);
                            cmdUpdate.Parameters.AddWithValue("@ImageUrl", newImageUrl);
                            cmdUpdate.Parameters.AddWithValue("@IsActive", ddlIsActive.SelectedValue == "1");
                            cmdUpdate.Parameters.AddWithValue("@GalleryId", editGalleryId);
                            cmdUpdate.ExecuteNonQuery();
                        }
                    }

                    if (!string.IsNullOrEmpty(oldImageUrl))
                    {
                        string oldPhysicalPath = Server.MapPath("~/" + oldImageUrl);
                        if (File.Exists(oldPhysicalPath))
                        {
                            try { File.Delete(oldPhysicalPath); } catch { }
                        }
                    }
                }
                else
                {
                    // Update title & category only (keep existing image file)
                    using (SqlConnection con = new SqlConnection(connectionString))
                    {
                        con.Open();
                        using (SqlCommand cmdUpdate = new SqlCommand("UPDATE GalleryPhotos SET PhotoTitle = @PhotoTitle, Category = @Category, IsActive = @IsActive WHERE GalleryId = @GalleryId", con))
                        {
                            cmdUpdate.Parameters.AddWithValue("@PhotoTitle", photoTitle);
                            cmdUpdate.Parameters.AddWithValue("@Category", category);
                            cmdUpdate.Parameters.AddWithValue("@IsActive", ddlIsActive.SelectedValue == "1");
                            cmdUpdate.Parameters.AddWithValue("@GalleryId", editGalleryId);
                            cmdUpdate.ExecuteNonQuery();
                        }
                    }
                }

                ResetEditMode();
                PopulateGalleryCategories();
                LoadGalleryPhotos();
                ShowSuccess("Photo Updated Successfully!", "Gallery photo details updated successfully.");
            }
            else
            {
                // ================= INSERT NEW PHOTO =================
                if (!fileImage.HasFile)
                {
                    ShowError("Please select an image file to upload.");
                    return;
                }

                string extension = Path.GetExtension(fileImage.FileName).ToLower();
                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".webp")
                {
                    ShowError("Only JPG, JPEG, PNG, and WEBP image formats are allowed.");
                    return;
                }

                if (fileImage.PostedFile.ContentLength > 10 * 1024 * 1024)
                {
                    ShowError("Image size must be less than 10 MB.");
                    return;
                }

                string folderPath = Server.MapPath("~/images/gallery/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Guid.NewGuid().ToString("N") + extension;
                savedFilePath = Path.Combine(folderPath, fileName);
                fileImage.SaveAs(savedFilePath);

                string imageUrl = "images/gallery/" + fileName;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"
                        INSERT INTO GalleryPhotos
                        (PhotoTitle, Category, ImageUrl, IsActive)
                        VALUES
                        (@PhotoTitle, @Category, @ImageUrl, @IsActive)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@PhotoTitle", SqlDbType.NVarChar, 200).Value = photoTitle;
                        cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 50).Value = category;
                        cmd.Parameters.Add("@ImageUrl", SqlDbType.NVarChar, 500).Value = imageUrl;
                        cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = (ddlIsActive.SelectedValue == "1");

                        con.Open();
                        int rowsInserted = cmd.ExecuteNonQuery();

                        if (rowsInserted <= 0)
                        {
                            if (File.Exists(savedFilePath))
                            {
                                File.Delete(savedFilePath);
                            }
                            ShowError("Failed to save image record into database.");
                            return;
                        }
                    }
                }

                ResetEditMode();
                PopulateGalleryCategories();
                LoadGalleryPhotos();
                ShowSuccess("Photo Uploaded Successfully!", "Gallery photo uploaded and saved successfully.");
            }
        }
        catch (Exception ex)
        {
            if (!string.IsNullOrEmpty(savedFilePath) && File.Exists(savedFilePath))
            {
                try { File.Delete(savedFilePath); } catch { }
            }
            ShowError("Error: " + ex.Message);
        }
    }

    protected void btnCancelEdit_Click(object sender, EventArgs e)
    {
        ResetEditMode();
    }

    private void ResetEditMode()
    {
        hdnEditGalleryId.Value = "0";
        txtPhotoTitle.Text = "";
        txtNewCategory.Text = "";
        if (ddlCategory.Items.Count > 0) ddlCategory.SelectedIndex = 0;
        btnUploadGallery.Text = "Upload Photo";
        lblFormTitle.Text = "Upload Gallery Photo Form";
        btnCancelEdit.Visible = false;
    }


    protected void gvAdminGallery_PreRender(object sender, EventArgs e)
    {
        if (gvAdminGallery.HeaderRow != null)
        {
            gvAdminGallery.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }


    // ==========================================
    // GRIDVIEW ROW COMMAND (EDIT & DELETE PHOTO)
    // ==========================================

    protected void gvAdminGallery_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ToggleStatus")
        {
            int galleryId = Convert.ToInt32(e.CommandArgument);
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string sql = "UPDATE GalleryPhotos SET IsActive = CASE WHEN ISNULL(IsActive, 1) = 1 THEN 0 ELSE 1 END WHERE GalleryId = @GalleryId";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                LoadGalleryPhotos();
                ShowSuccess("Status Updated!", "Gallery photo active status toggled successfully.");
            }
            catch (Exception ex)
            {
                ShowError("Error updating photo status: " + ex.Message);
            }
        }
        else if (e.CommandName == "EditPhoto")
        {
            int galleryId = Convert.ToInt32(e.CommandArgument);
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT PhotoTitle, Category, ISNULL(IsActive, 1) AS IsActive FROM GalleryPhotos WHERE GalleryId = @GalleryId";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        con.Open();
                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                txtPhotoTitle.Text = dr["PhotoTitle"] != DBNull.Value ? dr["PhotoTitle"].ToString() : "";
                                string cat = dr["Category"] != DBNull.Value ? dr["Category"].ToString().Trim() : "";
                                if (!string.IsNullOrEmpty(cat))
                                {
                                    if (ddlCategory.Items.FindByValue(cat) == null)
                                    {
                                        int insertIdx = Math.Max(0, ddlCategory.Items.Count - 1);
                                        ddlCategory.Items.Insert(insertIdx, new ListItem(cat, cat));
                                    }
                                    ddlCategory.SelectedValue = cat;
                                }
                                txtNewCategory.Text = "";
                                bool isAct = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                                ddlIsActive.SelectedValue = isAct ? "1" : "0";

                                hdnEditGalleryId.Value = galleryId.ToString();
                                btnUploadGallery.Text = "Update Photo";
                                lblFormTitle.Text = "Edit Photo Details (ID #" + galleryId + ")";
                                btnCancelEdit.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading photo for edit: " + ex.Message);
            }
        }
        else if (e.CommandName == "DeletePhoto")
        {
            int galleryId = Convert.ToInt32(e.CommandArgument);

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;
                string relativeImageUrl = "";

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Step 1: Fetch ImageUrl to delete physical file
                    string selectQuery = "SELECT ImageUrl FROM GalleryPhotos WHERE GalleryId = @GalleryId";
                    using (SqlCommand selectCmd = new SqlCommand(selectQuery, con))
                    {
                        selectCmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        object result = selectCmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            relativeImageUrl = result.ToString();
                        }
                    }

                    // Step 2: Delete DB record
                    string deleteQuery = "DELETE FROM GalleryPhotos WHERE GalleryId = @GalleryId";
                    using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, con))
                    {
                        deleteCmd.Parameters.AddWithValue("@GalleryId", galleryId);
                        deleteCmd.ExecuteNonQuery();
                    }
                }

                // Step 3: Delete physical file if exists
                if (!string.IsNullOrEmpty(relativeImageUrl))
                {
                    string physicalPath = Server.MapPath("~/" + relativeImageUrl);
                    if (File.Exists(physicalPath))
                    {
                        try { File.Delete(physicalPath); } catch { }
                    }
                }

                ResetEditMode();
                LoadGalleryPhotos();
                ShowSuccess("Photo Deleted Successfully!", "Gallery photo deleted successfully from database and server.");
            }
            catch (Exception ex)
            {
                ShowError("Error deleting photo: " + ex.Message);
            }
        }
    }


    // ==========================================
    // SHOW CONFIRMATION BANNERS (NO JS ALERT POPUP)
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
    // CATEGORY DISPLAY NAME
    // ==========================================

    public string GetCategoryDisplayName(object categoryObj)
    {
        if (categoryObj == null) return "";
        string cat = categoryObj.ToString();
        switch (cat.ToLower())
        {
            case "rooms": return "Rooms";
            case "amenities": return "Amenities";
            case "dining": return "Dining";
            case "exterior": return "Exterior";
            default: return cat;
        }
    }
}