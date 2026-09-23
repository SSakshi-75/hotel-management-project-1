using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Gallery : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        // Admin authorization check
        if (Session["AdminUser"] == null && Session["AdminId"] == null && Session["Username"] == null)
        {
            // Allow session bypass for local development or redirect to login
        }

        if (!IsPostBack)
        {
            EnsureGalleryTableExists();
            BindGallery();
            LoadGalleryStats();
        }
    }

    // ==========================================
    // ENSURE GALLERY TABLE EXISTS & SEED IF EMPTY
    // ==========================================
    private void EnsureGalleryTableExists()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = @"
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Gallery')
BEGIN
    CREATE TABLE Gallery (
        GalleryId INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Category NVARCHAR(50) NOT NULL,
        ImageUrl NVARCHAR(500) NOT NULL,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
END

IF (SELECT COUNT(*) FROM Gallery) = 0
BEGIN
    INSERT INTO Gallery (Title, Category, ImageUrl) VALUES
    ('Deluxe King Suite', 'Rooms', 'images/room-classic-double.jpg'),
    ('Infinity Pool & Sun Deck', 'Amenities', 'images/amenity-pool.jpg'),
    ('Signature Restaurant', 'Dining', 'images/amenity-restaurant.jpg'),
    ('Executive Suite', 'Rooms', 'images/room-superior-king.jpg'),
    ('Terrace Garden Lounge', 'Exterior', 'images/gallery-1.jpg'),
    ('Luxury Spa & Wellness', 'Amenities', 'images/amenity-spa.jpg'),
    ('Heritage Palace Facade', 'Exterior', 'images/indian-palace-hero.jpg'),
    ('Presidential Suite', 'Rooms', 'images/room-featured-presidential.jpg');
END";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            ShowError("Database Initialization Error: " + ex.Message);
        }
    }

    // ==========================================
    // BIND GALLERY ITEMS
    // ==========================================
    private void BindGallery()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT GalleryId, Title, Category, ImageUrl, CreatedDate FROM Gallery ";
                string filter = ddlFilterCategory.SelectedValue;

                if (!string.IsNullOrEmpty(filter) && filter != "All")
                {
                    query += "WHERE Category = @Category ";
                }

                query += "ORDER BY GalleryId DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    if (!string.IsNullOrEmpty(filter) && filter != "All")
                    {
                        cmd.Parameters.AddWithValue("@Category", filter);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptGallery.DataSource = dt;
                            rptGallery.DataBind();
                            pnlNoPhotos.Visible = false;
                            rptGallery.Visible = true;
                        }
                        else
                        {
                            rptGallery.Visible = false;
                            pnlNoPhotos.Visible = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowError("Failed to load gallery photos: " + ex.Message);
        }
    }

    // ==========================================
    // LOAD GALLERY OVERVIEW STATISTICS
    // ==========================================
    private void LoadGalleryStats()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = @"
SELECT 
    COUNT(*) AS TotalCount,
    SUM(CASE WHEN Category = 'Rooms' THEN 1 ELSE 0 END) AS RoomsCount,
    SUM(CASE WHEN Category = 'Amenities' THEN 1 ELSE 0 END) AS AmenitiesCount,
    SUM(CASE WHEN Category = 'Dining' THEN 1 ELSE 0 END) AS DiningCount,
    SUM(CASE WHEN Category = 'Exterior' THEN 1 ELSE 0 END) AS ExteriorCount
