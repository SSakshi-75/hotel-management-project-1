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
            LoadGalleryPhotos();
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
            string query = @"
                SELECT
                    GalleryId,
                    PhotoTitle,
                    Category,
                    ImageUrl
                FROM GalleryPhotos
                WHERE IsActive = 1
                ORDER BY GalleryId DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    rptAdminGallery.DataSource = dr;
                    rptAdminGallery.DataBind();
                }
            }
        }
    }


    // ==========================================
    // UPLOAD GALLERY PHOTO
    // ==========================================

    protected void btnUploadGallery_Click(object sender, EventArgs e)
    {
        string savedFilePath = "";

        try
        {
            if (!fileImage.HasFile)
            {
                ShowError("Please select an image file to upload.");
                return;
            }

            string photoTitle = txtPhotoTitle.Text.Trim();
            if (string.IsNullOrEmpty(photoTitle))
            {
                ShowError("Please enter a photo title.");
                return;
            }

            string category = ddlCategory.SelectedValue.Trim();
            if (string.IsNullOrEmpty(category))
            {
                ShowError("Please select a category.");
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

            string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

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
                    cmd.Parameters.Add("@IsActive", SqlDbType.Bit).Value = true;

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

            txtPhotoTitle.Text = "";
            ddlCategory.SelectedIndex = 0;
            LoadGalleryPhotos();
            ShowSuccess("Photo Uploaded Successfully!", "Gallery photo uploaded and saved successfully.");
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


    // ==========================================
    // REPEATER ITEM COMMAND (DELETE PHOTO)
    // ==========================================

    protected void rptAdminGallery_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "DeletePhoto")
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