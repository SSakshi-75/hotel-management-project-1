using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;

public partial class RoomDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRoomDetails();
        }
    }

    private void LoadRoomDetails()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

        string roomIdStr = Request.QueryString["RoomId"] ?? Request.QueryString["RoomID"] ?? Request.QueryString["id"];
        string roomTitle = Request.QueryString["title"] ?? Request.QueryString["room"];
        int roomId = 0;

        DateTime qIn = DateTime.MinValue;
        DateTime qOut = DateTime.MinValue;
        bool hasValidDates = DateTime.TryParse(Request.QueryString["checkIn"], out qIn) &&
                             DateTime.TryParse(Request.QueryString["checkOut"], out qOut) &&
                             qOut > qIn;

        string query = @"
            SELECT
                Id,
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
                KeyAmenities,
                HeaderBadge,
                HeaderTitle,
                HeaderSubtitle,
                HeaderImage,
                FullOverview,
                Highlights,
                GalleryImage1,
                GalleryImage2,
                GalleryImage3,
                GalleryImage4,
                ReviewQuote,
                ReviewAuthor,
                ISNULL(NULLIF(LTRIM(RTRIM(REPLACE(GSTPercentage, '%', ''))), ''), '18') AS GSTPercentage,
                CASE
                    -- Admin status Cleaning, Maintenance, Blocked, or Occupied
                    WHEN ISNULL(RoomStatus, 'Available') IN ('Cleaning', 'Maintenance', 'Blocked', 'Occupied')
                        THEN 'Not Available'

                    -- Conflicting active bookings for the selected stay dates
                    WHEN @HasDates = 1 AND EXISTS
                    (
                        SELECT 1
                        FROM Bookings B
                        WHERE (B.RoomId = Rooms.RoomID OR B.RoomId = Rooms.Id)
                        AND B.BookingStatus IN ('Pending', 'Confirmed', 'Checked-In')
                        AND B.CheckInDate < @CheckOutDate
                        AND B.CheckOutDate > @CheckInDate
                    )
                        THEN 'Not Available'

                    -- Admin status Available with no conflicting booking
                    WHEN ISNULL(RoomStatus, 'Available') = 'Available'
                        THEN 'Available'

                    ELSE 'Not Available'
                END AS RoomStatus
            FROM Rooms ";

        bool hasParam = false;

        if (!string.IsNullOrEmpty(roomIdStr) && int.TryParse(roomIdStr, out roomId))
        {
            query += "WHERE (RoomID = @RoomID OR Id = @RoomID) AND ISNULL(IsActive, 1) = 1";
            hasParam = true;
        }
        else if (!string.IsNullOrEmpty(roomTitle))
        {
            query += "WHERE (RoomName = @RoomName OR RoomName LIKE '%' + @RoomName + '%') AND ISNULL(IsActive, 1) = 1";
            hasParam = true;
        }
        else
        {
            query = "SELECT TOP 1 * FROM (" + query + ") Q WHERE ISNULL(IsActive, 1) = 1 ORDER BY RoomID DESC";
        }

        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@HasDates", SqlDbType.Bit).Value = hasValidDates;
                cmd.Parameters.Add("@CheckInDate", SqlDbType.DateTime).Value = hasValidDates ? (object)qIn : DBNull.Value;
                cmd.Parameters.Add("@CheckOutDate", SqlDbType.DateTime).Value = hasValidDates ? (object)qOut : DBNull.Value;

                if (hasParam)
                {
                    if (roomId > 0)
                    {
                        cmd.Parameters.Add("@RoomID", SqlDbType.Int).Value = roomId;
                    }
                    else if (!string.IsNullOrEmpty(roomTitle))
                    {
                        cmd.Parameters.Add("@RoomName", SqlDbType.NVarChar, 150).Value = roomTitle;
                    }
                }

                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        if (dt.Rows.Count > 0)
        {
            rptRoomDetails.DataSource = dt;
            rptRoomDetails.DataBind();
        }
        else
        {
            Response.Redirect("Room.aspx");
        }
    }

    // ==========================================
    // ROOM IMAGE HELPER
    // ==========================================
    protected string GetRoomImage(object image)
    {
        string imageName = Convert.ToString(image).Trim();

        if (string.IsNullOrEmpty(imageName))
        {
            return ResolveUrl("~/images/room-featured-presidential.jpg");
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

    // ==========================================
    // GALLERY THUMBNAILS
    // ==========================================
    protected string GetGalleryThumbnails(object dataItem)
    {
        System.Data.DataRowView row = dataItem as System.Data.DataRowView;
        if (row == null)
        {
            return "";
        }

        StringBuilder html = new StringBuilder();

        string[] galleryImages =
        {
            Convert.ToString(row["GalleryImage1"]),
            Convert.ToString(row["GalleryImage2"]),
            Convert.ToString(row["GalleryImage3"]),
            Convert.ToString(row["GalleryImage4"])
        };

        foreach (string image in galleryImages)
        {
            string imageName = image.Trim();
            if (!string.IsNullOrEmpty(imageName))
            {
                html.Append("<img src='" + GetRoomImage(imageName) + "' class='gallery-thumb' alt='Room Gallery' onclick='swapGallery(this)' />");
            }
        }

        return html.ToString();
    }

    // ==========================================
    // HEADER BADGE
    // ==========================================
    protected string GetHeaderBadge(object headerBadge, object roomCategory)
    {
        string value = Convert.ToString(headerBadge).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        value = Convert.ToString(roomCategory).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        return "Room Details";
    }

    // ==========================================
    // HEADER TITLE
    // ==========================================
    protected string GetHeaderTitle(object headerTitle, object roomName)
    {
        string value = Convert.ToString(headerTitle).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        return Convert.ToString(roomName).Trim();
    }

    // ==========================================
    // HEADER SUBTITLE
    // ==========================================
    protected string GetHeaderSubtitle(object headerSubtitle, object shortDescription)
    {
        string value = Convert.ToString(headerSubtitle).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        return Convert.ToString(shortDescription).Trim();
    }

    // ==========================================
    // CATEGORY BADGE
    // ==========================================
    protected string GetCategoryBadge(object categoryBadge, object roomCategory)
    {
        string value = Convert.ToString(categoryBadge).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        return Convert.ToString(roomCategory).Trim();
    }

    // ==========================================
    // RATING
    // ==========================================
    protected string GetRatingScore(object rating)
    {
        string value = Convert.ToString(rating).Trim();
        if (!string.IsNullOrEmpty(value))
        {
            return value;
        }

        return "5.0";
    }

    // ==========================================
    // STAR ICONS
    // ==========================================
    protected string GetStarIconsHtml(object rating)
    {
        double score = 5.0;
        double.TryParse(Convert.ToString(rating), out score);

        if (score <= 0)
        {
            score = 5.0;
        }

        int fullStars = (int)Math.Floor(score);
        StringBuilder html = new StringBuilder();

        for (int i = 0; i < fullStars && i < 5; i++)
        {
            html.Append("<i class=\"bi bi-star-fill\"></i> ");
        }

        if (score - fullStars >= 0.5 && fullStars < 5)
        {
            html.Append("<i class=\"bi bi-star-half\"></i> ");
        }

        return html.ToString();
    }

    // ==========================================
    // OVERVIEW
    // ==========================================
    protected string FormatOverview(object fullOverview, object shortDescription)
    {
        string value = Convert.ToString(fullOverview).Trim();
        if (string.IsNullOrEmpty(value))
        {
            value = Convert.ToString(shortDescription).Trim();
        }

        if (string.IsNullOrEmpty(value))
        {
            return "";
        }

        string[] paragraphs = value.Split(new[] { "\r\n\r\n", "\n\n", "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries);
        StringBuilder sb = new StringBuilder();
        foreach (string p in paragraphs)
        {
            string clean = p.Trim();
            if (!string.IsNullOrEmpty(clean))
            {
                sb.Append("<p>" + HttpUtility.HtmlEncode(clean) + "</p>");
            }
        }
        return sb.ToString();
    }

    // ==========================================
    // OVERVIEW COLUMN CLASS
    // ==========================================
    protected string GetOverviewColClass(object reviewQuote)
    {
        string value = Convert.ToString(reviewQuote).Trim();
        if (string.IsNullOrEmpty(value))
        {
            return "col-lg-12";
        }

        return "col-lg-8";
    }

    // ==========================================
    // REVIEW SECTION (HIGHLIGHT BOX)
    // ==========================================
    protected string GetReviewSectionHtml(object reviewQuote, object reviewAuthor)
    {
        string quote = Convert.ToString(reviewQuote).Trim();
        string author = Convert.ToString(reviewAuthor).Trim();

        if (string.IsNullOrEmpty(quote))
        {
            return "";
        }

        StringBuilder html = new StringBuilder();
        html.Append("<div class='col-lg-4' data-aos='fade-left' data-aos-delay='300'>");
        html.Append("<div class='highlight-box'>");
        html.Append("<div class='highlight-icon'><i class='bi bi-star-fill'></i></div>");
        html.Append("<h4>Premium Experience</h4>");
        html.Append("<p>\"" + HttpUtility.HtmlEncode(quote.Trim('"', ' ')) + "\"</p>");

        if (!string.IsNullOrEmpty(author))
        {
            html.Append("<div class='quote-author'><span>- " + HttpUtility.HtmlEncode(author.TrimStart('-', ' ')) + "</span></div>");
        }

        html.Append("</div>");
        html.Append("</div>");

        return html.ToString();
    }



    // ==========================================
    // FORMAT AMENITIES (CARD LEVEL)
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
                html.Append("<span class='room-amenity-tag'><i class='bi bi-check-circle me-1'></i> " + HttpUtility.HtmlEncode(amenity) + "</span>");
            }
        }

        return html.ToString();
    }

    // ==========================================
    // GET BOOK NOW URL (Preserves RoomId, RoomName, Price, checkIn, checkOut, adults, gst)
    // ==========================================
    public string GetBookNowUrl(object roomId, object roomName, object price, object gstObj = null)
    {
        string rId = roomId != null ? roomId.ToString() : "";
        string rName = roomName != null ? roomName.ToString() : "";
        string rPrice = price != null ? price.ToString() : "";
        string rGst = gstObj != null ? gstObj.ToString().Trim().Replace("%", "") : "";

        string url = string.Format("Booking.aspx?RoomId={0}&room={1}&price={2}",
            rId,
            HttpUtility.UrlEncode(rName),
            rPrice);

        if (!string.IsNullOrEmpty(rGst)) url += "&gst=" + HttpUtility.UrlEncode(rGst);

        string checkIn = Request.QueryString["checkIn"];
        string checkOut = Request.QueryString["checkOut"];
        string adults = Request.QueryString["adults"] ?? Request.QueryString["guests"];

        if (!string.IsNullOrEmpty(checkIn)) url += "&checkIn=" + HttpUtility.UrlEncode(checkIn);
        if (!string.IsNullOrEmpty(checkOut)) url += "&checkOut=" + HttpUtility.UrlEncode(checkOut);
        if (!string.IsNullOrEmpty(adults)) url += "&adults=" + HttpUtility.UrlEncode(adults);

        return url;
    }

    // ==========================================
    // ROOM AVAILABILITY BADGE
    // ==========================================
    public string GetRoomAvailabilityBadge(object statusObj)
    {
        string status = statusObj != null ? statusObj.ToString().Trim() : "Available";

        if (status.Equals("Available", StringComparison.OrdinalIgnoreCase))
        {
            return "<span class=\"badge-room-avail ms-2\"><i class=\"bi bi-check-circle-fill text-success me-1\"></i> Available</span>";
        }

        return "<span class=\"badge-room-booked ms-2\"><i class=\"bi bi-x-circle-fill text-danger me-1\"></i> Not Available</span>";
    }

    // ==========================================
    // BOOK NOW BUTTON (Enabled / Disabled)
    // ==========================================
    public string GetBookNowButtonHtml(object roomId, object roomName, object price, object statusObj, object gstObj = null)
    {
        string status = statusObj != null ? statusObj.ToString().Trim() : "Available";
        bool isAvailable = string.Equals(status, "Available", StringComparison.OrdinalIgnoreCase);

        if (!isAvailable)
        {
            return "<button type=\"button\" class=\"btn btn-book-now\" disabled " +
                   "style=\"opacity: 0.6; cursor: not-allowed; pointer-events: none; background: #6c757d; border-color: #6c757d; box-shadow: none;\">" +
                   "<i class=\"bi bi-slash-circle me-2\"></i> Not Available" +
                   "</button>";
        }

        return "<a href=\"" + GetBookNowUrl(roomId, roomName, price, gstObj) + "\" class=\"btn btn-book-now\">" +
               "<i class=\"bi bi-calendar-check me-2\"></i> Book Now" +
               "</a>";
    }
}