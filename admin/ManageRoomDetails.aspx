<%@ Page Title="Room Details Page Config | Admin Panel" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageRoomDetails.aspx.cs" Inherits="Admin_ManageRoomDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <style>
        .admin-form-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
            margin-bottom: 24px;
            overflow: hidden;
        }

        .admin-card-header {
            background: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
            padding: 16px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-card-title {
            font-size: 1.05rem;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-card-title i {
            color: #B88E68;
            font-size: 1.2rem;
        }

        .admin-card-body {
            padding: 24px;
        }

        .form-label-custom {
            font-size: 0.82rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #475569;
            margin-bottom: 6px;
        }

        .form-control-admin, .form-select-admin {
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 0.92rem;
            color: #0f172a;
            font-weight: 500;
            background-color: #ffffff;
            transition: all 0.25s ease;
        }

        .form-control-admin:focus, .form-select-admin:focus {
            border-color: #B88E68;
            box-shadow: 0 0 0 4px rgba(184, 142, 104, 0.15);
            outline: none;
        }

        .gallery-slot-card {
            border: 1.5px dashed #cbd5e1;
            border-radius: 12px;
            padding: 12px;
            background: #f8fafc;
            text-align: center;
            transition: all 0.25s ease;
        }

        .gallery-slot-card:hover {
            border-color: #B88E68;
            background: #fffdfa;
        }

        .gallery-slot-preview {
            width: 100%;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 8px;
            border: 1px solid #e2e8f0;
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
            font-size: 1.05rem;
            color: #442305;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .addon-package-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 16px;
            transition: all 0.25s ease;
        }

        .addon-package-card:hover {
            border-color: #B88E68;
            box-shadow: 0 4px 15px rgba(184, 142, 104, 0.15);
        }

        .btn-publish-gold {
            background: linear-gradient(135deg, #442305 0%, #9A724E 100%);
            color: #ffffff;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            box-shadow: 0 6px 20px rgba(68, 35, 5, 0.25);
            transition: all 0.3s ease;
        }

        .btn-publish-gold:hover {
            background: linear-gradient(135deg, #2c1602 0%, #7d5a3b 100%);
            color: #ffffff;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(68, 35, 5, 0.35);
        }

        /* Sticky Preview Card */
        .preview-sticky {
            position: sticky;
            top: 90px;
        }

        .room-details-preview-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
        }

        .rd-prev-hero {
            height: 140px;
            background: linear-gradient(rgba(15,23,42,0.6), rgba(15,23,42,0.8)), url('../images/room-mini-business.jpg') center/cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #ffffff;
            text-align: center;
            padding: 12px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <div class="container-fluid px-0">

        <!-- ==========================================
             1. BREADCRUMB & PAGE HEADER
             ========================================== -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1 text-muted small">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door me-1"></i>Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="AddRoom.aspx" class="text-decoration-none text-muted">Rooms</a></li>
                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">Room Details Setup</li>
                    </ol>
                </nav>
                <h2 class="h3 font-serif fw-bold text-dark mb-0">Configure Room Details Page</h2>
                <p class="text-muted small mb-0">Manage gallery photos, overview text, categorized amenities, policies, and add-on packages for RoomDetails.aspx.</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a href="AddRoom.aspx" class="btn btn-outline-dark btn-sm px-3 rounded-pill fw-semibold">
                    <i class="bi bi-plus-circle me-1"></i> Add Room Form
                </a>
            </div>
        </div>

        <!-- Success Alert Panel -->
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm border-0 rounded-4 mb-4" role="alert">
            <div class="d-flex align-items-center gap-3">
                <div class="bg-success text-white rounded-circle p-2 d-inline-flex">
                    <i class="bi bi-check-lg fs-4"></i>
                </div>
                <div>
                    <h5 class="alert-heading fw-bold mb-1">Room Details Configured Successfully!</h5>
                    <p class="mb-0 small">All gallery photos, overview copy, categorized amenities, policies, and add-on packages have been saved for the RoomDetails page.</p>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <div class="row g-4">

            <!-- ==========================================
                 ROOM DETAILS FORM CONFIGURATION (FULL WIDTH)
                 ========================================== -->
            <div class="col-12">

                <!-- SECTION 1: HERO & HEADER CONTENT -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-window-sidebar"></i> 1. Banner &amp; Hero Header Details
                        </h3>
                        <span class="badge bg-light text-secondary border">Page Header</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtBadgeText">Top Banner Badge</label>
                                <input type="text" id="txtBadgeText" class="form-control form-control-admin" placeholder="e.g. ROYAL ACCOMMODATION" value="ROYAL ACCOMMODATION" oninput="updateDetailsPreview()">
                            </div>
                            <div class="col-md-8">
                                <label class="form-label-custom" for="txtHeaderTitle">Page Hero Title</label>
                                <input type="text" id="txtHeaderTitle" class="form-control form-control-admin" placeholder="e.g. Executive Business Suite" value="Executive Business Suite" oninput="updateDetailsPreview()">
                            </div>
                            <div class="col-12">
                                <label class="form-label-custom" for="txtHeaderSubtitle">Page Subtitle Tagline</label>
                                <input type="text" id="txtHeaderSubtitle" class="form-control form-control-admin" placeholder="e.g. Experience royal luxury, panoramic views, and world-class butler service..." value="Experience royal luxury, panoramic views, and world-class butler service tailored for your stay." oninput="updateDetailsPreview()">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom" for="txtMainHeaderImage">Featured Room Header Image URL</label>
                                <input type="text" id="txtMainHeaderImage" class="form-control form-control-admin" placeholder="images/room-mini-business.jpg" value="images/room-mini-business.jpg" oninput="updateDetailsPreview()">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom" for="txtCategoryTag">Header Category Badge</label>
                                <input type="text" id="txtCategoryTag" class="form-control form-control-admin" placeholder="e.g. Premium Suite" value="Premium Suite" oninput="updateDetailsPreview()">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SECTION 2: ROOM PHOTO GALLERY GRID (4 SLOTS) -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-images"></i> 2. Room Photo Gallery (4 Slots)
                        </h3>
                        <span class="badge bg-light text-secondary border">Gallery Grid</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-md-6 col-6">
                                <div class="gallery-slot-card">
                                    <img src="../images/room-mini-business.jpg" id="galPrev1" class="gallery-slot-preview" alt="Slot 1">
                                    <label class="form-label-custom d-block mb-1">Gallery Slot 1</label>
                                    <input type="text" id="txtGal1" class="form-control form-control-admin text-center py-1 small" value="../images/room-mini-business.jpg" oninput="document.getElementById('galPrev1').src=this.value">
                                </div>
                            </div>
                            <div class="col-md-6 col-6">
                                <div class="gallery-slot-card">
                                    <img src="../images/room-deluxe.jpg" id="galPrev2" class="gallery-slot-preview" alt="Slot 2">
                                    <label class="form-label-custom d-block mb-1">Gallery Slot 2</label>
                                    <input type="text" id="txtGal2" class="form-control form-control-admin text-center py-1 small" value="../images/room-deluxe.jpg" oninput="document.getElementById('galPrev2').src=this.value">
                                </div>
                            </div>
                            <div class="col-md-6 col-6">
                                <div class="gallery-slot-card">
                                    <img src="../images/room-royal-king.jpg" id="galPrev3" class="gallery-slot-preview" alt="Slot 3">
                                    <label class="form-label-custom d-block mb-1">Gallery Slot 3</label>
                                    <input type="text" id="txtGal3" class="form-control form-control-admin text-center py-1 small" value="../images/room-royal-king.jpg" oninput="document.getElementById('galPrev3').src=this.value">
                                </div>
                            </div>
                            <div class="col-md-6 col-6">
                                <div class="gallery-slot-card">
                                    <img src="../images/room-family-suite.jpg" id="galPrev4" class="gallery-slot-preview" alt="Slot 4">
                                    <label class="form-label-custom d-block mb-1">Gallery Slot 4</label>
                                    <input type="text" id="txtGal4" class="form-control form-control-admin text-center py-1 small" value="../images/room-family-suite.jpg" oninput="document.getElementById('galPrev4').src=this.value">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SECTION 3: ROOM OVERVIEW & GUEST TESTIMONIAL QUOTE -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-file-text-fill"></i> 3. Room Overview &amp; Premium Guest Quote
                        </h3>
                        <span class="badge bg-light text-secondary border">Overview &amp; Reviews</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label-custom" for="txtOverviewPara1">Overview Paragraph 1</label>
                                <textarea id="txtOverviewPara1" class="form-control form-control-admin" rows="3" placeholder="Indulge in the ultimate luxury experience with our handcrafted suite...">Indulge in the ultimate luxury experience with our handcrafted suite. This spacious retreat features floor-to-ceiling soundproof windows showcasing panoramic skyline vistas, creating a serene atmosphere perfect for business leaders and leisure travelers.</textarea>
                            </div>
                            <div class="col-12">
                                <label class="form-label-custom" for="txtOverviewPara2">Overview Paragraph 2</label>
                                <textarea id="txtOverviewPara2" class="form-control form-control-admin" rows="3" placeholder="The suite includes an executive work station...">The suite includes an executive work station with high-speed Wi-Fi, a private sun balcony where you can enjoy morning espresso, and an Italian marble bathroom with rainfall shower. The bedroom features a plush emperor-size bed with 400-thread-count Egyptian cotton linens.</textarea>
                            </div>

                            <!-- Guest Quote -->
                            <div class="col-md-8">
                                <label class="form-label-custom" for="txtQuoteText">Premium Guest Testimonial Quote</label>
                                <input type="text" id="txtQuoteText" class="form-control form-control-admin" value="The most luxurious stay we have ever experienced. The skyline view is absolutely breathtaking and the attention to detail is remarkable." oninput="updateDetailsPreview()">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtQuoteAuthor">Guest Name / Author</label>
                                <input type="text" id="txtQuoteAuthor" class="form-control form-control-admin" value="Vikramaditya S., Verified Guest">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- SECTION 4: CATEGORIZED ROOM AMENITIES (4 CATEGORIES) -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-grid-3x3-gap-fill"></i> 4. Categorized Room Amenities
                        </h3>
                        <span class="badge bg-light text-secondary border">4 Feature Boxes</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <!-- Category 1: Sleeping -->
                            <div class="col-md-6">
                                <div class="amenity-category-box">
                                    <div class="amenity-category-title"><i class="bi bi-moon-stars text-gold"></i> 1. Sleeping</div>
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="King emperor bed">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Egyptian cotton linens">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Memory foam pillows">
                                    <input type="text" class="form-control form-control-admin small" value="Soundproof blackout drapes">
                                </div>
                            </div>

                            <!-- Category 2: Technology -->
                            <div class="col-md-6">
                                <div class="amenity-category-box">
                                    <div class="amenity-category-title"><i class="bi bi-wifi text-gold"></i> 2. Technology</div>
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="High-speed Wi-Fi">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="55&quot; 4K Smart OLED TV">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Bluetooth soundbar">
                                    <input type="text" class="form-control form-control-admin small" value="USB-C charging hub">
                                </div>
                            </div>

                            <!-- Category 3: Comfort -->
                            <div class="col-md-6">
                                <div class="amenity-category-box">
                                    <div class="amenity-category-title"><i class="bi bi-cup-hot text-gold"></i> 3. Comfort</div>
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Touch climate control">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Personal mini-bar">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Coffee machine">
                                    <input type="text" class="form-control form-control-admin small" value="Electronic safe box">
                                </div>
                            </div>

                            <!-- Category 4: Bathroom -->
                            <div class="col-md-6">
                                <div class="amenity-category-box">
                                    <div class="amenity-category-title"><i class="fa-solid fa-bath text-gold"></i> 4. Bathroom</div>
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Italian marble bath">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Rain glass shower">
                                    <input type="text" class="form-control form-control-admin mb-2 small" value="Luxury toiletries">
                                    <input type="text" class="form-control form-control-admin small" value="Plush bathrobes & slippers">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <!-- SAVE & PUBLISH ACTION BUTTONS -->
                <div class="admin-form-card">
                    <div class="admin-card-body d-flex flex-wrap align-items-center justify-content-between gap-3">
                        <button type="button" class="btn btn-light border px-4 py-2 rounded-3 fw-semibold text-secondary" onclick="window.location.reload();">
                            <i class="bi bi-arrow-counterclockwise me-1"></i> Reset Changes
                        </button>

                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn btn-outline-dark px-4 py-2.5 rounded-3 fw-semibold" onclick="if(window.showAdminToast) window.showAdminToast('Draft Saved', 'Room details saved as draft.', 'bi-file-earmark-check text-success');">
                                <i class="bi bi-file-earmark-text me-1"></i> Save Draft
                            </button>

                            <asp:Button ID="btnSaveDetails" runat="server" Text="Save & Publish Room Details" CssClass="btn btn-publish-gold rounded-3" OnClick="btnSaveDetails_Click" />
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</asp:Content>
