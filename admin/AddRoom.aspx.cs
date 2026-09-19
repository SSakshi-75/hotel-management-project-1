using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

public partial class Admin_AddRoom : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Initial form setup for admin frontend
        }
    }

    protected void btnSaveRoom_Click(object sender, EventArgs e)
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString;

        string roomName = Request.Form["txtRoomName"];
        string roomCategory = Request.Form["ddlCategory"];
        string pricePerNight = Request.Form["txtPrice"];
        string categoryBadge = Request.Form["txtBadge"];
        string rating = Request.Form["txtRating"];
        string maxGuests = Request.Form["txtMaxAdults"];
        string roomArea = Request.Form["txtArea"];
        string viewType = Request.Form["txtViewType"];
        string shortDescription = Request.Form["txtShortDesc"];

        string headerBadge = Request.Form["txtHeaderBadge"];
        string headerTitle = Request.Form["txtHeaderTitle"];
        string headerSubtitle = Request.Form["txtHeaderSubtitle"];
        string fullOverview = Request.Form["txtFullOverview"];
        string highlights = Request.Form["txtHighlights"];

        string reviewQuote = Request.Form["txtReviewQuote"];
        string reviewAuthor = Request.Form["txtReviewAuthor"];


        // Selected Amenities
        string keyAmenities = "";

        string[] amenities = Request.Form.GetValues("amenities");

        if (amenities != null)
        {
            keyAmenities = string.Join(", ", amenities);
        }


        // Image file names
        string primaryRoomImage = "";
        string headerImage = "";
        string galleryImage1 = "";
        string galleryImage2 = "";
        string galleryImage3 = "";
        string galleryImage4 = "";
        string galleryImage5 = "";
        string galleryImage6 = "";

        if (Request.Files["fileMainImage"] != null)
        {
            primaryRoomImage = Path.GetFileName(Request.Files["fileMainImage"].FileName);
        }

        if (Request.Files["fileHeaderImage"] != null)
        {
            headerImage = Path.GetFileName(Request.Files["fileHeaderImage"].FileName);
        }

        if (Request.Files["fileGallery1"] != null)
            galleryImage1 = Path.GetFileName(Request.Files["fileGallery1"].FileName);

        if (Request.Files["fileGallery2"] != null)
            galleryImage2 = Path.GetFileName(Request.Files["fileGallery2"].FileName);

        if (Request.Files["fileGallery3"] != null)
            galleryImage3 = Path.GetFileName(Request.Files["fileGallery3"].FileName);

        if (Request.Files["fileGallery4"] != null)
            galleryImage4 = Path.GetFileName(Request.Files["fileGallery4"].FileName);

        if (Request.Files["fileGallery5"] != null)
            galleryImage5 = Path.GetFileName(Request.Files["fileGallery5"].FileName);

        if (Request.Files["fileGallery6"] != null)
            galleryImage6 = Path.GetFileName(Request.Files["fileGallery6"].FileName);


        string query = @"
        INSERT INTO Rooms
        (
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
            GalleryImage5,
            GalleryImage6,
            ReviewQuote,
            ReviewAuthor
        )
        VALUES
        (
            @RoomName,
            @RoomCategory,
            @PricePerNight,
            @CategoryBadge,
            @Rating,
            @MaxGuests,
            @RoomArea,
            @ViewType,
            @PrimaryRoomImage,
            @ShortDescription,
            @KeyAmenities,
            @HeaderBadge,
            @HeaderTitle,
            @HeaderSubtitle,
            @HeaderImage,
            @FullOverview,
            @Highlights,
            @GalleryImage1,
            @GalleryImage2,
            @GalleryImage3,
            @GalleryImage4,
            @GalleryImage5,
            @GalleryImage6,
            @ReviewQuote,
            @ReviewAuthor
        )";


        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@RoomName", roomName ?? "");
                cmd.Parameters.AddWithValue("@RoomCategory", roomCategory ?? "");
                cmd.Parameters.AddWithValue("@PricePerNight", pricePerNight ?? "");
                cmd.Parameters.AddWithValue("@CategoryBadge", categoryBadge ?? "");
                cmd.Parameters.AddWithValue("@Rating", rating ?? "");
                cmd.Parameters.AddWithValue("@MaxGuests", maxGuests ?? "");
                cmd.Parameters.AddWithValue("@RoomArea", roomArea ?? "");
                cmd.Parameters.AddWithValue("@ViewType", viewType ?? "");
                cmd.Parameters.AddWithValue("@PrimaryRoomImage", primaryRoomImage);
                cmd.Parameters.AddWithValue("@ShortDescription", shortDescription ?? "");

                cmd.Parameters.AddWithValue("@KeyAmenities", keyAmenities);

                cmd.Parameters.AddWithValue("@HeaderBadge", headerBadge ?? "");
                cmd.Parameters.AddWithValue("@HeaderTitle", headerTitle ?? "");
                cmd.Parameters.AddWithValue("@HeaderSubtitle", headerSubtitle ?? "");
                cmd.Parameters.AddWithValue("@HeaderImage", headerImage);
                cmd.Parameters.AddWithValue("@FullOverview", fullOverview ?? "");
                cmd.Parameters.AddWithValue("@Highlights", highlights ?? "");

                cmd.Parameters.AddWithValue("@GalleryImage1", galleryImage1);
                cmd.Parameters.AddWithValue("@GalleryImage2", galleryImage2);
                cmd.Parameters.AddWithValue("@GalleryImage3", galleryImage3);
                cmd.Parameters.AddWithValue("@GalleryImage4", galleryImage4);
                cmd.Parameters.AddWithValue("@GalleryImage5", galleryImage5);
                cmd.Parameters.AddWithValue("@GalleryImage6", galleryImage6);

                cmd.Parameters.AddWithValue("@ReviewQuote", reviewQuote ?? "");
                cmd.Parameters.AddWithValue("@ReviewAuthor", reviewAuthor ?? "");

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        pnlSuccessMessage.Visible = true;
    }
}
