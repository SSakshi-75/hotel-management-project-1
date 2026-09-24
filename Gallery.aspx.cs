using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Gallery : System.Web.UI.Page
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
        string connectionString =
            ConfigurationManager
            .ConnectionStrings["HotelConnection"]
            .ConnectionString;

        using (SqlConnection con =
               new SqlConnection(connectionString))
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

            using (SqlCommand cmd =
                   new SqlCommand(query, con))
            {
                con.Open();

                using (SqlDataReader dr =
                       cmd.ExecuteReader())
                {
                    rptPublicGallery.DataSource = dr;
                    rptPublicGallery.DataBind();
                }
            }
        }
    }





    // ==========================================
    // SHOW MESSAGE
    // ==========================================

    private void ShowMessage(string message)
    {
        string safeMessage =
            message
            .Replace("\\", "\\\\")
            .Replace("'", "\\'")
            .Replace("\r", "")
            .Replace("\n", "\\n");

        ClientScript.RegisterStartupScript(
            this.GetType(),
            "GalleryMessage",
            "alert('" + safeMessage + "');",
            true
        );
    }


    // ==========================================
    // CATEGORY FILTER CLASS
    // ==========================================

    public string GetFilterClass(object categoryObj)
    {
        if (categoryObj == null)
        {
            return "";
        }

        string category =
            categoryObj
            .ToString()
            .ToLower();

        switch (category)
        {
            case "rooms":
                return "filter-rooms";

            case "amenities":
                return "filter-amenities";

            case "dining":
                return "filter-dining";

            case "exterior":
                return "filter-exterior";

            default:
                return "";
        }
    }


    // ==========================================
    // CATEGORY DISPLAY NAME
    // ==========================================

    public string GetCategoryDisplayName(object categoryObj)
    {
        if (categoryObj == null)
        {
            return "";
        }

        string category =
            categoryObj.ToString();

        switch (category.ToLower())
        {
            case "rooms":
                return "Rooms";

            case "amenities":
                return "Amenities";

            case "dining":
                return "Dining";

            case "exterior":
                return "Exterior";

            default:
                return category;
        }
    }
}