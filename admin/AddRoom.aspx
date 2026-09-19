<%@ Page Title="Add New Room & Suite | Admin Panel" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddRoom.aspx.cs" Inherits="Admin_AddRoom" %>

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

        .amenity-checkbox-pill {
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

        .amenity-checkbox-pill:hover {
            border-color: #B88E68;
            background: #fffdfa;
        }

        .amenity-checkbox-pill input[type="checkbox"]:checked + span {
            color: #442305;
        }

        .amenity-checkbox-pill:has(input[type="checkbox"]:checked) {
            background: #fef7f0;
            border-color: #B88E68;
            color: #442305;
            box-shadow: 0 2px 8px rgba(184, 142, 104, 0.2);
        }

        .preset-img-thumb {
            width: 72px;
            height: 52px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #e2e8f0;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .preset-img-thumb:hover, .preset-img-thumb.active {
            border-color: #B88E68;
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(184, 142, 104, 0.3);
        }

        /* Live Preview Sticky Card Style (Matching Room.aspx) */
        .live-preview-sticky {
            position: sticky;
            top: 90px;
        }

        .preview-badge-header {
            background: linear-gradient(135deg, #442305 0%, #9A724E 100%);
            color: #ffffff;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 6px 14px;
            border-radius: 30px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 12px;
        }

        /* Exact Room Card Styling from Room.aspx */
        .preview-room-card {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
            border: 1px solid #f1f5f9;
            transition: all 0.35s ease;
        }

        .preview-card-img-wrapper {
            position: relative;
            height: 220px;
            overflow: hidden;
        }

        .preview-card-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .preview-category-badge {
            position: absolute;
            top: 14px;
            left: 14px;
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(4px);
            color: #ffffff;
            font-size: 0.68rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 4px 12px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .preview-price-tag {
            position: absolute;
            bottom: 14px;
            right: 14px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(4px);
            padding: 6px 14px;
            border-radius: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        .preview-price-tag .amount {
            font-family: 'Playfair Display', Georgia, serif;
            font-weight: 700;
            color: #442305;
            font-size: 1.1rem;
        }

        .preview-card-body {
            padding: 20px;
        }

        .preview-room-title {
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 1.25rem;
            font-weight: 700;
            color: #442305;
            margin-bottom: 8px;
        }

        .preview-room-desc {
            font-size: 0.85rem;
            color: #64748b;
            line-height: 1.5;
            margin-bottom: 16px;
            max-height: 2.55em;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .preview-spec-pill {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.76rem;
            color: #475569;
            background: #f8fafc;
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            font-weight: 600;
        }

        .preview-amenity-tag {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            font-size: 0.72rem;
            color: #9A724E;
            background: #fdfaf7;
            padding: 3px 8px;
            border-radius: 4px;
            border: 1px solid rgba(184, 142, 104, 0.25);
            font-weight: 600;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <div class="container-fluid px-0">

        <!-- ==========================================
             1. BREADCRUMB & PAGE TITLE HEADER
             ========================================== -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-1 text-muted small">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door me-1"></i>Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="javascript:void(0)" class="text-decoration-none text-muted">Rooms</a></li>
                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">Add New Room &amp; Suite</li>
                    </ol>
                </nav>
                <h2 class="h3 font-serif fw-bold text-dark mb-0">Add New Luxury Room &amp; Suite</h2>
                <p class="text-muted small mb-0">Configure room details, rate plans, amenities, and media for the Rooms &amp; Suites page.</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a href="Dashboard.aspx" class="btn btn-outline-secondary btn-sm px-3 rounded-pill fw-semibold">
                    <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <!-- Submission Success Alert Banner -->
        <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show shadow-sm border-0 rounded-4 mb-4" role="alert">
            <div class="d-flex align-items-center gap-3">
                <div class="bg-success text-white rounded-circle p-2 d-inline-flex">
                    <i class="bi bi-check-lg fs-4"></i>
                </div>
                <div>
                    <h5 class="alert-heading fw-bold mb-1">Room Published Successfully!</h5>
                    <p class="mb-0 small">The new room details have been formatted and prepared for the Rooms &amp; Suites directory.</p>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <div class="row g-4">

            <!-- ==========================================
                 LEFT COLUMN: ADD ROOM FORM (8 COLS)
                 ========================================== -->
            <div class="col-lg-8">

                <!-- CARD 1: BASIC ROOM INFORMATION -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-info-circle-fill"></i> 1. Basic Room Information
                        </h3>
                        <span class="badge bg-light text-secondary border">Core Details</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-md-8">
                                <label class="form-label-custom" for="txtRoomName">Room / Suite Title <span class="text-danger">*</span></label>
                                <input type="text" id="txtRoomName" class="form-control form-control-admin" placeholder="e.g. Executive Business Suite" value="Executive Business Suite" oninput="updateLivePreview()">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="ddlCategory">Room Category <span class="text-danger">*</span></label>
                                <select id="ddlCategory" class="form-select form-select-admin" onchange="updateLivePreview()">
                                    <option value="executive" selected>Executive Suite</option>
                                    <option value="deluxe">Deluxe Room</option>
                                    <option value="family">Family Suite</option>
                                    <option value="royal">Royal King Suite</option>
                                    <option value="penthouse">Presidential Penthouse</option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtBadge">Category Badge Label</label>
                                <input type="text" id="txtBadge" class="form-control form-control-admin" placeholder="e.g. EXECUTIVE" value="EXECUTIVE" oninput="updateLivePreview()">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtPrice">Price Per Night (&#8377;) <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light fw-bold border-end-0">&#8377;</span>
                                    <input type="number" id="txtPrice" class="form-control form-control-admin border-start-0 ps-1" placeholder="8500" value="8500" oninput="updateLivePreview()">
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtMemberPrice">Member Special Rate (&#8377;)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light fw-bold border-end-0">&#8377;</span>
                                    <input type="number" id="txtMemberPrice" class="form-control form-control-admin border-start-0 ps-1" placeholder="7800" value="7800">
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label-custom" for="txtRating">Rating Score (Out of 5.0)</label>
                                <input type="text" id="txtRating" class="form-control form-control-admin" placeholder="e.g. 4.9" value="4.9" oninput="updateLivePreview()">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label-custom" for="txtReviewCount">Verified Review Count</label>
                                <input type="number" id="txtReviewCount" class="form-control form-control-admin" placeholder="e.g. 128" value="128">
                            </div>

                            <div class="col-12">
                                <label class="form-label-custom" for="txtShortDesc">Short Card Description <span class="text-danger">*</span></label>
                                <textarea id="txtShortDesc" class="form-control form-control-admin" rows="2" placeholder="Brief summary shown on room listing card..." oninput="updateLivePreview()">Crafted for modern business leaders, featuring ergonomic workstation, soundproof windows, high-speed Wi-Fi & luxury king bedding.</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD 2: CAPACITY & SPECIFICATIONS -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-sliders"></i> 2. Capacity &amp; Room Specifications
                        </h3>
                        <span class="badge bg-light text-secondary border">Specifications</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtMaxAdults">Max Adult Guests</label>
                                <input type="number" id="txtMaxAdults" class="form-control form-control-admin" value="2" min="1" max="10" oninput="updateLivePreview()">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtMaxChildren">Max Children</label>
                                <input type="number" id="txtMaxChildren" class="form-control form-control-admin" value="1" min="0" max="6">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtArea">Room Area / Size</label>
                                <input type="text" id="txtArea" class="form-control form-control-admin" placeholder="e.g. 55 m² / 592 sq ft" value="55 m²" oninput="updateLivePreview()">
                            </div>

                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtViewType">View Type</label>
                                <input type="text" id="txtViewType" class="form-control form-control-admin" placeholder="e.g. City View, Garden View" value="City View" oninput="updateLivePreview()">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="txtBedType">Bed Configuration</label>
                                <input type="text" id="txtBedType" class="form-control form-control-admin" placeholder="e.g. King Emperor Bed" value="King Emperor Bed">
                            </div>
                            <div class="col-md-4">
                                <label class="form-label-custom" for="ddlStatus">Initial Status</label>
                                <select id="ddlStatus" class="form-select form-select-admin">
                                    <option value="Available" selected>Available</option>
                                    <option value="Reserved">Reserved / Booked</option>
                                    <option value="Maintenance">Under Maintenance</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD 3: MEDIA & ROOM IMAGES -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-image-fill"></i> 3. Room Media &amp; Images
                        </h3>
                        <span class="badge bg-light text-secondary border">Photo Assets</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="mb-3">
                            <label class="form-label-custom" for="txtMainImage">Primary Room Image URL <span class="text-danger">*</span></label>
                            <input type="text" id="txtMainImage" class="form-control form-control-admin" placeholder="images/room-mini-business.jpg" value="images/room-mini-business.jpg" oninput="updateLivePreview()">
                        </div>

                        <!-- Presets Selector -->
                        <div class="mb-2">
                            <label class="form-label-custom d-block">Quick Choose Hotel Room Photo Preset:</label>
                            <div class="d-flex flex-wrap gap-2">
                                <img src="../images/room-mini-business.jpg" alt="Executive" class="preset-img-thumb active" onclick="selectPresetImage('../images/room-mini-business.jpg', this)">
                                <img src="../images/room-deluxe.jpg" alt="Deluxe" class="preset-img-thumb" onclick="selectPresetImage('../images/room-deluxe.jpg', this)">
                                <img src="../images/room-family-suite.jpg" alt="Family" class="preset-img-thumb" onclick="selectPresetImage('../images/room-family-suite.jpg', this)">
                                <img src="../images/room-classic-double.jpg" alt="Classic" class="preset-img-thumb" onclick="selectPresetImage('../images/room-classic-double.jpg', this)">
                                <img src="../images/room-royal-king.jpg" alt="Royal King" class="preset-img-thumb" onclick="selectPresetImage('../images/room-royal-king.jpg', this)">
                                <img src="../images/room-luxury-penthouse.jpg" alt="Penthouse" class="preset-img-thumb" onclick="selectPresetImage('../images/room-luxury-penthouse.jpg', this)">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD 4: KEY AMENITIES & FEATURES -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-check2-square"></i> 4. Key Room Amenities &amp; Tags
                        </h3>
                        <span class="badge bg-light text-secondary border">Badges &amp; Tags</span>
                    </div>
                    <div class="admin-card-body">
                        <label class="form-label-custom d-block mb-3">Select Key Amenities for Room Card Tags:</label>
                        <div class="d-flex flex-wrap gap-2" id="amenitiesContainer">
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="High-Speed Wi-Fi" checked onchange="updateLivePreview()">
                                <i class="bi bi-wifi text-gold"></i>
                                <span>High-Speed Wi-Fi</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Ergonomic Workstation" checked onchange="updateLivePreview()">
                                <i class="bi bi-laptop text-gold"></i>
                                <span>Work Desk</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Coffee Maker" checked onchange="updateLivePreview()">
                                <i class="bi bi-cup-hot text-gold"></i>
                                <span>Coffee Maker</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Private Terrace" onchange="updateLivePreview()">
                                <i class="bi bi-tree text-gold"></i>
                                <span>Private Terrace</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Air Conditioning" onchange="updateLivePreview()">
                                <i class="bi bi-snow text-gold"></i>
                                <span>Air Conditioning</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="50 Smart TV" onchange="updateLivePreview()">
                                <i class="bi bi-tv text-gold"></i>
                                <span>50" Smart TV</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Private Mini Bar" onchange="updateLivePreview()">
                                <i class="bi bi-cup-straw text-gold"></i>
                                <span>Mini Bar</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Heated Jacuzzi" onchange="updateLivePreview()">
                                <i class="fa-solid fa-hot-tub-person text-gold"></i>
                                <span>Jacuzzi</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="24/7 Butler Service" onchange="updateLivePreview()">
                                <i class="fa-solid fa-bell-concierge text-gold"></i>
                                <span>Butler Service</span>
                            </label>
                            <label class="amenity-checkbox-pill">
                                <input type="checkbox" class="d-none" value="Rainfall Shower" onchange="updateLivePreview()">
                                <i class="fa-solid fa-bath text-gold"></i>
                                <span>Rainfall Shower</span>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- CARD 5: ROOM HIGHLIGHTS & DETAILED INFO -->
                <div class="admin-form-card">
                    <div class="admin-card-header">
                        <h3 class="admin-card-title">
                            <i class="bi bi-stars"></i> 5. Room Highlights &amp; Full Description
                        </h3>
                        <span class="badge bg-light text-secondary border">Room Details Page</span>
                    </div>
                    <div class="admin-card-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label-custom" for="txtHighlight1">Highlight 1 (Primary Feature)</label>
                                <input type="text" id="txtHighlight1" class="form-control form-control-admin" placeholder="e.g. Complimentary high-speed Wi-Fi & valet parking" value="Complimentary high-speed Wi-Fi & valet parking">
                            </div>
                            <div class="col-12">
                                <label class="form-label-custom" for="txtHighlight2">Highlight 2 (Bath & Spa)</label>
                                <input type="text" id="txtHighlight2" class="form-control form-control-admin" placeholder="e.g. Marble bath with Italian rainfall shower" value="Marble bath with Italian rainfall shower">
                            </div>
                            <div class="col-12">
                                <label class="form-label-custom" for="txtHighlight3">Highlight 3 (Recreation)</label>
                                <input type="text" id="txtHighlight3" class="form-control form-control-admin" placeholder="e.g. Access to heated pool & luxury fitness centre" value="Access to heated pool & luxury fitness centre">
                            </div>
                            <div class="col-12">
                                <label class="form-label-custom" for="txtHighlight4">Highlight 4 (Service)</label>
                                <input type="text" id="txtHighlight4" class="form-control form-control-admin" placeholder="e.g. 24/7 room service & concierge" value="24/7 room service & concierge">
                            </div>

                            <div class="col-12 mt-3">
                                <label class="form-label-custom" for="txtFullDesc">Full Detailed Description for Room Details Page</label>
                                <textarea id="txtFullDesc" class="form-control form-control-admin" rows="4" placeholder="Detailed description of room layout, bed linens, bathroom features, and luxury perks...">Experience royal luxury, panoramic city views, and world-class butler service tailored for your stay. Designed with Italian marble floors, soundproof glass windows, and custom-crafted champagne gold furnishings.</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- CARD 6: SAVE & PUBLISH ACTION BUTTONS -->
                <div class="admin-form-card">
                    <div class="admin-card-body d-flex flex-wrap align-items-center justify-content-between gap-3">
                        <button type="button" class="btn btn-light border px-4 py-2 rounded-3 fw-semibold text-secondary" onclick="resetForm()">
                            <i class="bi bi-arrow-counterclockwise me-1"></i> Reset Form
                        </button>

                        <div class="d-flex align-items-center gap-2">
                            <button type="button" class="btn btn-outline-dark px-4 py-2.5 rounded-3 fw-semibold" onclick="showDraftToast()">
                                <i class="bi bi-file-earmark-text me-1"></i> Save Draft
                            </button>

                            <asp:Button ID="btnSaveRoom" runat="server" Text="Publish New Room & Suite" CssClass="btn btn-publish-gold rounded-3" OnClick="btnSaveRoom_Click" />
                        </div>
                    </div>
                </div>

            </div>

            <!-- ==========================================
                 RIGHT COLUMN: LIVE CARD PREVIEW (4 COLS)
                 ========================================== -->
            <div class="col-lg-4">
                <div class="live-preview-sticky">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <span class="preview-badge-header">
                            <i class="bi bi-eye-fill"></i> Live Room Card Preview
                        </span>
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                            <i class="bi bi-circle-fill me-1" style="font-size: 0.55rem;"></i> Interactive
                        </span>
                    </div>

                    <!-- ROOM CARD PREVIEW (Matches Room.aspx) -->
                    <div class="preview-room-card">
                        <div class="preview-card-img-wrapper">
                            <img id="prevImg" src="../images/room-mini-business.jpg" alt="Room Preview" onerror="this.src='../images/room-deluxe.jpg';">
                            <span class="preview-category-badge" id="prevBadge">EXECUTIVE</span>
                            <div class="preview-price-tag">
                                <span class="amount" id="prevPrice">&#8377;8,500</span>
                                <small class="text-muted" style="font-size: 0.68rem;">/ night</small>
                            </div>
                        </div>

                        <div class="preview-card-body">
                            <!-- Rating -->
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <div class="text-warning small" style="font-size: 0.8rem;">
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <span class="text-dark fw-bold ms-1" id="prevRating">(4.9)</span>
                                </div>
                                <span class="badge bg-success-subtle text-success small fw-semibold" style="font-size: 0.65rem;">
                                    <i class="bi bi-shield-check me-1"></i> Verified
                                </span>
                            </div>

                            <!-- Room Title -->
                            <h3 class="preview-room-title" id="prevTitle">Executive Business Suite</h3>

                            <!-- Description -->
                            <p class="preview-room-desc" id="prevDesc">
                                Crafted for modern business leaders, featuring ergonomic workstation, soundproof windows, high-speed Wi-Fi &amp; luxury king bedding.
                            </p>

                            <!-- Specs -->
                            <div class="d-flex flex-wrap gap-1 mb-3" id="prevSpecs">
                                <span class="preview-spec-pill"><i class="bi bi-people-fill text-gold"></i> <span id="prevGuests">2 Guests</span></span>
                                <span class="preview-spec-pill"><i class="bi bi-aspect-ratio-fill text-gold"></i> <span id="prevArea">55 m²</span></span>
                                <span class="preview-spec-pill"><i class="bi bi-building text-gold"></i> <span id="prevView">City View</span></span>
                            </div>

                            <!-- Amenities -->
                            <div class="d-flex flex-wrap gap-1 mb-3" id="prevAmenities">
                                <span class="preview-amenity-tag"><i class="bi bi-wifi"></i> High-Speed Wi-Fi</span>
                                <span class="preview-amenity-tag"><i class="bi bi-laptop"></i> Work Desk</span>
                                <span class="preview-amenity-tag"><i class="bi bi-cup-hot"></i> Coffee Maker</span>
                            </div>

                            <!-- View Details Button -->
                            <div class="d-grid mt-2">
                                <button type="button" class="btn btn-outline-dark btn-sm rounded-pill fw-bold py-2">
                                    <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Help Box -->
                    <div class="card border-0 bg-light p-3 rounded-4 mt-3">
                        <div class="d-flex align-items-center gap-2 text-dark fw-bold small mb-1">
                            <i class="bi bi-lightbulb-fill text-warning fs-5"></i>
                            <span>Admin Tip</span>
                        </div>
                        <p class="text-muted small mb-0" style="font-size: 0.78rem;">
                            The live card updates dynamically as you type. Make sure to specify high quality images and accurate pricing to ensure optimal display on the guest portal.
                        </p>
                    </div>

                </div>
            </div>

        </div>

    </div>

    <!-- Live Preview Script -->
    <script>
        function updateLivePreview() {
            var name = document.getElementById('txtRoomName').value || 'Executive Business Suite';
            var badge = document.getElementById('txtBadge').value || 'EXECUTIVE';
            var price = document.getElementById('txtPrice').value || '8500';
            var rating = document.getElementById('txtRating').value || '4.9';
            var desc = document.getElementById('txtShortDesc').value || 'Crafted for luxury accommodations...';
            var guests = document.getElementById('txtMaxAdults').value || '2';
            var area = document.getElementById('txtArea').value || '55 m²';
            var view = document.getElementById('txtViewType').value || 'City View';
            var img = document.getElementById('txtMainImage').value || '../images/room-mini-business.jpg';

            document.getElementById('prevTitle').textContent = name;
            document.getElementById('prevBadge').textContent = badge.toUpperCase();
            document.getElementById('prevPrice').innerHTML = '&#8377;' + parseInt(price).toLocaleString('en-IN');
            document.getElementById('prevRating').textContent = '(' + rating + ')';
            document.getElementById('prevDesc').textContent = desc;
            document.getElementById('prevGuests').textContent = guests + ' Guests';
            document.getElementById('prevArea').textContent = area;
            document.getElementById('prevView').textContent = view;

            if (img) {
                document.getElementById('prevImg').src = img;
            }

            // Update Amenities Tags in Preview
            var amenityContainer = document.getElementById('prevAmenities');
            if (amenityContainer) {
                amenityContainer.innerHTML = '';
                var checkedInputs = document.querySelectorAll('#amenitiesContainer input[type="checkbox"]:checked');
                checkedInputs.forEach(function (cb) {
                    var labelText = cb.value;
                    var tag = document.createElement('span');
                    tag.className = 'preview-amenity-tag';
                    tag.innerHTML = '<i class="bi bi-check2"></i> ' + labelText;
                    amenityContainer.appendChild(tag);
                });
            }
        }

        function selectPresetImage(src, elem) {
            document.getElementById('txtMainImage').value = src;
            document.querySelectorAll('.preset-img-thumb').forEach(function (el) { el.classList.remove('active'); });
            if (elem) elem.classList.add('active');
            updateLivePreview();
        }

        function showDraftToast() {
            if (window.showAdminToast) {
                window.showAdminToast('Draft Saved', 'Room configuration draft stored successfully.', 'bi-file-earmark-check text-success');
            }
        }

        function resetForm() {
            document.getElementById('txtRoomName').value = 'Executive Business Suite';
            document.getElementById('txtBadge').value = 'EXECUTIVE';
            document.getElementById('txtPrice').value = '8500';
            document.getElementById('txtRating').value = '4.9';
            document.getElementById('txtShortDesc').value = 'Crafted for modern business leaders, featuring ergonomic workstation, soundproof windows, high-speed Wi-Fi & luxury king bedding.';
            updateLivePreview();
        }

        document.addEventListener('DOMContentLoaded', function () {
            updateLivePreview();
        });
    </script>
</asp:Content>
