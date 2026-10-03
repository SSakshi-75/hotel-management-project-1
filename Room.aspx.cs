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
            DateTime today = DateTime.Today;

            DateTime qIn, qOut;
            if (DateTime.TryParse(Request.QueryString["checkIn"], out qIn) && qIn >= today)
            {
                txtCheckIn.Text = qIn.ToString("yyyy-MM-dd");
                litCheckIn.Text = qIn.ToString(
                    "ddd, d MMM",
                    System.Globalization.CultureInfo.InvariantCulture
                );
            }
            else
            {
                txtCheckIn.Text = today.ToString("yyyy-MM-dd");
                litCheckIn.Text = today.ToString(
                    "ddd, d MMM",
                    System.Globalization.CultureInfo.InvariantCulture
                );
            }

            if (DateTime.TryParse(Request.QueryString["checkOut"], out qOut) && qOut > (DateTime.TryParse(txtCheckIn.Text, out qIn) ? qIn : today))
            {
                txtCheckOut.Text = qOut.ToString("yyyy-MM-dd");
                litCheckOut.Text = qOut.ToString(
                    "ddd, d MMM",
                    System.Globalization.CultureInfo.InvariantCulture
                );
            }
            else
            {
                txtCheckOut.Text = today.AddDays(1).ToString("yyyy-MM-dd");
                litCheckOut.Text = today.AddDays(1).ToString(
                    "ddd, d MMM",
                    System.Globalization.CultureInfo.InvariantCulture
                );
            }

            // If dates passed in QueryString, load available rooms for those dates
            if (!string.IsNullOrEmpty(Request.QueryString["checkIn"]) && !string.IsNullOrEmpty(Request.QueryString["checkOut"]))
            {
                DateTime cin, cout;
                if (DateTime.TryParse(txtCheckIn.Text, out cin) && DateTime.TryParse(txtCheckOut.Text, out cout) && cout > cin)
                {
                    LoadAvailableRooms(cin, cout);
                }
                else
                {
                    LoadRooms();
                }
            }
            else
            {
                LoadRooms();
            }

            // Customer category filters
            LoadCustomerCategoryFilters();
        }
    }


    // =========================================================
    // LOAD ALL ROOMS
    // =========================================================
    private void LoadRooms()
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

        string query = @"
            SELECT
                R.RoomID,
                R.RoomName,
                R.RoomCategory,
                R.PricePerNight,
                R.CategoryBadge,
                R.Rating,
                R.MaxGuests,
                R.RoomArea,
                R.ViewType,
                R.PrimaryRoomImage,
                R.ShortDescription,
                R.KeyAmenities,
                ISNULL(R.RoomStatus, 'Available') AS RoomStatus
            FROM Rooms R
            WHERE ISNULL(R.IsActive, 1) = 1
            ORDER BY R.RoomID DESC";

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


    // =========================================================
    // SEARCH AVAILABLE ROOMS BY DATE
    // =========================================================
    private void LoadAvailableRooms(
        DateTime checkInDate,
        DateTime checkOutDate)
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

        string query = @"
            SELECT
                R.RoomID,
                R.RoomName,
                R.RoomCategory,
                R.PricePerNight,
                R.CategoryBadge,
                R.Rating,
                R.MaxGuests,
                R.RoomArea,
                R.ViewType,
                R.PrimaryRoomImage,
                R.ShortDescription,
                R.KeyAmenities,

                CASE

                    WHEN R.RoomStatus IN ('Maintenance', 'Blocked')
                        THEN 'Booked'

                    WHEN EXISTS
                    (
                        SELECT 1
                        FROM Bookings B
                        WHERE B.RoomId = R.RoomID
                        AND B.BookingStatus IN ('Confirmed', 'CheckedIn', 'Checked-In')
                        AND B.CheckInDate < @CheckOutDate
                        AND B.CheckOutDate > @CheckInDate
                    )
                        THEN 'Booked'

                    ELSE 'Available'

                END AS RoomStatus

            FROM Rooms R

            WHERE ISNULL(R.IsActive, 1) = 1

            ORDER BY R.RoomID DESC";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue(
                    "@CheckInDate",
                    checkInDate
                );

                cmd.Parameters.AddWithValue(
                    "@CheckOutDate",
                    checkOutDate
                );

                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptRooms.DataSource = reader;
                    rptRooms.DataBind();
                }
            }
        }
    }


    // =========================================================
    // SEARCH BUTTON
    // =========================================================
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DateTime checkInDate;
        DateTime checkOutDate;

        // Check-in date validate
        if (!DateTime.TryParse(
            txtCheckIn.Text,
            out checkInDate))
        {
            return;
        }

        // Check-out date validate
        if (!DateTime.TryParse(
            txtCheckOut.Text,
            out checkOutDate))
        {
            return;
        }

        // Checkout check-in se pehle ya same date nahi ho sakta
        if (checkOutDate <= checkInDate)
        {
            return;
        }

        // Selected dates ke according rooms load honge
        LoadAvailableRooms(
            checkInDate,
            checkOutDate
        );

        // Selected dates ko display mein update karna
        litCheckIn.Text = checkInDate.ToString(
            "ddd, d MMM",
            System.Globalization.CultureInfo.InvariantCulture
        );

        litCheckOut.Text = checkOutDate.ToString(
            "ddd, d MMM",
            System.Globalization.CultureInfo.InvariantCulture
        );
    }


    // =========================================================
    // ROOM AVAILABILITY BADGE
    // =========================================================
    public string GetRoomAvailabilityBadge(object statusObj)
    {
        string status =
            statusObj != null
                ? statusObj.ToString().Trim()
                : "Available";

        if (
            status.Equals(
                "Booked",
                StringComparison.OrdinalIgnoreCase
            )
            ||
            status.Equals(
                "Occupied",
                StringComparison.OrdinalIgnoreCase
            )
        )
        {
            return
                "<span class=\"badge-room-booked\">" +
                "<i class=\"bi bi-x-circle-fill text-danger me-1\"></i>" +
                " Booked" +
                "</span>";
        }

        return
            "<span class=\"badge-room-avail\">" +
            "<i class=\"bi bi-check-circle-fill text-success me-1\"></i>" +
            " Available" +
            "</span>";
    }


    // =========================================================
    // CUSTOMER CATEGORY FILTERS
    // =========================================================
    private void LoadCustomerCategoryFilters()
    {
        try
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

            using (SqlConnection con =
                new SqlConnection(connectionString))
            {
                con.Open();

                string query = @"
                    SELECT DISTINCT
                        CategoryName,
                        LOWER(
                            REPLACE(
                                LTRIM(RTRIM(CategoryName)),
                                ' ',
                                '-'
                            )
                        ) AS CategorySlug

                    FROM RoomCategories

                    WHERE LOWER(
                        LTRIM(RTRIM(PublishingStatus))
                    ) = 'active'

                    ORDER BY CategoryName";

                using (SqlCommand cmd =
                    new SqlCommand(query, con))
                {
                    using (SqlDataReader reader =
                        cmd.ExecuteReader())
                    {
                        rptCustomerCategories.DataSource = reader;
                        rptCustomerCategories.DataBind();
                    }
                }
            }
        }
        catch
        {
            // Category filter error hone par page crash nahi karega
        }
    }


    // =========================================================
    // CATEGORY FILTER
    // =========================================================
    protected string GetCategoryFilter(object category)
    {
        if (category == null)
        {
            return "";
        }

        string value =
            Convert.ToString(category)
            .Trim()
            .ToLower();

        return value.Replace(" ", "-");
    }


    // =========================================================
    // ROOM IMAGE
    // =========================================================
    protected string GetRoomImage(object image)
    {
        string imageName =
            Convert.ToString(image).Trim();

        if (string.IsNullOrEmpty(imageName))
        {
            return ResolveUrl(
                "~/images/room-placeholder.jpg"
            );
        }

        // Full external URL
        if (
            imageName.StartsWith("http://") ||
            imageName.StartsWith("https://")
        )
        {
            return imageName;
        }

        // Already contains ~/ path
        if (imageName.StartsWith("~/"))
        {
            return ResolveUrl(imageName);
        }

        // Starts with /
        if (imageName.StartsWith("/"))
        {
            return ResolveUrl("~" + imageName);
        }

        // Starts with images/
        if (imageName.StartsWith("images/"))
        {
            return ResolveUrl("~/" + imageName);
        }

        // Only filename stored in database
        return ResolveUrl(
            "~/images/rooms/" + imageName
        );
    }


    // =========================================================
    // FORMAT AMENITIES
    // =========================================================
    protected string FormatAmenities(object amenities)
    {
        string value =
            Convert.ToString(amenities).Trim();

        if (string.IsNullOrEmpty(value))
        {
            return "";
        }

        string[] items =
            value.Split(',');

        StringBuilder html =
            new StringBuilder();

        foreach (string item in items)
        {
            string amenity =
                item.Trim();

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

    // =========================================================
    // ROOM SELECT URL (Preserves checkIn, checkOut, adults)
    // =========================================================
    public string GetRoomSelectUrl(object roomIdObj)
    {
        string rId = roomIdObj != null ? roomIdObj.ToString() : "";
        string url = "RoomDetails.aspx?RoomId=" + rId;

        if (!string.IsNullOrEmpty(txtCheckIn.Text))
        {
            url += "&checkIn=" + Server.UrlEncode(txtCheckIn.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtCheckOut.Text))
        {
            url += "&checkOut=" + Server.UrlEncode(txtCheckOut.Text.Trim());
        }
        string adults = Request["ddlAdults"];
        if (!string.IsNullOrEmpty(adults))
        {
            url += "&adults=" + Server.UrlEncode(adults.Trim());
        }

        return url;
    }
}