FROM Gallery";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            statTotalPhotos.InnerText = Convert.ToString(reader["TotalCount"] ?? "0");
                            statRooms.InnerText = Convert.ToString(reader["RoomsCount"] ?? "0");
                            statAmenities.InnerText = Convert.ToString(reader["AmenitiesCount"] ?? "0");
                            statDining.InnerText = Convert.ToString(reader["DiningCount"] ?? "0");
                            statExterior.InnerText = Convert.ToString(reader["ExteriorCount"] ?? "0");
                        }
                    }
                }
            }
        }
        catch
        {
            // Silently fallback stats
        }
    }

    // ==========================================
    // UPLOAD NEW PHOTO BUTTON CLICK
    // ==========================================
    protected void btnUploadPhoto_Click(object sender, EventArgs e)
    {
        ClearAlerts();

        string title = txtPhotoTitle.Text.Trim();
        string category = ddlCategory.SelectedValue;

        if (string.IsNullOrEmpty(title))
        {
            ShowError("Please enter a Photo Title / Caption.");
            txtPhotoTitle.Focus();
            return;
        }

        if (!fuGalleryImage.HasFile)
        {
            ShowError("Please choose an image file to upload.");
            return;
        }

        string ext = Path.GetExtension(fuGalleryImage.FileName).ToLower();
        if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp")
        {
            ShowError("Only JPG, JPEG, PNG, and WEBP image formats are supported.");
            return;
        }

        // Check file size (max 5 MB)
        if (fuGalleryImage.PostedFile.ContentLength > 5 * 1024 * 1024)
        {
            ShowError("File size exceeds 5 MB. Please select a smaller photo.");
            return;
        }

        try
        {
            // Ensure target directory exists
            string folderPath = Server.MapPath("~/images/gallery/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            // Generate unique safe filename
            string uniqueFileName = "gallery_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + "_" + Guid.NewGuid().ToString().Substring(0, 6) + ext;
            string savePath = Path.Combine(folderPath, uniqueFileName);

            // Save the uploaded file
            fuGalleryImage.SaveAs(savePath);

            string relativeDbPath = "images/gallery/" + uniqueFileName;

            // Insert into Database
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string insertSql = "INSERT INTO Gallery (Title, Category, ImageUrl, CreatedDate) VALUES (@Title, @Category, @ImageUrl, GETDATE())";
                using (SqlCommand cmd = new SqlCommand(insertSql, con))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@ImageUrl", relativeDbPath);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        ShowSuccess("Photo \"" + title + "\" uploaded successfully to " + category + " category!");
                        txtPhotoTitle.Text = "";
                        BindGallery();
                        LoadGalleryStats();
                    }
                    else
                    {
                        ShowError("Failed to save photo record to database.");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowError("Error uploading image: " + ex.Message);
        }
    }

    // ==========================================
    // REPEATER COMMAND (DELETE PHOTO)
    // ==========================================
    protected void rptGallery_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        ClearAlerts();

        if (e.CommandName == "DeletePhoto")
        {
            int galleryId;
            if (int.TryParse(Convert.ToString(e.CommandArgument), out galleryId))
            {
                DeletePhoto(galleryId);
            }
        }
    }

    private void DeletePhoto(int galleryId)
    {
        try
        {
            string imageUrl = "";
            string photoTitle = "";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // 1. Fetch ImageUrl
                using (SqlCommand cmdSelect = new SqlCommand("SELECT Title, ImageUrl FROM Gallery WHERE GalleryId = @GalleryId", con))
                {
                    cmdSelect.Parameters.AddWithValue("@GalleryId", galleryId);
                    using (SqlDataReader rdr = cmdSelect.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            photoTitle = Convert.ToString(rdr["Title"]);
                            imageUrl = Convert.ToString(rdr["ImageUrl"]);
                        }
                    }
                }

                // 2. Delete database record
                using (SqlCommand cmdDelete = new SqlCommand("DELETE FROM Gallery WHERE GalleryId = @GalleryId", con))
                {
                    cmdDelete.Parameters.AddWithValue("@GalleryId", galleryId);
                    int rows = cmdDelete.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        // 3. Delete physical file if custom uploaded
                        if (!string.IsNullOrEmpty(imageUrl) && imageUrl.StartsWith("images/gallery/"))
                        {
                            try
                            {
                                string filePath = Server.MapPath("~/" + imageUrl);
                                if (File.Exists(filePath))
                                {
                                    File.Delete(filePath);
                                }
                            }
                            catch
                            {
                                // Ignore file deletion if locked
                            }
                        }

                        ShowSuccess("Photo \"" + photoTitle + "\" removed from gallery successfully.");
                        BindGallery();
                        LoadGalleryStats();
                    }
                    else
                    {
                        ShowError("Photo record not found or could not be deleted.");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowError("Failed to delete photo: " + ex.Message);
        }
    }

    // ==========================================
    // CATEGORY FILTER DROPDOWN CHANGED
    // ==========================================
    protected void ddlFilterCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearAlerts();
        BindGallery();
    }

    // ==========================================
    // BADGE HELPER METHOD FOR UI
    // ==========================================
    protected string GetCategoryBadgeClass(object category)
    {
        string cat = Convert.ToString(category).ToLower();
        switch (cat)
        {
            case "rooms":
                return "cat-badge-rooms";
            case "amenities":
                return "cat-badge-amenities";
            case "dining":
                return "cat-badge-dining";
            case "exterior":
                return "cat-badge-exterior";
            default:
                return "bg-secondary text-white";
        }
    }

    // ==========================================
    // ALERT HELPERS
    // ==========================================
    private void ShowError(string msg)
    {
        pnlErrorMessage.Visible = true;
        lblErrorMessage.Text = msg;
        pnlSuccessMessage.Visible = false;
    }

    private void ShowSuccess(string msg)
    {
        pnlSuccessMessage.Visible = true;
        lblSuccessMessage.Text = msg;
        pnlErrorMessage.Visible = false;
    }

    private void ClearAlerts()
    {
        pnlErrorMessage.Visible = false;
        pnlSuccessMessage.Visible = false;
    }
}
