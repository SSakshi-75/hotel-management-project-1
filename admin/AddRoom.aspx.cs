using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
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

        // ================= IMAGE UPLOAD =================

        string primaryRoomImage = "";
        string headerImage = "";
        string galleryImage1 = "";
        string galleryImage2 = "";
        string galleryImage3 = "";
        string galleryImage4 = "";

        // Images folder
        string imageFolder = Server.MapPath("~/images/rooms/");

        if (!Directory.Exists(imageFolder))
        {
            Directory.CreateDirectory(imageFolder);
        }


        // ================= PRIMARY ROOM IMAGE =================

        HttpPostedFile mainImage = Request.Files["fileMainImage"];

        if (mainImage != null && mainImage.ContentLength > 0)
        {
            string fileName = Path.GetFileName(mainImage.FileName);

            string filePath = Path.Combine(imageFolder, fileName);

            mainImage.SaveAs(filePath);

            primaryRoomImage = "~/images/rooms/" + fileName;
        }


        // ================= HEADER IMAGE =================

        HttpPostedFile headerFile = Request.Files["fileHeaderImage"];

        if (headerFile != null && headerFile.ContentLength > 0)
        {
            string fileName = Path.GetFileName(headerFile.FileName);

            string filePath = Path.Combine(imageFolder, fileName);

            headerFile.SaveAs(filePath);

            headerImage = "~/images/rooms/" + fileName;
        }


        // ================= GALLERY IMAGE 1 =================

        HttpPostedFile galleryFile1 = Request.Files["fileGallery1"];

        if (galleryFile1 != null && galleryFile1.ContentLength > 0)
        {
            string fileName = Path.GetFileName(galleryFile1.FileName);

            galleryFile1.SaveAs(Path.Combine(imageFolder, fileName));

            galleryImage1 = "~/images/rooms/" + fileName;
        }


        // ================= GALLERY IMAGE 2 =================

        HttpPostedFile galleryFile2 = Request.Files["fileGallery2"];

        if (galleryFile2 != null && galleryFile2.ContentLength > 0)
        {
            string fileName = Path.GetFileName(galleryFile2.FileName);

            galleryFile2.SaveAs(Path.Combine(imageFolder, fileName));

            galleryImage2 = "~/images/rooms/" + fileName;
        }


        // ================= GALLERY IMAGE 3 =================

        HttpPostedFile galleryFile3 = Request.Files["fileGallery3"];

        if (galleryFile3 != null && galleryFile3.ContentLength > 0)
        {
            string fileName = Path.GetFileName(galleryFile3.FileName);

            galleryFile3.SaveAs(Path.Combine(imageFolder, fileName));

            galleryImage3 = "~/images/rooms/" + fileName;
        }


        // ================= GALLERY IMAGE 4 =================

        HttpPostedFile galleryFile4 = Request.Files["fileGallery4"];

        if (galleryFile4 != null && galleryFile4.ContentLength > 0)
        {
            string fileName = Path.GetFileName(galleryFile4.FileName);

            galleryFile4.SaveAs(Path.Combine(imageFolder, fileName));

            galleryImage4 = "~/images/rooms/" + fileName;
        }


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

                cmd.Parameters.AddWithValue("@ReviewQuote", reviewQuote ?? "");
                cmd.Parameters.AddWithValue("@ReviewAuthor", reviewAuthor ?? "");

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        pnlSuccessMessage.Visible = true;
    }
}
