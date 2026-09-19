<%@ Page Title="Add New Room & Suite | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AddRoom.aspx.cs" Inherits="Admin_AddRoom" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management Add New Room Form">
        <style>
            .add-room-card {
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 20px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
                overflow: hidden;
            }

            .add-room-header {
                background: linear-gradient(135deg, #442305 0%, #6a390a 100%);
                color: #ffffff;
                padding: 20px 28px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .form-label-custom {
                font-size: 0.8rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: #475569;
                margin-bottom: 6px;
            }

            .form-control-admin,
            .form-select-admin {
                border: 1.5px solid #cbd5e1;
                border-radius: 10px;
                padding: 10px 14px;
                font-size: 0.92rem;
                color: #0f172a;
                font-weight: 500;
                background-color: #ffffff;
                transition: all 0.25s ease;
            }

            .form-control-admin:focus,
            .form-select-admin:focus {
                border-color: #B88E68;
                box-shadow: 0 0 0 4px rgba(184, 142, 104, 0.15);
                outline: none;
            }

            .amenity-pill {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 8px 16px;
                background: #f8fafc;
                border: 1.5px solid #e2e8f0;
                border-radius: 30px;
                font-size: 0.85rem;
                font-weight: 600;
                color: #334155;
                cursor: pointer;
                transition: all 0.2s ease;
                user-select: none;
            }

            .amenity-pill:hover,
            .amenity-pill:has(input[type="checkbox"]:checked) {
                background: #fef7f0;
                border-color: #B88E68;
                color: #442305;
                box-shadow: 0 2px 8px rgba(184, 142, 104, 0.2);
            }

            .amenity-category-box {
                background: #fdfaf7;
                border: 1px solid #f0e6d8;
                border-radius: 14px;
                padding: 18px;
                height: 100%;
            }

            .amenity-category-title {
                font-family: 'Playfair Display', Georgia, serif;
                font-weight: 700;
                font-size: 1rem;
                color: #442305;
                margin-bottom: 12px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .gallery-slot-box {
                border: 1.5px dashed #cbd5e1;
                border-radius: 12px;
                padding: 12px;
                background: #f8fafc;
                transition: all 0.25s ease;
            }

            .gallery-slot-box:hover {
                border-color: #B88E68;
                background: #fffdfa;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Page Header & Navigation -->
        <div class="d-flex align-items-center justify-content-between mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Add New Room
                    &amp; Room Details</h2>
                <p class="text-muted small mb-0">Fill out room basic information and complete room detail specifications
                    in a single unified form.</p>
            </div>
            <a href="Rooms.aspx" class="btn-admin-secondary">
                <i class="bi bi-arrow-left"></i> Back to Rooms List
            </a>
        </div>

        <!-- Alert Message -->
        <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false"
            CssClass="alert alert-success alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
            <div class="d-flex align-items-center gap-3">
                <i class="bi bi-check-circle-fill fs-3 text-success"></i>
                <div>
                    <strong class="d-block text-dark">Room Published Successfully!</strong>
                    <span class="small text-muted">The room entry and full specifications have been published.</span>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <!-- Single Focused Add Room Form Card -->
        <div class="add-room-card">
            <div class="add-room-header">
                <h4 class="mb-0 fw-bold d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                    <i class="bi bi-door-open-fill text-warning"></i> Add New Room Form
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">Room Entry
                    Form</span>
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
                        <label class="form-label-custom" for="txtRoomName">Room / Suite Title <span
                                class="text-danger">*</span></label>
                        <input type="text" id="txtRoomName" name="txtRoomName" class="form-control form-control-admin"
                            placeholder="e.g. Executive Business Suite" value="Executive Business Suite">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-custom" for="ddlCategory">Room Category Filter <span
                                class="text-danger">*</span></label>
                        <select id="ddlCategory" name="ddlCategory" class="form-select form-select-admin">
                            <option value="EXECUTIVE" selected>EXECUTIVE</option>
                            <option value="DELUXE">DELUXE</option>
                            <option value="FAMILY">FAMILY</option>
                            <option value="ROYAL KING">ROYAL KING</option>
                            <option value="PENTHOUSE">PENTHOUSE</option>
                        </select>
                    </div>

                    <!-- 2. Price & Rating -->
                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtPrice">Price Per Night (&#8377;) <span
                                class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light fw-bold border-end-0">&#8377;</span>
                            <input type="number" id="txtPrice" name="txtPrice"
                                class="form-control form-control-admin border-start-0 ps-1" placeholder="8500"
                                value="8500">
                        </div>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtBadge">Category Badge Tag</label>
                        <input type="text" id="txtBadge"  name="txtBadge" class="form-control form-control-admin"
                            placeholder="e.g. EXECUTIVE" value="EXECUTIVE">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtRating">Rating Score (Out of 5.0)</label>
                        <input type="text" id="txtRating" name="txtRating" class="form-control form-control-admin" placeholder="e.g. 4.9"
                            value="4.9">
                    </div>

                    <!-- 3. Specifications (Guests, Area, View) -->
                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtMaxAdults">Max Guests Capacity</label>
                        <input type="text" id="txtMaxAdults" name="txtMaxAdults" class="form-control form-control-admin"
                            placeholder="e.g. 2 Guests" value="2 Guests">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtArea">Room Size / Area</label>
                        <input type="text" id="txtArea" name="txtArea" class="form-control form-control-admin" placeholder="e.g. 55 m²"
                            value="55 m²">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtViewType">View Type</label>
                        <input type="text" id="txtViewType"  name="txtViewType" class="form-control form-control-admin"
                            placeholder="e.g. City View, Garden View, Pool View" value="City View">
                    </div>

                    <!-- 4. Room Image Selection -->
                    <div class="col-12">
                        <label class="form-label-custom" for="fileMainImage">Primary Room Image <span
                                class="text-danger">*</span></label>
                        <input type="file" id="fileMainImage"  name="fileMainImage" accept="image/*" class="form-control form-control-admin">
                    </div>

                    <!-- 5. Short Description -->
                    <div class="col-12">
                        <label class="form-label-custom" for="txtShortDesc">Short Card Description <span
                                class="text-danger">*</span></label>
                        <textarea id="txtShortDesc" name="txtShortDesc" class="form-control form-control-admin" rows="2"
                            placeholder="Brief summary shown on room card...">Crafted for modern business leaders, featuring ergonomic workstation, soundproof windows, high-speed Wi-Fi & luxury king bedding.</textarea>
                    </div>

                    <!-- 6. Card Key Amenities -->
                    <div class="col-12">
                        <label class="form-label-custom mb-2">Key Card Amenities (Select 3 Features)</label>
                        <div class="d-flex flex-wrap gap-2">
                            <label class="amenity-pill">
                                <input type="checkbox"  name="amenities" class="d-none" checked value="High-Speed Wi-Fi">
                                <i class="bi bi-wifi text-gold"></i> <span>High-Speed Wi-Fi</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" checked value="Work Desk">
                                <i class="bi bi-laptop text-gold"></i> <span>Work Desk</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" checked value="Coffee Maker">
                                <i class="bi bi-cup-hot text-gold"></i> <span>Coffee Maker</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" value="Private Terrace">
                                <i class="bi bi-sun text-gold"></i> <span>Private Terrace</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" value="Air Conditioning">
                                <i class="bi bi-snow text-gold"></i> <span>Air Conditioning</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" value="50 Smart TV">
                                <i class="bi bi-tv text-gold"></i> <span>50" Smart TV</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" value="Jacuzzi">
                                <i class="bi bi-water text-gold"></i> <span>Jacuzzi</span>
                            </label>
                            <label class="amenity-pill">
                                <input type="checkbox" name="amenities" class="d-none" value="Butler Service">
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
                                    gallery, detailed overview, amenities, guest reviews, and policies for RoomDetails
                                    page.</p>
                            </div>
                            <span
                                class="badge bg-gold-subtle text-gold px-3 py-1.5 rounded-pill font-monospace small">Room
                                Details Config</span>
                        </div>
                    </div>

                    <!-- Hero Banner & Subtitle -->
                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtHeaderBadge">Top Banner Badge</label>
                        <input type="text" id="txtHeaderBadge"name="txtHeaderBadge" class="form-control form-control-admin"
                            placeholder="e.g. ROYAL ACCOMMODATION" value="ROYAL ACCOMMODATION">
                    </div>

                    <div class="col-md-8">
                        <label class="form-label-custom" for="txtHeaderTitle">Page Hero Title</label>
                        <input type="text" id="txtHeaderTitle" name="txtHeaderTitle" class="form-control form-control-admin"
                            placeholder="e.g. Executive Business Suite" value="Executive Business Suite">
                    </div>

                    <div class="col-12">
                        <label class="form-label-custom" for="txtHeaderSubtitle">Page Subtitle Tagline</label>
                        <input type="text" id="txtHeaderSubtitle" name="txtHeaderSubtitle" class="form-control form-control-admin"
                            placeholder="Tagline displayed on room details hero..."
                            value="Experience royal luxury, panoramic views, and world-class butler service tailored for your stay.">
                    </div>

                    <div class="col-12">
                        <label class="form-label-custom" for="fileHeaderImage">Featured Room Header Image</label>
                        <input type="file" id="fileHeaderImage" name="fileHeaderImage" accept="image/*"
                            class="form-control form-control-admin">
                    </div>

                    <!-- Detailed Overview Text -->
                    <div class="col-12">
                        <label class="form-label-custom" for="txtFullOverview">Detailed Room Overview (Full Page
                            Description)</label>
                        <textarea id="txtFullOverview" name="txtFullOverview" class="form-control form-control-admin" rows="3"
                            placeholder="Comprehensive suite description shown on RoomDetails.aspx...">Designed specifically for high-profile business travelers and discerning executives, the Executive Business Suite pairs state-of-the-art workstation capabilities with opulent residential comfort. Enjoy high-speed optical fiber connectivity, acoustic soundproofing, an ensuite marble bathroom, and 24-hour dedicated butler assistance.</textarea>
                    </div>

                    <!-- Highlights Bullets -->
                    <div class="col-12">
                        <label class="form-label-custom" for="txtHighlights">Suite Key Highlights
                            (Comma-separated)</label>
                        <input type="text" id="txtHighlights" name="txtHighlights" class="form-control form-control-admin"
                            placeholder="e.g. Panoramic Skyline View, Ergonomic Workstation, Italian Marble Ensuite, Soundproof Windows"
                            value="Panoramic Skyline View, Ergonomic Workstation, Italian Marble Ensuite, Soundproof Windows">
                    </div>

                    <!-- Photo Gallery Slots (6 Slots with File Upload) -->
                    <div class="col-12">
                        <label class="form-label-custom mb-2">Room Photo Gallery Slots (6 File Uploads)</label>
                        <div class="row g-3">
                            <!-- Slot 1 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery1">Photo Slot 1
                                        (Main)</label>
                                    <input type="file" id="fileGallery1" name="fileGallery1" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>

                            <!-- Slot 2 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery2">Photo Slot 2
                                        (Bedding)</label>
                                    <input type="file" id="fileGallery2" name="fileGallery2" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>

                            <!-- Slot 3 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery3">Photo Slot 3
                                        (Bathroom)</label>
                                    <input type="file" id="fileGallery3" name="fileGallery3" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>

                            <!-- Slot 4 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery4">Photo Slot 4
                                        (Balcony)</label>
                                    <input type="file" id="fileGallery4" name="fileGallery4" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>

                            <!-- Slot 5 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery5">Photo Slot 5
                                        (Lounge)</label>
                                    <input type="file" id="fileGallery5"name="fileGallery5" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>

                            <!-- Slot 6 -->
                            <div class="col-md-4 col-sm-6">
                                <div class="gallery-slot-box p-3">
                                    <label class="form-label-custom small mb-2" for="fileGallery6">Photo Slot 6
                                        (View)</label>
                                    <input type="file" id="fileGallery6" name="fileGallery6" accept="image/*"
                                        class="form-control form-control-admin form-control-sm">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Guest Review Quote -->
                    <div class="col-md-8">
                        <label class="form-label-custom" for="txtReviewQuote">Featured Guest Review Quote</label>
                        <input type="text" id="txtReviewQuote" name="txtReviewQuote" class="form-control form-control-admin"
                            placeholder="e.g. An unmatchable luxury stay experience with exemplary butler service."
                            value="An unmatchable luxury stay experience with exemplary butler service.">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label-custom" for="txtReviewAuthor">Guest Name &amp; Designation</label>
                        <input type="text" id="txtReviewAuthor" name="txtReviewAuthor" class="form-control form-control-admin"
                            placeholder="e.g. Marcus Vance • Corporate Guest" value="Marcus Vance • Corporate Guest">
                    </div>


                </div>

                <!-- Form Action Footer Buttons -->
                <div class="d-flex align-items-center justify-content-between pt-4 mt-4 border-top">
                    <button type="button" class="btn-admin-secondary" onclick="resetForm()">
                        <i class="bi bi-arrow-counterclockwise"></i> Clear Form
                    </button>
                    <div class="d-flex align-items-center gap-2">
                        <a href="Rooms.aspx" class="btn-admin-secondary">Cancel</a>
                        <asp:Button ID="btnSaveRoom" runat="server" Text="Save &amp; Publish Room"
                            CssClass="btn-admin-primary" onclick="btnSaveRoom_Click" />
                    </div>
                </div>
            </div>
        </div>

        <script>
            function previewUploadedImage(fileInput, targetInputId, previewImgId) {
                if (fileInput.files && fileInput.files[0]) {
                    var file = fileInput.files[0];
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var targetInput = document.getElementById(targetInputId);
                        if (targetInput) targetInput.value = 'images/' + file.name;
                        var previewImg = document.getElementById(previewImgId);
                        if (previewImg) {
                            previewImg.src = e.target.result;
                            previewImg.style.display = 'inline-block';
                        }
                        if (window.showAdminToast) {
                            window.showAdminToast('File Selected', file.name + ' uploaded to preview.', 'bi-image text-success');
                        }
                    };
                    reader.readAsDataURL(file);
                }
            }

            function resetForm() {
                var inputs = document.querySelectorAll('#adminForm input[type="text"], #adminForm input[type="number"], #adminForm textarea');
                inputs.forEach(function (input) {
                    input.value = '';
                });

                var selects = document.querySelectorAll('#adminForm select');
                selects.forEach(function (select) {
                    select.selectedIndex = 0;
                });

                var checkboxes = document.querySelectorAll('#adminForm input[type="checkbox"]');
                checkboxes.forEach(function (cb) {
                    cb.checked = false;
                });

                if (window.showAdminToast) {
                    window.showAdminToast('Form Cleared', 'All basic room and room detail fields have been reset.', 'bi-arrow-counterclockwise text-primary');
                }
            }
        </script>
    </asp:Content>