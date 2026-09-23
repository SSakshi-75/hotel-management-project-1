using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Gallery : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGalleryPhotos();
        }
    }

    private void LoadGalleryPhotos()
    {
        if (string.IsNullOrEmpty(connectionString)) return;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string sql = "SELECT GalleryId, Title, Category, ImageUrl FROM Gallery ORDER BY GalleryId ASC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptPublicGallery.DataSource = dt;
                            rptPublicGallery.DataBind();
                        }
                    }
                }
            }
        }
        catch
        {
            // Fallback gracefully without breaking public UI
        }
    }

    protected string GetFilterClass(object category)
    {
        string cat = Convert.ToString(category).Trim().ToLower();
        switch (cat)
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
                return "filter-rooms";
        }
    }

    protected string GetCategoryDisplayName(object category)
    {
        string cat = Convert.ToString(category).Trim().ToLower();
        switch (cat)
        {
            case "rooms":
                return "Rooms & Suites";
            case "amenities":
                return "Amenities";
            case "dining":
                return "Fine Dining";
            case "exterior":
                return "Exterior & Garden";
            default:
                return Convert.ToString(category);
        }
    }
}
