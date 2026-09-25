using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

public partial class Admin_EditRoom : System.Web.UI.Page
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
                LoadRoomData(roomId);
            }
            else
            {
                // If no valid RoomId is provided, redirect to Manage Hotel
                Response.Redirect("ManageHotel.aspx", true);
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
    // 1. SELECT EXISTING DATA BY RoomID & PRE-FILL FORM
    // ==========================================
    private void LoadRoomData(int roomId)
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
                            // UI Badges & Links
                            lblHeaderRoomId.InnerText = roomId.ToString();
                            lblCardBadgeRoomId.InnerText = roomId.ToString();
                            lnkLivePreview.HRef = ResolveUrl("~/RoomDetails.aspx?RoomId=" + roomId);

                            // Section 1: Basic Information
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

                            // Key Amenities Checkboxes
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

                            // Section 2: Room Details Specification
                            txtHeaderBadge.Value = dr["HeaderBadge"] != DBNull.Value ? dr["HeaderBadge"].ToString() : "";
                            txtHeaderTitle.Value = dr["HeaderTitle"] != DBNull.Value ? dr["HeaderTitle"].ToString() : "";
                            txtHeaderSubtitle.Value = dr["HeaderSubtitle"] != DBNull.Value ? dr["HeaderSubtitle"].ToString() : "";
                            txtFullOverview.Value = dr["FullOverview"] != DBNull.Value ? dr["FullOverview"].ToString() : "";
                            txtHighlights.Value = dr["Highlights"] != DBNull.Value ? dr["Highlights"].ToString() : "";
                            txtReviewQuote.Value = dr["ReviewQuote"] != DBNull.Value ? dr["ReviewQuote"].ToString() : "";
                            txtReviewAuthor.Value = dr["ReviewAuthor"] != DBNull.Value ? dr["ReviewAuthor"].ToString() : "";

                            // Existing Image Previews & Hidden Field Storage
                            string mainImg = dr["PrimaryRoomImage"] != DBNull.Value ? dr["PrimaryRoomImage"].ToString() : "";
                            hdnOldPrimaryImage.Value = mainImg;
                            if (!string.IsNullOrEmpty(mainImg))
                            {
                                imgCurrentMain.Src = ResolveUrl(mainImg);
                                lblCurrentMainPath.InnerText = Path.GetFileName(mainImg);
                            }
                            else
                            {
                                pnlCurrentMainImage.Visible = false;
                            }

                            string headerImg = dr["HeaderImage"] != DBNull.Value ? dr["HeaderImage"].ToString() : "";
                            hdnOldHeaderImage.Value = headerImg;
                            if (!string.IsNullOrEmpty(headerImg))
                            {
                                imgCurrentHeader.Src = ResolveUrl(headerImg);
                                lblCurrentHeaderPath.InnerText = Path.GetFileName(headerImg);
                            }
                            else
                            {
                                pnlCurrentHeaderImage.Visible = false;
                            }

                            string g1 = dr["GalleryImage1"] != DBNull.Value ? dr["GalleryImage1"].ToString() : "";
                            hdnOldGallery1.Value = g1;
                            if (!string.IsNullOrEmpty(g1))
                            {
                                imgCurrentG1.Src = ResolveUrl(g1);
                            }
                            else
                            {
                                pnlCurrentGallery1.Visible = false;
                            }

                            string g2 = dr["GalleryImage2"] != DBNull.Value ? dr["GalleryImage2"].ToString() : "";
                            hdnOldGallery2.Value = g2;
                            if (!string.IsNullOrEmpty(g2))
                            {
                                imgCurrentG2.Src = ResolveUrl(g2);
                            }
                            else
                            {
                                pnlCurrentGallery2.Visible = false;
                            }

                            string g3 = dr["GalleryImage3"] != DBNull.Value ? dr["GalleryImage3"].ToString() : "";
                            hdnOldGallery3.Value = g3;
                            if (!string.IsNullOrEmpty(g3))
                            {
                                imgCurrentG3.Src = ResolveUrl(g3);
                            }
                            else
                            {
                                pnlCurrentGallery3.Visible = false;
                            }

                            string g4 = dr["GalleryImage4"] != DBNull.Value ? dr["GalleryImage4"].ToString() : "";
                            hdnOldGallery4.Value = g4;
                            if (!string.IsNullOrEmpty(g4))
                            {
                                imgCurrentG4.Src = ResolveUrl(g4);
                            }
                            else
                            {
                                pnlCurrentGallery4.Visible = false;
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
    // 2. UPDATE BUTTON HANDLER (SQL UPDATE WHERE RoomID = @RoomID)
    // ==========================================
    protected void btnUpdateRoom_Click(object sender, EventArgs e)
    {
        pnlErrorMessage.Visible = false;
        pnlSuccessMessage.Visible = false;

        int roomId;
        if (!int.TryParse(hdnRoomId.Value, out roomId) || roomId <= 0)
        {
            ShowErrorMessage("Invalid Room identifier. Cannot perform update.");
            return;
        }

        // Retrieve & Validate Form Inputs
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

        // Validation
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
        // 3. IMAGE PRESERVATION / UPLOAD LOGIC
        // Case 1: No new image selected -> Keep existing image
        // Case 2: New image uploaded -> Save new image and update URL
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
        // 4. SQL UPDATE EXECUTION
        // ==========================================
        try
        {
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
                    ReviewAuthor = @ReviewAuthor
                WHERE RoomID = @RoomID";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@RoomID", roomId);
                    cmd.Parameters.AddWithValue("@RoomName", roomName);
                    cmd.Parameters.AddWithValue("@RoomCategory", roomCategory);
                    cmd.Parameters.AddWithValue("@PricePerNight", pricePerNight);
                    cmd.Parameters.AddWithValue("@CategoryBadge", categoryBadge);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@MaxGuests", maxGuests);
                    cmd.Parameters.AddWithValue("@RoomArea", roomArea);
                    cmd.Parameters.AddWithValue("@ViewType", viewType);
                    cmd.Parameters.AddWithValue("@PrimaryRoomImage", primaryRoomImage);
                    cmd.Parameters.AddWithValue("@ShortDescription", shortDescription);
                    cmd.Parameters.AddWithValue("@KeyAmenities", keyAmenities);
                    cmd.Parameters.AddWithValue("@HeaderBadge", headerBadge);
                    cmd.Parameters.AddWithValue("@HeaderTitle", headerTitle);
                    cmd.Parameters.AddWithValue("@HeaderSubtitle", headerSubtitle);
                    cmd.Parameters.AddWithValue("@HeaderImage", headerImage);
                    cmd.Parameters.AddWithValue("@FullOverview", fullOverview);
                    cmd.Parameters.AddWithValue("@Highlights", highlights);
                    cmd.Parameters.AddWithValue("@GalleryImage1", galleryImage1);
                    cmd.Parameters.AddWithValue("@GalleryImage2", galleryImage2);
                    cmd.Parameters.AddWithValue("@GalleryImage3", galleryImage3);
                    cmd.Parameters.AddWithValue("@GalleryImage4", galleryImage4);
                    cmd.Parameters.AddWithValue("@ReviewQuote", reviewQuote);
                    cmd.Parameters.AddWithValue("@ReviewAuthor", reviewAuthor);

                    con.Open();
                    int rowsUpdated = cmd.ExecuteNonQuery();

                    if (rowsUpdated > 0)
                    {
                        PopulateRoomCategories();
                        ddlCategory.Value = roomCategory;
                        txtNewCategory.Value = "";

                        pnlSuccessMessage.Visible = true;
                        lblSuccessDesc.InnerHtml = "The specifications and tariff for <strong>" + Server.HtmlEncode(roomName) + "</strong> have been updated in inventory. <a href=\"ManageHotel.aspx\" class=\"fw-bold text-success text-decoration-underline ms-2\">Return to Manage Hotel &rarr;</a>";

                        // Update hidden fields and previews
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
        }
        catch (Exception ex)
        {
            ShowErrorMessage("Database update failed: " + ex.Message);
        }
    }

    private void ShowErrorMessage(string message)
    {
        pnlErrorMessage.Visible = true;
        lblErrorMessage.Text = message;
    }
}
