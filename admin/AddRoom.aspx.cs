using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

public partial class Admin_AddRoom : System.Web.UI.Page
{
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["HotelConnection"] != null
        ? ConfigurationManager.ConnectionStrings["HotelConnection"].ConnectionString
        : "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateRoomCategories();

            string reqRoomId = Request.QueryString["RoomId"] ?? Request.QueryString["id"];
            int roomId;

            if (!string.IsNullOrEmpty(reqRoomId) && int.TryParse(reqRoomId, out roomId) && roomId > 0)
            {
                hdnRoomId.Value = roomId.ToString();
                LoadRoomForEdit(roomId);
            }
            else
            {
                hdnRoomId.Value = "0";
                SetupAddMode();
            }
        }
    }

    private void PopulateRoomCategories()
    {
        string selectedVal = ddlCategory.Value;
        ddlCategory.Items.Clear();
        ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem("Select Category", ""));
        ddlCategory.Items[0].Attributes["disabled"] = "disabled";

        string[] defaults = new string[] { "EXECUTIVE", "DELUXE", "FAMILY", "ROYAL KING", "PENTHOUSE" };
        foreach (string d in defaults)
        {
            ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(d, d));
        }

        if (!string.IsNullOrEmpty(connectionString))
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string catSql = @"
                    SELECT DISTINCT CategoryName AS RoomCategory FROM RoomCategories WHERE LOWER(LTRIM(RTRIM(PublishingStatus))) = 'active'
                    ORDER BY RoomCategory";
                using (SqlCommand cmd = new SqlCommand(catSql, con))
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            string cat = dr["RoomCategory"].ToString().Trim();
                            if (ddlCategory.Items.FindByValue(cat) == null && ddlCategory.Items.FindByText(cat) == null)
                            {
                                ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem(cat, cat));
                            }
                        }
                    }
                }
            }
        }

        ddlCategory.Items.Add(new System.Web.UI.WebControls.ListItem("+ Add New Category...", "__NEW__"));

        if (!string.IsNullOrEmpty(selectedVal) && ddlCategory.Items.FindByValue(selectedVal) != null)
        {
            ddlCategory.Value = selectedVal;
        }
    }

    // ==========================================
    // SETUP ADD MODE (BLANK FORM)
    // ==========================================
    private void SetupAddMode()
    {
        lblPageTitle.InnerText = "Add New Room & Room Details";
        lblPageSubtitle.InnerText = "Fill out room basic information and complete room detail specifications in a single unified form.";
        lblCardHeader.InnerHtml = "<i class=\"bi bi-door-open-fill text-warning\"></i> Add New Room Form";
        lblBadge.InnerText = "Room Entry Form";
        btnSaveRoom.Text = "Save & Publish Room";
        reqStarMainImg.Visible = true;
    }

    // ==========================================
    // LOAD EXISTING ROOM DATA FOR EDIT MODE
    // ==========================================
    private void LoadRoomForEdit(int roomId)
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Rooms WHERE RoomID = @RoomID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RoomID", roomId);
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            // 1. Set Edit Mode UI Elements
                            lblPageTitle.InnerText = "Edit Room & Room Details";
                            lblPageSubtitle.InnerText = "Modify room basic information and specifications. Update fields and save changes to inventory.";
                            lblCardHeader.InnerHtml = "<i class=\"bi bi-pencil-square text-warning\"></i> Edit Room Form";
                            lblBadge.InnerText = "Editing Room #" + roomId;
                            btnSaveRoom.Text = "Update Room";
                            reqStarMainImg.Visible = false; // Existing image already present

                            // 2. Pre-fill Section 1: Basic Information
                            txtRoomName.Value = dr["RoomName"] != DBNull.Value ? dr["RoomName"].ToString() : "";

                            string category = dr["RoomCategory"] != DBNull.Value ? dr["RoomCategory"].ToString().Trim() : "";
                            if (!string.IsNullOrEmpty(category))
                            {
                                if (ddlCategory.Items.FindByValue(category) == null && ddlCategory.Items.FindByText(category) == null)
                                {
                                    int insertIdx = Math.Max(0, ddlCategory.Items.Count - 1);
                                    ddlCategory.Items.Insert(insertIdx, new System.Web.UI.WebControls.ListItem(category, category));
                                }
                                if (ddlCategory.Items.FindByValue(category) != null)
                                {
                                    ddlCategory.Value = category;
                                }
                            }
                            txtNewCategory.Value = "";

                            txtPrice.Value = dr["PricePerNight"] != DBNull.Value ? dr["PricePerNight"].ToString() : "";
                            txtBadge.Value = dr["CategoryBadge"] != DBNull.Value ? dr["CategoryBadge"].ToString() : "";
                            txtRating.Value = dr["Rating"] != DBNull.Value ? dr["Rating"].ToString() : "";
                            txtMaxAdults.Value = dr["MaxGuests"] != DBNull.Value ? dr["MaxGuests"].ToString() : "";
                            txtArea.Value = dr["RoomArea"] != DBNull.Value ? dr["RoomArea"].ToString() : "";
                            txtViewType.Value = dr["ViewType"] != DBNull.Value ? dr["ViewType"].ToString() : "";
                            txtShortDesc.Value = dr["ShortDescription"] != DBNull.Value ? dr["ShortDescription"].ToString() : "";
                            ddlIsActive.Value = (dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"])) ? "1" : "0";

                            // 3. Pre-select Key Amenities
                            string keyAmenities = dr["KeyAmenities"] != DBNull.Value ? dr["KeyAmenities"].ToString() : "";
                            string[] amenityList = keyAmenities.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                            HashSet<string> amenitySet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                            foreach (string a in amenityList)
                            {
                                amenitySet.Add(a.Trim());
                            }

                            chkAmenity1.Checked = amenitySet.Contains("High-Speed Wi-Fi");
                            chkAmenity2.Checked = amenitySet.Contains("Work Desk");
                            chkAmenity3.Checked = amenitySet.Contains("Coffee Maker");
                            chkAmenity4.Checked = amenitySet.Contains("Private Terrace");
                            chkAmenity5.Checked = amenitySet.Contains("Air Conditioning");
                            chkAmenity6.Checked = amenitySet.Contains("50 Smart TV") || amenitySet.Contains("50\" Smart TV");
                            chkAmenity7.Checked = amenitySet.Contains("Jacuzzi");
                            chkAmenity8.Checked = amenitySet.Contains("Butler Service");

                            // 4. Pre-fill Section 2: Extended Room Details
                            txtHeaderBadge.Value = dr["HeaderBadge"] != DBNull.Value ? dr["HeaderBadge"].ToString() : "";
                            txtHeaderTitle.Value = dr["HeaderTitle"] != DBNull.Value ? dr["HeaderTitle"].ToString() : "";
                            txtHeaderSubtitle.Value = dr["HeaderSubtitle"] != DBNull.Value ? dr["HeaderSubtitle"].ToString() : "";
                            txtFullOverview.Value = dr["FullOverview"] != DBNull.Value ? dr["FullOverview"].ToString() : "";
                            txtHighlights.Value = dr["Highlights"] != DBNull.Value ? dr["Highlights"].ToString() : "";
                            txtReviewQuote.Value = dr["ReviewQuote"] != DBNull.Value ? dr["ReviewQuote"].ToString() : "";
                            txtReviewAuthor.Value = dr["ReviewAuthor"] != DBNull.Value ? dr["ReviewAuthor"].ToString() : "";

                            // 5. Existing Images & Previews
                            string mainImg = dr["PrimaryRoomImage"] != DBNull.Value ? dr["PrimaryRoomImage"].ToString() : "";
                            hdnOldPrimaryImage.Value = mainImg;
                            if (!string.IsNullOrEmpty(mainImg))
                            {
                                pnlCurrentMainImage.Visible = true;
                                imgCurrentMain.Src = ResolveUrl(mainImg);
                                lblCurrentMainPath.InnerText = Path.GetFileName(mainImg);
                            }

                            string headerImg = dr["HeaderImage"] != DBNull.Value ? dr["HeaderImage"].ToString() : "";
                            hdnOldHeaderImage.Value = headerImg;
                            if (!string.IsNullOrEmpty(headerImg))
                            {
                                pnlCurrentHeaderImage.Visible = true;
                                imgCurrentHeader.Src = ResolveUrl(headerImg);
                                lblCurrentHeaderPath.InnerText = Path.GetFileName(headerImg);
                            }

                            string g1 = dr["GalleryImage1"] != DBNull.Value ? dr["GalleryImage1"].ToString() : "";
                            hdnOldGallery1.Value = g1;
                            if (!string.IsNullOrEmpty(g1))
                            {
                                pnlCurrentGallery1.Visible = true;
                                imgCurrentG1.Src = ResolveUrl(g1);
                            }

                            string g2 = dr["GalleryImage2"] != DBNull.Value ? dr["GalleryImage2"].ToString() : "";
                            hdnOldGallery2.Value = g2;
                            if (!string.IsNullOrEmpty(g2))
                            {
                                pnlCurrentGallery2.Visible = true;
                                imgCurrentG2.Src = ResolveUrl(g2);
                            }

                            string g3 = dr["GalleryImage3"] != DBNull.Value ? dr["GalleryImage3"].ToString() : "";
                            hdnOldGallery3.Value = g3;
                            if (!string.IsNullOrEmpty(g3))
                            {
                                pnlCurrentGallery3.Visible = true;
                                imgCurrentG3.Src = ResolveUrl(g3);
                            }

                            string g4 = dr["GalleryImage4"] != DBNull.Value ? dr["GalleryImage4"].ToString() : "";
                            hdnOldGallery4.Value = g4;
                            if (!string.IsNullOrEmpty(g4))
                            {
                                pnlCurrentGallery4.Visible = true;
                                imgCurrentG4.Src = ResolveUrl(g4);
                            }
                        }
                        else
                        {
                            Response.Redirect("ManageHotel.aspx", true);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowErrorMessage("Error loading room data: " + ex.Message);
        }
    }

    // ==========================================
    // SAVE / UPDATE BUTTON HANDLER
    // ==========================================
    protected void btnSaveRoom_Click(object sender, EventArgs e)
    {
        pnlErrorMessage.Visible = false;
        pnlSuccessMessage.Visible = false;

        int roomId = 0;
        int.TryParse(hdnRoomId.Value, out roomId);
        bool isEditMode = (roomId > 0);

        // 1. Retrieve & Validate Form Inputs
        string roomName = txtRoomName.Value.Trim();
        string roomCategory = ddlCategory.Value.Trim();
        if (roomCategory == "__NEW__" || roomCategory == "NEW" || !string.IsNullOrWhiteSpace(txtNewCategory.Value))
        {
            roomCategory = txtNewCategory.Value.Trim().ToUpper();
        }
        string pricePerNight = txtPrice.Value.Trim();
        string categoryBadge = txtBadge.Value.Trim();
        string rating = txtRating.Value.Trim();
        string maxGuests = txtMaxAdults.Value.Trim();
        string roomArea = txtArea.Value.Trim();
        string viewType = txtViewType.Value.Trim();
        string shortDescription = txtShortDesc.Value.Trim();

        string headerBadge = txtHeaderBadge.Value.Trim();
        string headerTitle = txtHeaderTitle.Value.Trim();
        string headerSubtitle = txtHeaderSubtitle.Value.Trim();
        string fullOverview = txtFullOverview.Value.Trim();
        string highlights = txtHighlights.Value.Trim();
        string reviewQuote = txtReviewQuote.Value.Trim();
        string reviewAuthor = txtReviewAuthor.Value.Trim();

        // Basic Validation
        if (string.IsNullOrEmpty(roomName))
        {
            ShowErrorMessage("Room / Suite Title is required.");
            return;
        }

        if (string.IsNullOrEmpty(roomCategory))
        {
            ShowErrorMessage("Please select or enter a Room Category.");
            return;
        }

        decimal parsedPrice;
        if (string.IsNullOrEmpty(pricePerNight) || !decimal.TryParse(pricePerNight, out parsedPrice) || parsedPrice <= 0)
        {
            ShowErrorMessage("Please enter a valid numeric Price Per Night (greater than 0).");
            return;
        }

        // Amenities Checkboxes
        List<string> selectedAmenities = new List<string>();
        if (chkAmenity1.Checked) selectedAmenities.Add("High-Speed Wi-Fi");
        if (chkAmenity2.Checked) selectedAmenities.Add("Work Desk");
        if (chkAmenity3.Checked) selectedAmenities.Add("Coffee Maker");
        if (chkAmenity4.Checked) selectedAmenities.Add("Private Terrace");
        if (chkAmenity5.Checked) selectedAmenities.Add("Air Conditioning");
        if (chkAmenity6.Checked) selectedAmenities.Add("50 Smart TV");
        if (chkAmenity7.Checked) selectedAmenities.Add("Jacuzzi");
        if (chkAmenity8.Checked) selectedAmenities.Add("Butler Service");

        string keyAmenities = string.Join(", ", selectedAmenities);

        // ==========================================
        // 2. IMAGE UPLOAD & PRESERVATION LOGIC
        // Case 1: No new file chosen -> preserve old image
        // Case 2: New file chosen -> save file and update path
        // ==========================================
        string imageFolder = Server.MapPath("~/images/rooms/");
        if (!Directory.Exists(imageFolder))
        {
            Directory.CreateDirectory(imageFolder);
        }

        // Primary Image
        string primaryRoomImage = hdnOldPrimaryImage.Value;
        HttpPostedFile mainImage = Request.Files["fileMainImage"];
        if (mainImage != null && mainImage.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(mainImage.FileName);
            mainImage.SaveAs(Path.Combine(imageFolder, fileName));
            primaryRoomImage = "~/images/rooms/" + fileName;
        }

        if (!isEditMode && string.IsNullOrEmpty(primaryRoomImage))
        {
            ShowErrorMessage("Please upload a Primary Room Image for the new room listing.");
            return;
        }

        // Header Image
        string headerImage = hdnOldHeaderImage.Value;
        HttpPostedFile headerFile = Request.Files["fileHeaderImage"];
        if (headerFile != null && headerFile.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(headerFile.FileName);
            headerFile.SaveAs(Path.Combine(imageFolder, fileName));
            headerImage = "~/images/rooms/" + fileName;
        }

        // Gallery Image 1
        string galleryImage1 = hdnOldGallery1.Value;
        HttpPostedFile galleryFile1 = Request.Files["fileGallery1"];
        if (galleryFile1 != null && galleryFile1.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(galleryFile1.FileName);
            galleryFile1.SaveAs(Path.Combine(imageFolder, fileName));
            galleryImage1 = "~/images/rooms/" + fileName;
        }

        // Gallery Image 2
        string galleryImage2 = hdnOldGallery2.Value;
        HttpPostedFile galleryFile2 = Request.Files["fileGallery2"];
        if (galleryFile2 != null && galleryFile2.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(galleryFile2.FileName);
            galleryFile2.SaveAs(Path.Combine(imageFolder, fileName));
            galleryImage2 = "~/images/rooms/" + fileName;
        }

        // Gallery Image 3
        string galleryImage3 = hdnOldGallery3.Value;
        HttpPostedFile galleryFile3 = Request.Files["fileGallery3"];
        if (galleryFile3 != null && galleryFile3.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(galleryFile3.FileName);
            galleryFile3.SaveAs(Path.Combine(imageFolder, fileName));
            galleryImage3 = "~/images/rooms/" + fileName;
        }

        // Gallery Image 4
        string galleryImage4 = hdnOldGallery4.Value;
        HttpPostedFile galleryFile4 = Request.Files["fileGallery4"];
        if (galleryFile4 != null && galleryFile4.ContentLength > 0)
        {
            string fileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(galleryFile4.FileName);
            galleryFile4.SaveAs(Path.Combine(imageFolder, fileName));
            galleryImage4 = "~/images/rooms/" + fileName;
        }

        // ==========================================
        // 3. DATABASE EXECUTION (INSERT OR UPDATE)
        // ==========================================
        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                if (isEditMode)
                {
                    // ==========================================
                    // SQL UPDATE QUERY WITH STRICT WHERE RoomID = @RoomID
                    // ==========================================
                    string updateQuery = @"
                        UPDATE Rooms
                        SET
                            RoomName = @RoomName,
                            RoomCategory = @RoomCategory,
                            PricePerNight = @PricePerNight,
                            CategoryBadge = @CategoryBadge,
                            Rating = @Rating,
                            MaxGuests = @MaxGuests,
                            RoomArea = @RoomArea,
                            ViewType = @ViewType,
                            PrimaryRoomImage = @PrimaryRoomImage,
                            ShortDescription = @ShortDescription,
                            KeyAmenities = @KeyAmenities,
                            HeaderBadge = @HeaderBadge,
                            HeaderTitle = @HeaderTitle,
                            HeaderSubtitle = @HeaderSubtitle,
                            HeaderImage = @HeaderImage,
                            FullOverview = @FullOverview,
                            Highlights = @Highlights,
                            GalleryImage1 = @GalleryImage1,
                            GalleryImage2 = @GalleryImage2,
                            GalleryImage3 = @GalleryImage3,
                            GalleryImage4 = @GalleryImage4,
                            ReviewQuote = @ReviewQuote,
                            ReviewAuthor = @ReviewAuthor,
                            IsActive = @IsActive
                        WHERE RoomID = @RoomID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomId);
                        BindCommandParameters(cmd, roomName, roomCategory, pricePerNight, categoryBadge, rating,
                            maxGuests, roomArea, viewType, primaryRoomImage, shortDescription, keyAmenities,
                            headerBadge, headerTitle, headerSubtitle, headerImage, fullOverview, highlights,
                            galleryImage1, galleryImage2, galleryImage3, galleryImage4, reviewQuote, reviewAuthor);

                        int rowsUpdated = cmd.ExecuteNonQuery();

                        if (rowsUpdated > 0)
                        {
                            pnlSuccessMessage.Visible = true;
                            lblSuccessTitle.InnerText = "Room Updated Successfully!";
                            lblSuccessDesc.InnerHtml = "The specifications and tariff for <strong>" + Server.HtmlEncode(roomName) + "</strong> have been updated in inventory. <a href=\"ManageHotel.aspx\" class=\"fw-bold text-success text-decoration-underline ms-2\">Return to Manage Hotel &rarr;</a>";

                            // Refresh hidden fields and previews
                            hdnOldPrimaryImage.Value = primaryRoomImage;
                            if (!string.IsNullOrEmpty(primaryRoomImage))
                            {
                                pnlCurrentMainImage.Visible = true;
                                imgCurrentMain.Src = ResolveUrl(primaryRoomImage);
                                lblCurrentMainPath.InnerText = Path.GetFileName(primaryRoomImage);
                            }

                            hdnOldHeaderImage.Value = headerImage;
                            if (!string.IsNullOrEmpty(headerImage))
                            {
                                pnlCurrentHeaderImage.Visible = true;
                                imgCurrentHeader.Src = ResolveUrl(headerImage);
                                lblCurrentHeaderPath.InnerText = Path.GetFileName(headerImage);
                            }
                        }
                        else
                        {
                            ShowErrorMessage("Room could not be updated. Record not found.");
                        }
                    }
                }
                else
                {
                    // ==========================================
                    // SQL INSERT QUERY FOR NEW ROOM
                    // ==========================================
                    string insertQuery = @"
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
                            ReviewAuthor,
                            IsActive
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
                            @ReviewAuthor,
                            @IsActive
                        )";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        BindCommandParameters(cmd, roomName, roomCategory, pricePerNight, categoryBadge, rating,
                            maxGuests, roomArea, viewType, primaryRoomImage, shortDescription, keyAmenities,
                            headerBadge, headerTitle, headerSubtitle, headerImage, fullOverview, highlights,
                            galleryImage1, galleryImage2, galleryImage3, galleryImage4, reviewQuote, reviewAuthor);

                        cmd.ExecuteNonQuery();

                        PopulateRoomCategories();
                        ddlCategory.Value = roomCategory;
                        txtNewCategory.Value = "";

                        pnlSuccessMessage.Visible = true;
                        lblSuccessTitle.InnerText = "Room Published Successfully!";
                        lblSuccessDesc.InnerHtml = "The room entry and full specifications have been published. <a href=\"ManageHotel.aspx\" class=\"fw-bold text-success text-decoration-underline ms-2\">View in Manage Hotel &rarr;</a>";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowErrorMessage("Database operation failed: " + ex.Message);
        }
    }

    // ==========================================
    // HELPER: BIND PARAMETERS TO SQL COMMAND
    // ==========================================
    private void BindCommandParameters(SqlCommand cmd, string roomName, string roomCategory, string pricePerNight,
        string categoryBadge, string rating, string maxGuests, string roomArea, string viewType,
        string primaryRoomImage, string shortDescription, string keyAmenities, string headerBadge,
        string headerTitle, string headerSubtitle, string headerImage, string fullOverview,
        string highlights, string galleryImage1, string galleryImage2, string galleryImage3,
        string galleryImage4, string reviewQuote, string reviewAuthor)
    {
        cmd.Parameters.AddWithValue("@RoomName", roomName ?? "");
        cmd.Parameters.AddWithValue("@RoomCategory", roomCategory ?? "");
        cmd.Parameters.AddWithValue("@PricePerNight", pricePerNight ?? "");
        cmd.Parameters.AddWithValue("@CategoryBadge", categoryBadge ?? "");
        cmd.Parameters.AddWithValue("@Rating", rating ?? "");
        cmd.Parameters.AddWithValue("@MaxGuests", maxGuests ?? "");
        cmd.Parameters.AddWithValue("@RoomArea", roomArea ?? "");
        cmd.Parameters.AddWithValue("@ViewType", viewType ?? "");
        cmd.Parameters.AddWithValue("@PrimaryRoomImage", primaryRoomImage ?? "");
        cmd.Parameters.AddWithValue("@ShortDescription", shortDescription ?? "");
        cmd.Parameters.AddWithValue("@KeyAmenities", keyAmenities ?? "");
        cmd.Parameters.AddWithValue("@HeaderBadge", headerBadge ?? "");
        cmd.Parameters.AddWithValue("@HeaderTitle", headerTitle ?? "");
        cmd.Parameters.AddWithValue("@HeaderSubtitle", headerSubtitle ?? "");
        cmd.Parameters.AddWithValue("@HeaderImage", headerImage ?? "");
        cmd.Parameters.AddWithValue("@FullOverview", fullOverview ?? "");
        cmd.Parameters.AddWithValue("@Highlights", highlights ?? "");
        cmd.Parameters.AddWithValue("@GalleryImage1", galleryImage1 ?? "");
        cmd.Parameters.AddWithValue("@GalleryImage2", galleryImage2 ?? "");
        cmd.Parameters.AddWithValue("@GalleryImage3", galleryImage3 ?? "");
        cmd.Parameters.AddWithValue("@GalleryImage4", galleryImage4 ?? "");
        cmd.Parameters.AddWithValue("@ReviewQuote", reviewQuote ?? "");
        cmd.Parameters.AddWithValue("@ReviewAuthor", reviewAuthor ?? "");
        cmd.Parameters.AddWithValue("@IsActive", ddlIsActive.Value == "1");
    }

    private void ShowErrorMessage(string message)
    {
        pnlErrorMessage.Visible = true;
        lblErrorMessage.Text = message;
    }
}
