<%@ Page Title="Add New Room & Suite | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AddRoom.aspx.cs" Inherits="Admin_AddRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Add / Edit Room Form">
    <link rel="stylesheet" type="text/css" href="css/addroom.css">
    <style>
        .current-image-preview-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 14px;
            background: #faf8f5;
            border: 1px solid #e8decb;
            border-radius: 10px;
            margin-bottom: 8px;
        }
        .current-image-thumb {
            width: 70px;
            height: 50px;
            object-fit: cover;
            border-radius: 6px;
            border: 1.5px solid #cbd5e1;
        }
        .current-image-slot-thumb {
            width: 100%;
            height: 90px;
            object-fit: cover;
            border-radius: 6px;
            border: 1.5px solid #cbd5e1;
            margin-bottom: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Hidden Field for Room ID -->
    <asp:HiddenField ID="hdnRoomId" runat="server" Value="0" />

    <!-- Hidden Fields for Preserving Existing Images when No New File Uploaded -->
    <asp:HiddenField ID="hdnOldPrimaryImage" runat="server" />
    <asp:HiddenField ID="hdnOldHeaderImage" runat="server" />
    <asp:HiddenField ID="hdnOldGallery1" runat="server" />
    <asp:HiddenField ID="hdnOldGallery2" runat="server" />
    <asp:HiddenField ID="hdnOldGallery3" runat="server" />
    <asp:HiddenField ID="hdnOldGallery4" runat="server" />

    <!-- Page Header & Navigation -->
    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h2 id="lblPageTitle" runat="server" class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">
                Add New Room &amp; Room Details
            </h2>
            <p id="lblPageSubtitle" runat="server" class="text-muted small mb-0">
                Fill out room basic information and complete room detail specifications in a single unified form.
            </p>
        </div>
        <a href="ManageHotel.aspx" class="btn-admin-secondary">
            <i class="bi bi-arrow-left"></i> Back to Manage Hotel
        </a>
    </div>

    <!-- Error Alert Message -->
    <asp:Panel ID="pnlErrorMessage" runat="server" Visible="false"
        CssClass="alert alert-danger alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-exclamation-triangle-fill fs-3 text-danger"></i>
            <div>
                <strong class="d-block text-dark">Validation Error</strong>
                <asp:Label ID="lblErrorMessage" runat="server" CssClass="small text-danger"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Success Alert Message -->
    <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false"
        CssClass="alert alert-success alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-check-circle-fill fs-3 text-success"></i>
            <div>
                <strong id="lblSuccessTitle" runat="server" class="d-block text-dark">Room Published Successfully!</strong>
                <span id="lblSuccessDesc" runat="server" class="small text-muted">The room entry and full specifications have been saved.</span>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Single Focused Room Form Card -->
    <div class="add-room-card">
        <div class="add-room-header">
            <h4 id="lblCardHeader" runat="server" class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                <i class="bi bi-door-open-fill text-warning"></i> Add New Room Form
            </h4>
            <span id="lblBadge" runat="server" class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                Room Entry Form
            </span>
        </div>

        <div class="p-4">
            <div class="row g-4">

                <!-- ==========================================
                 SECTION 1: BASIC ROOM CARD INFORMATION
                 ========================================== -->
                <div class="col-12">
                    <h6 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2" style="font-size: 0.95rem;">
                        <i class="bi bi-card-heading text-gold"></i> 1. Basic Room Listing Information
                    </h6>
                </div>

                <!-- 1. Room Name & Category -->
                <div class="col-md-8">
                    <label class="form-label-custom" for="txtRoomName">Room / Suite Title <span class="text-danger">*</span></label>
                    <input type="text" id="txtRoomName" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. Executive Business Suite" />
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="ddlCategory">Room Category Filter <span class="text-danger">*</span></label>
                    <select id="ddlCategory" runat="server" ClientIDMode="Static" class="form-select form-select-admin" onchange="toggleNewRoomCategory(this);">
                        <option value="" selected disabled>Select Category</option>
                        <option value="EXECUTIVE">EXECUTIVE</option>
                        <option value="DELUXE">DELUXE</option>
                        <option value="FAMILY">FAMILY</option>
                        <option value="ROYAL KING">ROYAL KING</option>
                        <option value="PENTHOUSE">PENTHOUSE</option>
                        <option value="__NEW__">+ Add New Category...</option>
                    </select>
                    <input type="text" id="txtNewCategory" runat="server" ClientIDMode="Static" class="form-control form-control-admin mt-2"
                        placeholder="Enter new room category..." style="display:none;" />
                </div>

                <!-- 2. Price & Rating -->
                <div class="col-md-4">
                    <label class="form-label-custom" for="txtPrice">Price Per Night (&#8377;) <span class="text-danger">*</span></label>
                    <div class="input-group">
                        <span class="input-group-text bg-light fw-bold border-end-0">&#8377;</span>
                        <input type="number" id="txtPrice" runat="server" ClientIDMode="Static"
                            class="form-control form-control-admin border-start-0 ps-1" placeholder="e.g. 8500" />
                    </div>
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="txtBadge">Category Badge Tag</label>
                    <input type="text" id="txtBadge" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. EXECUTIVE" />
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="txtRating">Rating Score (Out of 5.0)</label>
                    <input type="text" id="txtRating" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. 4.9" />
                </div>

                <!-- 3. Specifications (Guests, Area, View) -->
                <div class="col-md-4">
                    <label class="form-label-custom" for="txtMaxAdults">Max Guests Capacity</label>
                    <input type="text" id="txtMaxAdults" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. 2 Guests" />
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="txtArea">Room Size / Area</label>
                    <input type="text" id="txtArea" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. 55 m²" />
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="txtViewType">View Type</label>
                    <input type="text" id="txtViewType" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        placeholder="e.g. City View, Garden View, Pool View" />
                </div>

                <div class="col-md-4">
                    <label class="form-label-custom" for="ddlIsActive">Publishing Status <span class="text-danger">*</span></label>
                    <select id="ddlIsActive" runat="server" ClientIDMode="Static" class="form-select form-select-admin">
                        <option value="1" selected="selected">Active (Published on Guest Site)</option>
                        <option value="0">Inactive (Hidden from Guest Site)</option>
                    </select>
                </div>

                <!-- 4. Room Image Selection -->
                <div class="col-12">
                    <label class="form-label-custom" for="fileMainImage">
                        Primary Room Image <span id="reqStarMainImg" runat="server" class="text-danger">*</span>
                    </label>

                    <!-- Current Image Preview in Edit Mode -->
                    <div id="pnlCurrentMainImage" runat="server" visible="false" class="current-image-preview-box">
                        <img id="imgCurrentMain" runat="server" class="current-image-thumb" src="" alt="Current Room Image" />
                        <div>
                            <span class="small fw-bold text-dark d-block">Current Image:</span>
                            <span id="lblCurrentMainPath" runat="server" class="small text-muted font-monospace"></span>
                            <span class="badge bg-secondary-subtle text-secondary small d-block mt-1">Leave file input empty to keep current image</span>
                        </div>
                    </div>

                    <input type="file" id="fileMainImage" name="fileMainImage" accept="image/*" class="form-control form-control-admin" />
                </div>

                <!-- 5. Short Description -->
                <div class="col-12">
                    <label class="form-label-custom" for="txtShortDesc">Short Card Description <span class="text-danger">*</span></label>
                    <textarea id="txtShortDesc" runat="server" ClientIDMode="Static" class="form-control form-control-admin" rows="2"
                        placeholder="Brief summary shown on room card..."></textarea>
                </div>

                <!-- 6. Card Key Amenities -->
                <div class="col-12">
                    <label class="form-label-custom mb-2">Key Card Amenities (Select Features)</label>
                    <div class="d-flex flex-wrap gap-2">
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity1" runat="server" ClientIDMode="Static" class="d-none" value="High-Speed Wi-Fi" />
                            <i class="bi bi-wifi text-gold"></i> <span>High-Speed Wi-Fi</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity2" runat="server" ClientIDMode="Static" class="d-none" value="Work Desk" />
                            <i class="bi bi-laptop text-gold"></i> <span>Work Desk</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity3" runat="server" ClientIDMode="Static" class="d-none" value="Coffee Maker" />
                            <i class="bi bi-cup-hot text-gold"></i> <span>Coffee Maker</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity4" runat="server" ClientIDMode="Static" class="d-none" value="Private Terrace" />
                            <i class="bi bi-sun text-gold"></i> <span>Private Terrace</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity5" runat="server" ClientIDMode="Static" class="d-none" value="Air Conditioning" />
                            <i class="bi bi-snow text-gold"></i> <span>Air Conditioning</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity6" runat="server" ClientIDMode="Static" class="d-none" value="50 Smart TV" />
                            <i class="bi bi-tv text-gold"></i> <span>50" Smart TV</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity7" runat="server" ClientIDMode="Static" class="d-none" value="Jacuzzi" />
                            <i class="bi bi-water text-gold"></i> <span>Jacuzzi</span>
                        </label>
                        <label class="amenity-pill">
                            <input type="checkbox" name="amenities" id="chkAmenity8" runat="server" ClientIDMode="Static" class="d-none" value="Butler Service" />
                            <i class="bi bi-person-badge text-gold"></i> <span>Butler Service</span>
                        </label>
                    </div>
                </div>

                <!-- ==========================================
                 SECTION 2: ROOM DETAILS SPECIFICATION FORM
                 ========================================== -->
                <div class="col-12 pt-4 border-top">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <div>
                            <h5 class="fw-bold text-dark mb-1 d-flex align-items-center gap-2"
                                style="font-size: 1.05rem; font-family: 'Playfair Display', Georgia, serif;">
                                <i class="bi bi-sliders text-gold"></i> Room Details Specification Form
                            </h5>
                            <p class="text-muted small mb-0">Extended room specifications, hero banner, photo
                                gallery, detailed overview, amenities, guest reviews, and policies for RoomDetails page.</p>
                        </div>
                        <span class="badge bg-gold-subtle text-gold px-3 py-1.5 rounded-pill font-monospace small">Room Details Config</span>
                    </div>
                </div>

                <!-- Hero Banner & Subtitle -->
                <div class="col-md-4">
                    <label class="form-label-custom" for="txtHeaderBadge">Top Banner Badge</label>
                    <input type="text" id="txtHeaderBadge" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin" placeholder="e.g. ROYAL ACCOMMODATION" />
                </div>

                <div class="col-md-8">
                    <label class="form-label-custom" for="txtHeaderTitle">Page Hero Title</label>
                    <input type="text" id="txtHeaderTitle" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin" placeholder="e.g. Executive Business Suite" />
                </div>

                <div class="col-12">
                    <label class="form-label-custom" for="txtHeaderSubtitle">Page Subtitle Tagline</label>
                    <input type="text" id="txtHeaderSubtitle" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin" placeholder="Tagline displayed on room details hero..." />
                </div>

                <div class="col-12">
                    <label class="form-label-custom" for="fileHeaderImage">Featured Room Header Image</label>
                    
                    <!-- Current Header Image Preview in Edit Mode -->
                    <div id="pnlCurrentHeaderImage" runat="server" visible="false" class="current-image-preview-box">
                        <img id="imgCurrentHeader" runat="server" class="current-image-thumb" src="" alt="Current Header Image" />
                        <div>
                            <span class="small fw-bold text-dark d-block">Current Header Image:</span>
                            <span id="lblCurrentHeaderPath" runat="server" class="small text-muted font-monospace"></span>
                            <span class="badge bg-secondary-subtle text-secondary small d-block mt-1">Leave file input empty to keep current image</span>
                        </div>
                    </div>

                    <input type="file" id="fileHeaderImage" name="fileHeaderImage" accept="image/*" class="form-control form-control-admin" />
                </div>

                <!-- Detailed Overview Text -->
                <div class="col-12">
                    <label class="form-label-custom" for="txtFullOverview">Detailed Room Overview (Full Page Description)</label>
                    <textarea id="txtFullOverview" runat="server" ClientIDMode="Static" class="form-control form-control-admin"
                        rows="3" placeholder="Comprehensive suite description shown on RoomDetails.aspx..."></textarea>
                </div>

                <!-- Highlights Bullets -->
                <div class="col-12">
                    <label class="form-label-custom" for="txtHighlights">Suite Key Highlights (Comma-separated)</label>
                    <input type="text" id="txtHighlights" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin"
                        placeholder="e.g. Panoramic Skyline View, Ergonomic Workstation, Italian Marble Ensuite, Soundproof Windows" />
                </div>

                <!-- Photo Gallery Slots (4 Slots with File Upload) -->
                <div class="col-12">
                    <label class="form-label-custom mb-2">Room Photo Gallery Slots (4 File Uploads)</label>
                    <div class="row g-3">
                        <!-- Slot 1 -->
                        <div class="col-md-3 col-sm-6">
                            <div class="gallery-slot-box p-3">
                                <label class="form-label-custom small mb-2" for="fileGallery1">Photo Slot 1 (Main)</label>
                                <div id="pnlCurrentGallery1" runat="server" visible="false" class="mb-2">
                                    <img id="imgCurrentG1" runat="server" class="current-image-slot-thumb" src="" alt="Slot 1 Image" />
                                </div>
                                <input type="file" id="fileGallery1" name="fileGallery1" accept="image/*"
                                    class="form-control form-control-admin form-control-sm" />
                            </div>
                        </div>

                        <!-- Slot 2 -->
                        <div class="col-md-3 col-sm-6">
                            <div class="gallery-slot-box p-3">
                                <label class="form-label-custom small mb-2" for="fileGallery2">Photo Slot 2 (Bedding)</label>
                                <div id="pnlCurrentGallery2" runat="server" visible="false" class="mb-2">
                                    <img id="imgCurrentG2" runat="server" class="current-image-slot-thumb" src="" alt="Slot 2 Image" />
                                </div>
                                <input type="file" id="fileGallery2" name="fileGallery2" accept="image/*"
                                    class="form-control form-control-admin form-control-sm" />
                            </div>
                        </div>

                        <!-- Slot 3 -->
                        <div class="col-md-3 col-sm-6">
                            <div class="gallery-slot-box p-3">
                                <label class="form-label-custom small mb-2" for="fileGallery3">Photo Slot 3 (Bathroom)</label>
                                <div id="pnlCurrentGallery3" runat="server" visible="false" class="mb-2">
                                    <img id="imgCurrentG3" runat="server" class="current-image-slot-thumb" src="" alt="Slot 3 Image" />
                                </div>
                                <input type="file" id="fileGallery3" name="fileGallery3" accept="image/*"
                                    class="form-control form-control-admin form-control-sm" />
                            </div>
                        </div>

                        <!-- Slot 4 -->
                        <div class="col-md-3 col-sm-6">
                            <div class="gallery-slot-box p-3">
                                <label class="form-label-custom small mb-2" for="fileGallery4">Photo Slot 4 (Balcony)</label>
                                <div id="pnlCurrentGallery4" runat="server" visible="false" class="mb-2">
                                    <img id="imgCurrentG4" runat="server" class="current-image-slot-thumb" src="" alt="Slot 4 Image" />
                                </div>
                                <input type="file" id="fileGallery4" name="fileGallery4" accept="image/*"
                                    class="form-control form-control-admin form-control-sm" />
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Guest Review Quote -->
                <div class="col-md-8">
                    <label class="form-label-custom" for="txtReviewQuote">Featured Guest Review Quote</label>
                    <input type="text" id="txtReviewQuote" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin"
                        placeholder="e.g. An unmatchable luxury stay experience with exemplary butler service." />
                </div>
                <div class="col-md-4">
                    <label class="form-label-custom" for="txtReviewAuthor">Guest Name &amp; Designation</label>
                    <input type="text" id="txtReviewAuthor" runat="server" ClientIDMode="Static"
                        class="form-control form-control-admin" placeholder="e.g. Marcus Vance • Corporate Guest" />
                </div>

            </div>

            <!-- Form Action Footer Buttons -->
            <div class="d-flex align-items-center justify-content-between pt-4 mt-4 border-top">
                <button type="button" class="btn-admin-secondary" onclick="resetForm()">
                    <i class="bi bi-arrow-counterclockwise"></i> Clear Form
                </button>
                <div class="d-flex align-items-center gap-2">
                    <a href="ManageHotel.aspx" class="btn-admin-secondary">Cancel</a>
                    <asp:Button ID="btnSaveRoom" runat="server" Text="Save &amp; Publish Room"
                        CssClass="btn-admin-primary" onclick="btnSaveRoom_Click" />
                </div>
            </div>
        </div>
    </div>

    <script src="js/addroom.js"></script>
    <script type="text/javascript">
        function toggleNewRoomCategory(sel) {
            var txt = document.getElementById('txtNewCategory');
            if (!txt) return;
            if (sel.value === '__NEW__' || sel.value === 'NEW') {
                txt.style.display = 'block';
                txt.focus();
            } else {
                txt.style.display = 'none';
            }
        }
        window.addEventListener('DOMContentLoaded', function () {
            var sel = document.getElementById('ddlCategory');
            if (sel && (sel.value === '__NEW__' || sel.value === 'NEW')) {
                var txt = document.getElementById('txtNewCategory');
                if (txt) txt.style.display = 'block';
            }
        });
    </script>
</asp:Content>