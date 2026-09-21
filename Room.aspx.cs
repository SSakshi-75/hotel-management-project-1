using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;

public partial class Room : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRooms();
        }
    }


    private void LoadRooms()
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;


        string query = @"
            SELECT
                RoomId,
                RoomName,
                RoomCategory,
                PricePerNight,
                CategoryBadge,
                Rating,
                MaxGuests,
                RoomArea,
                ViewType,
                PrimaryRoomImage,
                ShortDescription,
                KeyAmenities
            FROM Rooms
            ORDER BY RoomId DESC";


        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();


                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptRooms.DataSource = reader;
                    rptRooms.DataBind();
                }
            }
        }
    }


    // ==========================================
    // CATEGORY FILTER
    // ==========================================
    protected string GetCategoryFilter(object category)
    {
        string value = Convert.ToString(category).Trim().ToLower();


        if (value.Contains("executive"))
        {
            return "executive";
        }


        if (value.Contains("deluxe"))
        {
            return "deluxe";
        }


        if (value.Contains("family"))
        {
            return "family";
        }


        if (value.Contains("penthouse") ||
            value.Contains("royal") ||
            value.Contains("presidential"))
        {
            return "presidential";
        }


        return value;
    }


    // ==========================================
    // ROOM IMAGE
    // ==========================================
    protected string GetRoomImage(object image)
    {
        string imageName = Convert.ToString(image).Trim();


        if (string.IsNullOrEmpty(imageName))
        {
            return ResolveUrl("~/images/room-placeholder.jpg");
        }


        // Full external URL
        if (imageName.StartsWith("http://") ||
            imageName.StartsWith("https://"))
        {
            return imageName;
        }


        // Already contains images path
        if (imageName.StartsWith("~/"))
        {
            return ResolveUrl(imageName);
        }


        if (imageName.StartsWith("/"))
        {
            return ResolveUrl("~" + imageName);
        }


        if (imageName.StartsWith("images/"))
        {
            return ResolveUrl("~/" + imageName);
        }


        // Only filename stored in database
        return ResolveUrl("~/images/rooms/" + imageName);
    }


    // ==========================================
    // FORMAT AMENITIES
    // ==========================================
    protected string FormatAmenities(object amenities)
    {
        string value = Convert.ToString(amenities).Trim();


        if (string.IsNullOrEmpty(value))
        {
            return "";
        }


        string[] items = value.Split(',');

        StringBuilder html = new StringBuilder();


        foreach (string item in items)
        {
            string amenity = item.Trim();


            if (!string.IsNullOrEmpty(amenity))
            {
                html.Append(
                    "<span class='room-amenity-tag'>" +
                    "<i class='bi bi-check-circle'></i> " +
                    HttpUtility.HtmlEncode(amenity) +
                    "</span>"
                );
            }
        }


        return html.ToString();
    }
}