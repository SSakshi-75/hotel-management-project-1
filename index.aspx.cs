using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadShowcaseRooms();
        }
    }

    private void LoadShowcaseRooms()
    {
        DataTable dtAll = new DataTable();
        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
                ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
                : "";

            if (!string.IsNullOrEmpty(connStr))
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string query = @"
                        SELECT TOP 4
                            RoomID,
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
                        WHERE ISNULL(IsActive, 1) = 1
                        ORDER BY RoomID DESC";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtAll);
                        }
                    }
                }
            }
        }
        catch
        {
            // Fallback handled below
        }

        if (dtAll == null || dtAll.Rows.Count == 0)
        {
            dtAll = GetSampleRooms();
        }

        if (dtAll != null && dtAll.Rows.Count > 0)
        {
            // Left Column: 1st Room (Featured Suite)
            DataTable dtFeatured = dtAll.Clone();
            dtFeatured.ImportRow(dtAll.Rows[0]);
            rptFeaturedRoom.DataSource = dtFeatured;
            rptFeaturedRoom.DataBind();

            // Right Column: Remaining rooms (up to 3 mini rooms)
            if (dtAll.Rows.Count > 1)
            {
                DataTable dtMini = dtAll.Clone();
                for (int i = 1; i < dtAll.Rows.Count && i < 4; i++)
                {
                    dtMini.ImportRow(dtAll.Rows[i]);
                }
                rptMiniRooms.DataSource = dtMini;
                rptMiniRooms.DataBind();
            }
        }
    }

    private DataTable GetSampleRooms()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("RoomID", typeof(int));
        dt.Columns.Add("RoomName", typeof(string));
        dt.Columns.Add("RoomCategory", typeof(string));
        dt.Columns.Add("PricePerNight", typeof(decimal));
        dt.Columns.Add("CategoryBadge", typeof(string));
        dt.Columns.Add("Rating", typeof(string));
        dt.Columns.Add("MaxGuests", typeof(string));
        dt.Columns.Add("RoomArea", typeof(string));
        dt.Columns.Add("ViewType", typeof(string));
        dt.Columns.Add("PrimaryRoomImage", typeof(string));
        dt.Columns.Add("ShortDescription", typeof(string));
        dt.Columns.Add("KeyAmenities", typeof(string));

        dt.Rows.Add(1051, "Grand Presidential Suite", "PRESIDENTIAL", 18500m, "PRESIDENTIAL", "5.0", "6 Guests", "180m²", "Top Floor", "images/room-featured-presidential.jpg", "Indulge in unmatched opulence with panoramic city skyline views, private jacuzzi terrace, master king bedroom, handcrafted marble interiors, and 24/7 dedicated butler service.", "Premium WiFi, Smart TV, Coffee Bar, Climate Control");
        dt.Rows.Add(1012, "Executive Business Room", "BUSINESS", 8500m, "EXECUTIVE", "4.9", "2 Guests", "55m²", "City Views", "images/room-mini-business.jpg", "Designed for modern business executives, featuring an ergonomic workstation, high-speed Wi-Fi, premium king bedding, and lounge access.", "Work Space, City Views");
        dt.Rows.Add(1010, "Garden View Deluxe", "DELUXE", 6800m, "DELUXE", "4.8", "2 Guests", "44m²", "Garden View", "images/room-mini-garden.jpg", "Surround yourself with tranquil tropical greenery, featuring a private sun terrace, soothing natural ambiance, and plush king bedding.", "Garden View, Private Terrace");
        dt.Rows.Add(1011, "Family Comfort Suite", "FAMILY", 11500m, "FAMILY", "4.9", "4 Guests", "75m²", "Courtyard View", "images/room-mini-family.jpg", "Spacious multi-room luxury suite perfect for family stays, equipped with a dedicated children's area, lounge space, and luxury bath amenities.", "Family Space, Kids Area");

        return dt;
    }

    public string GetRoomImage(object image)
    {
        string imageName = Convert.ToString(image).Trim();
        if (string.IsNullOrEmpty(imageName))
        {
            return "images/room-featured-presidential.jpg";
        }
        if (imageName.StartsWith("http://") || imageName.StartsWith("https://"))
        {
            return imageName;
        }
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
        return ResolveUrl("~/images/rooms/" + imageName);
    }

    public string GetBadgeText(object badgeObj, object categoryObj)
    {
        string badge = Convert.ToString(badgeObj).Trim();
        if (!string.IsNullOrEmpty(badge)) return badge.ToUpper();
        string cat = Convert.ToString(categoryObj).Trim();
        if (!string.IsNullOrEmpty(cat)) return cat.ToUpper();
        return "LUXURY SUITE";
    }

    public string RenderRatingStars(object ratingObj)
    {
        double rating = 5.0;
        double r;
        if (ratingObj != null && double.TryParse(ratingObj.ToString(), out r))
        {
            rating = r;
        }
        int fullStars = (int)Math.Floor(rating);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < fullStars && i < 5; i++)
        {
            sb.Append("<i class=\"fa-solid fa-star\"></i>");
        }
        if (rating - fullStars >= 0.5 && fullStars < 5)
        {
            sb.Append("<i class=\"fa-solid fa-star-half-stroke\"></i>");
            fullStars++;
        }
        while (fullStars < 5)
        {
            sb.Append("<i class=\"fa-regular fa-star\"></i>");
            fullStars++;
        }
        return sb.ToString();
    }

    public string RenderFeaturedAmenities(object amenitiesObj)
    {
        string text = Convert.ToString(amenitiesObj).Trim();
        if (string.IsNullOrEmpty(text))
        {
            return @"<span class=""suite-amenity-item""><i class=""bi bi-wifi""></i> Premium WiFi</span>
                     <span class=""suite-amenity-item""><i class=""bi bi-tv""></i> Smart TV</span>
                     <span class=""suite-amenity-item""><i class=""bi bi-cup-hot""></i> Coffee Bar</span>
                     <span class=""suite-amenity-item""><i class=""bi bi-snow""></i> Climate Control</span>";
        }
        string[] parts = text.Split(new char[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries);
        StringBuilder sb = new StringBuilder();
        int count = 0;
        foreach (string p in parts)
        {
            if (count >= 4) break;
            string item = p.Trim();
            if (string.IsNullOrEmpty(item)) continue;
            string icon = "bi-check-circle";
            string lower = item.ToLower();
            if (lower.Contains("wifi")) icon = "bi-wifi";
            else if (lower.Contains("tv")) icon = "bi-tv";
            else if (lower.Contains("coffee") || lower.Contains("tea") || lower.Contains("bar")) icon = "bi-cup-hot";
            else if (lower.Contains("ac") || lower.Contains("air") || lower.Contains("climate")) icon = "bi-snow";
            else if (lower.Contains("terrace") || lower.Contains("balcony")) icon = "bi-door-open";
            else if (lower.Contains("jacuzzi") || lower.Contains("bath") || lower.Contains("spa")) icon = "bi-droplet";
            else if (lower.Contains("butler") || lower.Contains("service")) icon = "bi-person-badge";
            else if (lower.Contains("desk") || lower.Contains("work")) icon = "bi-briefcase";

            sb.AppendFormat("<span class=\"suite-amenity-item\"><i class=\"bi {0}\"></i> {1}</span>", icon, HttpUtility.HtmlEncode(item));
            count++;
        }
        return sb.ToString();
    }

    public string RenderMiniTags(object viewTypeObj, object amenitiesObj, object maxGuestsObj)
    {
        StringBuilder sb = new StringBuilder();
        string view = Convert.ToString(viewTypeObj).Trim();
        string guests = Convert.ToString(maxGuestsObj).Trim();
        string amenities = Convert.ToString(amenitiesObj).Trim();

        int tagsCount = 0;
        if (!string.IsNullOrEmpty(view) && tagsCount < 2)
        {
            string icon = "bi-building";
            if (view.ToLower().Contains("garden")) icon = "bi-tree";
            else if (view.ToLower().Contains("ocean") || view.ToLower().Contains("sea") || view.ToLower().Contains("water")) icon = "bi-water";
            else if (view.ToLower().Contains("courtyard")) icon = "bi-flower1";
            sb.AppendFormat("<span><i class=\"bi {0}\"></i> {1}</span> ", icon, HttpUtility.HtmlEncode(view));
            tagsCount++;
        }
        if (!string.IsNullOrEmpty(amenities) && tagsCount < 2)
        {
            string firstAmenity = amenities.Split(new char[] { ',', ';' })[0].Trim();
            if (!string.IsNullOrEmpty(firstAmenity))
            {
                string icon = "bi-check2-circle";
                if (firstAmenity.ToLower().Contains("terrace")) icon = "bi-door-open";
                else if (firstAmenity.ToLower().Contains("desk") || firstAmenity.ToLower().Contains("work")) icon = "bi-briefcase";
                else if (firstAmenity.ToLower().Contains("tv")) icon = "bi-tv";
                else if (firstAmenity.ToLower().Contains("jacuzzi")) icon = "bi-droplet";
                sb.AppendFormat("<span><i class=\"bi {0}\"></i> {1}</span> ", icon, HttpUtility.HtmlEncode(firstAmenity));
                tagsCount++;
            }
        }
        if (tagsCount < 2 && !string.IsNullOrEmpty(guests))
        {
            sb.AppendFormat("<span><i class=\"bi bi-people\"></i> {0}</span> ", HttpUtility.HtmlEncode(guests));
        }
        return sb.ToString();
    }
}