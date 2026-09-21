using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class RoomDetails : Page
{
    string conStr = System.Configuration.ConfigurationManager
                    .ConnectionStrings["HotelConnection"]
                    .ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRoomDetails();
        }
    }

    private void LoadRoomDetails()
    {
        string roomId = Request.QueryString["RoomId"];

        if (string.IsNullOrEmpty(roomId))
        {
            Response.Redirect("Room.aspx");
            return;
        }

        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
                SELECT
                    r.RoomId,
                    r.RoomName,
                    r.PricePerNight,
                    r.ImageUrl,
                    r.MaxAdults,
                    r.RoomType,

                    rd.TopBannerBadge,
                    rd.PageHeroTitle,
                    rd.PageSubtitleTagline,
                    rd.FeaturedRoomHeaderImage,
                    rd.DetailedRoomOverview,
                    rd.SuiteKeyHighlights,

                    rd.GalleryImage1,
                    rd.GalleryImage2,
                    rd.GalleryImage3,
                    rd.GalleryImage4,
                    rd.GalleryImage5,
                    rd.GalleryImage6,

                    rd.FeaturedGuestReviewQuote,
                    rd.GuestNameDesignation,
                    rd.KeyAmenities,

                    rd.CategoryBadge,
                    rd.Rating,
                    rd.RoomArea,
                    rd.ViewType

                FROM Rooms r

                LEFT JOIN RoomDetails rd
                    ON r.RoomId = rd.RoomId

                WHERE r.RoomId = @RoomId
                  AND r.IsActive = 1";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@RoomId", roomId);

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
    // ROOM IMAGE
    // ==========================================

    public string GetRoomImage(object imagePath)
    {
        if (imagePath == null || imagePath == DBNull.Value)
        {
            return ResolveUrl("~/images/room-mini-business.jpg");
        }

        string path = imagePath.ToString().Trim();

        if (string.IsNullOrEmpty(path))
        {
            return ResolveUrl("~/images/room-mini-business.jpg");
        }

        return ResolveUrl(path);
    }


    // ==========================================
    // ROOM OVERVIEW
    // ==========================================

    public string FormatOverview(object overview)
    {
        if (overview == null || overview == DBNull.Value)
        {
            return "";
        }

        string text = overview.ToString().Trim();

        if (string.IsNullOrEmpty(text))
        {
            return "";
        }

        // Line breaks ko paragraphs me convert karega
        string[] paragraphs = text.Split(
            new string[] { Environment.NewLine },
            StringSplitOptions.RemoveEmptyEntries
        );

        string result = "";

        foreach (string paragraph in paragraphs)
        {
            result += "<p>" + Server.HtmlEncode(paragraph.Trim()) + "</p>";
        }

        return result;
    }


    // ==========================================
    // SUITE HIGHLIGHTS
    // ==========================================

    public string FormatHighlights(object highlights)
    {
        if (highlights == null || highlights == DBNull.Value)
        {
            return "";
        }

        string text = highlights.ToString().Trim();

        if (string.IsNullOrEmpty(text))
        {
            return "";
        }

        string[] items = text.Split(',');

        string result = "";

        foreach (string item in items)
        {
            string value = item.Trim();

            if (!string.IsNullOrEmpty(value))
            {
                result +=
                    "<span class='badge bg-light text-dark border px-3 py-2'>" +
                    "<i class='bi bi-check-circle-fill text-success me-1'></i>" +
                    Server.HtmlEncode(value) +
                    "</span>";
            }
        }

        return result;
    }


    // ==========================================
    // ROOM AMENITIES
    // ==========================================

    public string FormatAmenities(object amenities)
    {
        if (amenities == null || amenities == DBNull.Value)
        {
            return "";
        }

        string text = amenities.ToString().Trim();

        if (string.IsNullOrEmpty(text))
        {
            return "";
        }

        string[] items = text.Split(',');

        string result = "";

        foreach (string item in items)
        {
            string value = item.Trim();

            if (!string.IsNullOrEmpty(value))
            {
                result +=
                    "<li>" +
                    "<i class='bi bi-check2'></i> " +
                    Server.HtmlEncode(value) +
                    "</li>";
            }
        }

        return result;
    }
}