<%@ Page Title="Rooms & Rates | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Room.aspx.cs" Inherits="Room" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
            /* ====================================================
               ROYAL ROOMS & RATES LUXURY DESIGN SYSTEM
               ==================================================== */
            :root {
                --royal-gold: #B88E68;
                --royal-gold-hover: #9A724E;
                --royal-dark: #442305;
                --royal-dark-surface: #2D1603;
                --royal-bg: #FAF7F2;
                --royal-border: #E8DFD5;
                --royal-accent-light: #FFFBF7;
            }

            body {
                background-color: var(--royal-bg);
            }

            /* 1. Compact Luxury Top Banner */
            .room-rates-hero {
                background: linear-gradient(135deg, rgba(68, 35, 5, 0.92) 0%, rgba(35, 18, 3, 0.95) 100%),
                    url('images/room-hero-banner.jpg') center/cover no-repeat;
                padding: 40px 0 30px 0;
                color: #ffffff;
                border-bottom: 3px solid var(--royal-gold);
            }

            .hero-badge-pill {
                background: rgba(184, 142, 104, 0.2);
                border: 1px solid rgba(184, 142, 104, 0.5);
                color: #F4E2D8;
                font-size: 0.78rem;
                letter-spacing: 1.5px;
                text-transform: uppercase;
                border-radius: 30px;
                padding: 5px 16px;
            }

            /* 2. Top Dark Gold Strip */
            .rates-header-strip {
                background: var(--royal-dark);
                color: #ffffff;
                padding: 12px 24px;
                border-radius: 8px 8px 0 0;
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.15rem;
                font-weight: 700;
                letter-spacing: 0.5px;
            }

            /* 3. 5-Column Search Filter Bar */
            .rates-search-container {
                background: #ffffff;
                border: 1px solid var(--royal-border);
                border-top: none;
                border-radius: 0 0 8px 8px;
                padding: 20px 24px;
                box-shadow: 0 10px 30px rgba(68, 35, 5, 0.06);
            }

            .rate-input-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.8px;
                color: var(--royal-dark);
                margin-bottom: 6px;
                display: block;
            }

            .rate-control {
                border: 1.5px solid #E0D6CB;
                border-radius: 6px;
                padding: 9px 12px;
                font-size: 0.88rem;
                color: #2D3748;
                background-color: #FAFAFA;
                transition: all 0.25s ease;
            }

            .rate-control:focus {
                border-color: var(--royal-gold);
                background-color: #ffffff;
                box-shadow: 0 0 0 3px rgba(184, 142, 104, 0.15);
                outline: none;
            }

            .guarantee-bar {
                background: #FFFDF9;
                border: 1px solid #F0E6DA;
                border-radius: 6px;
                padding: 10px 18px;
                font-size: 0.82rem;
                color: #5A4A3A;
            }

            /* 4. Filter Tabs & Category Pills */
            .rate-type-tab {
                border: none;
                background: transparent;
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 0.95rem;
                font-weight: 700;
                letter-spacing: 1px;
                color: #718096;
                padding: 10px 18px;
                border-bottom: 3px solid transparent;
                transition: all 0.25s ease;
            }

            .rate-type-tab.active {
                color: var(--royal-dark);
                border-bottom-color: var(--royal-gold);
            }

            .category-pill-btn {
                background: #ffffff;
                border: 1.5px solid #E2D8CD;
                color: #4A5568;
                font-size: 0.82rem;
                font-weight: 600;
                padding: 7px 18px;
                border-radius: 4px;
                transition: all 0.25s ease;
            }

            .category-pill-btn:hover,
            .category-pill-btn.active {
                background: var(--royal-dark);
                color: #ffffff;
                border-color: var(--royal-dark);
                box-shadow: 0 4px 12px rgba(68, 35, 5, 0.15);
            }

            /* 5. Luxury Room Rate Listing Cards */
            .room-rate-card {
                background: #ffffff;
                border: 1px solid var(--royal-border);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 6px 20px rgba(68, 35, 5, 0.04);
                margin-bottom: 28px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .room-rate-card:hover {
                box-shadow: 0 12px 36px rgba(68, 35, 5, 0.08);
            }

            .room-card-header-title {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.35rem;
                font-weight: 700;
                color: var(--royal-dark);
                letter-spacing: 0.5px;
                padding: 18px 24px 14px 24px;
                border-bottom: 1px solid #F3ECE4;
                background: linear-gradient(to right, #FFFDFB, #ffffff);
            }

            .room-gallery-thumb-wrapper {
                position: relative;
                border-radius: 8px;
                overflow: hidden;
            }

            .room-gallery-thumb-wrapper img {
                width: 100%;
                height: 190px;
                object-fit: cover;
                transition: transform 0.4s ease;
            }

            .room-rate-card:hover .room-gallery-thumb-wrapper img {
                transform: scale(1.04);
            }

            .photo-count-badge {
                position: absolute;
                bottom: 10px;
                left: 10px;
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(4px);
                color: #ffffff;
                font-size: 0.75rem;
                padding: 3px 10px;
                border-radius: 4px;
            }

            .room-meta-info {
                font-size: 0.8rem;
                color: #64748B;
            }

            .room-meta-info span {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                margin-right: 14px;
            }

            .details-link {
                color: var(--royal-gold);
                font-size: 0.78rem;
                font-weight: 700;
                text-decoration: none;
                text-transform: uppercase;
                letter-spacing: 0.8px;
            }

            .details-link:hover {
                color: var(--royal-gold-hover);
                text-decoration: underline;
            }

            /* Rate Options Rows */
            .rate-option-box {
                border-top: 1px dashed #EAE2D8;
                padding: 16px 24px;
                transition: background-color 0.25s ease;
            }

            .rate-option-box:hover {
                background-color: var(--royal-accent-light);
            }

            .rate-option-box.selected-option {
                background-color: #FFF9F2;
                border-left: 4px solid var(--royal-gold);
            }

            .option-title {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.02rem;
                font-weight: 700;
                color: #2D1603;
                font-style: italic;
            }

            .option-benefit-list {
                list-style: none;
                padding-left: 0;
                margin-bottom: 0;
            }

            .option-benefit-list li {
                font-size: 0.83rem;
                color: #4A5568;
                margin-bottom: 4px;
                position: relative;
                padding-left: 16px;
            }

            .option-benefit-list li::before {
                content: "•";
                position: absolute;
                left: 4px;
                color: var(--royal-gold);
                font-weight: bold;
            }

            .price-rate-type {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.8px;
                color: #718096;
            }

            .member-price-text {
                font-size: 1.15rem;
                font-weight: 700;
                color: var(--royal-dark);
            }

            .standard-price-text {
                font-size: 0.92rem;
                color: #718096;
            }

            .btn-select-rate {
                background-color: transparent;
                border: 1.5px solid var(--royal-dark);
                color: var(--royal-dark);
                font-size: 0.78rem;
                font-weight: 800;
                letter-spacing: 1.2px;
                text-transform: uppercase;
                padding: 7px 22px;
                border-radius: 4px;
                transition: all 0.25s ease;
            }

            .btn-select-rate:hover,
            .rate-option-box.selected-option .btn-select-rate {
                background-color: var(--royal-dark);
                color: #ffffff;
                box-shadow: 0 4px 12px rgba(68, 35, 5, 0.2);
            }

            /* 6. Sticky "YOUR STAY" Reservation Summary Sidebar Card */
            .sticky-stay-card {
                position: sticky;
                top: 90px;
                background: #ffffff;
                border: 1px solid var(--royal-border);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(68, 35, 5, 0.08);
            }

            .stay-card-header {
                background: var(--royal-dark);
                color: #ffffff;
                padding: 16px 20px;
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.1rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-transform: uppercase;
            }

            .stay-card-body {
                padding: 20px;
            }

            .stay-price-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.88rem;
                margin-bottom: 10px;
            }

            .stay-total-row {
                border-top: 1.5px solid #EFE8DF;
                padding-top: 12px;
                margin-top: 12px;
                font-size: 1.05rem;
                font-weight: 700;
                color: var(--royal-dark);
            }

            .btn-proceed-booking {
                background: linear-gradient(135deg, var(--royal-gold) 0%, var(--royal-gold-hover) 100%);
                color: #ffffff;
                font-weight: 700;
                font-size: 0.88rem;
                letter-spacing: 1px;
                text-transform: uppercase;
                padding: 13px;
                border-radius: 6px;
                border: none;
                width: 100%;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(184, 142, 104, 0.3);
            }

            .btn-proceed-booking:hover:not(:disabled) {
                background: linear-gradient(135deg, #A07853 0%, #7A5738 100%);
                color: #ffffff;
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(184, 142, 104, 0.4);
            }

            .btn-proceed-booking:disabled {
                background: #CBD5E0;
                cursor: not-allowed;
                box-shadow: none;
            }

            .trust-badge-footer {
                font-size: 0.74rem;
                color: #718096;
                text-align: center;
                border-top: 1px solid #F0E6DA;
                padding-top: 14px;
                margin-top: 16px;
            }

            /* Limited Available Tag */
            .limited-badge {
                color: #C53030;
                font-size: 0.75rem;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <!-- ==========================================
             1. COMPACT HERO SECTION
             ========================================== -->
        <section class="room-rates-hero text-center mb-4">
            <div class="container" data-aos="fade-down">
                <span class="hero-badge-pill mb-2 d-inline-block">
                    <i class="bi bi-stars text-warning me-1"></i> 5-Star Royal Accommodations
                </span>
                <h1 class="display-5 font-serif fw-bold text-white mb-1"
                    style="font-family: 'Playfair Display', Georgia, serif;">
                    Rooms &amp; Suites Rates
                </h1>
                <p class="text-champagne-gold mb-0 fs-6" style="color: #F4E2D8;">
                    Handcrafted Sanctuaries Of Serenity, Elegance &amp; Royalty
                </p>
            </div>
        </section>

        <div class="container-fluid px-3 px-lg-5 mb-5">

            <!-- ==========================================
                 2. DARK GOLD HEADER & 5-COLUMN SEARCH FILTER STRIP
                 ========================================== -->
            <div class="mb-4" data-aos="fade-up">
                <div class="rates-header-strip d-flex align-items-center justify-content-between">
                    <span><i class="bi bi-calendar-check text-warning me-2"></i> Select Your Room &amp; Rates</span>
                    <span class="fs-6 text-white-50 d-none d-md-inline"
                        style="font-family: var(--font-body); font-weight: normal;">Chanakyapuri, New Delhi</span>
                </div>
                <div class="rates-search-container">
                    <form id="rateFilterForm" onsubmit="return false;">
                        <div class="row g-3 align-items-end">

                            <div class="col-6 col-md-4 col-lg-2">
                                <label class="rate-input-label">
                                    <i class="bi bi-calendar3 me-1 text-warning"></i> Check-In
                                </label>
                                <input type="date" id="txtCheckIn" class="form-control rate-control"
                                    onchange="updateStaySummary()">
                            </div>

                            <div class="col-6 col-md-4 col-lg-2">
                                <label class="rate-input-label">
                                    <i class="bi bi-calendar3-event me-1 text-warning"></i> Check-Out
                                </label>
                                <input type="date" id="txtCheckOut" class="form-control rate-control"
                                    onchange="updateStaySummary()">
                            </div>

                            <div class="col-6 col-md-4 col-lg-2">
                                <label class="rate-input-label">
                                    <i class="bi bi-person-fill me-1 text-warning"></i> Adults
                                </label>
                                <select id="ddlAdults" class="form-select rate-control" onchange="updateStaySummary()">
                                    <option value="1">1 Adult</option>
                                    <option value="2" selected>2 Adults</option>
                                    <option value="3">3 Adults</option>
                                    <option value="4">4+ Adults</option>
                                </select>
                            </div>

                            <div class="col-6 col-md-4 col-lg-2">
                                <label class="rate-input-label">
                                    <i class="bi bi-person me-1 text-warning"></i> Children
                                </label>
                                <select id="ddlChildren" class="form-select rate-control">
                                    <option value="0" selected>0 Children</option>
                                    <option value="1">1 Child</option>
                                    <option value="2">2 Children</option>
                                </select>
                            </div>

                            <div class="col-12 col-md-4 col-lg-2">
                                <label class="rate-input-label">
                                    <i class="bi bi-door-closed-fill me-1 text-warning"></i> Rooms
                                </label>
                                <select id="ddlRooms" class="form-select rate-control">
                                    <option value="1" selected>1 Room</option>
                                    <option value="2">2 Rooms</option>
                                    <option value="3">3 Rooms</option>
                                </select>
                            </div>

                            <div class="col-12 col-lg-2">
                                <button type="button" class="btn btn-dark w-100 py-2 fw-bold text-uppercase"
                                    style="background: var(--royal-dark); border-color: var(--royal-dark); font-size: 0.82rem; letter-spacing: 0.8px;"
                                    onclick="scrollToRoomsList()">
                                    <i class="bi bi-search me-1"></i> Update Dates
                                </button>
                            </div>

                        </div>
                    </form>

                    <!-- Direct Booking Guarantee Bar -->
                    <div class="guarantee-bar d-flex flex-wrap align-items-center justify-content-between gap-2 mt-3">
                        <div class="d-flex align-items-center gap-2">
                            <span class="badge bg-warning text-dark fw-bold" style="font-size: 0.7rem;">BEST RATE
                                GUARANTEED</span>
                            <span>When You Book Direct With Us &nbsp;|&nbsp; <a href="#"
                                    class="text-decoration-underline text-secondary">Learn More</a></span>
                        </div>
                        <div class="text-secondary small">
                            <i class="bi bi-shield-check text-success me-1"></i> Instant Confirmation + No Hidden
                            Booking Fees
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==========================================
                 3. CATEGORY TABS & FILTER BAR
                 ========================================== -->
            <div class="bg-white border rounded-3 p-3 mb-4 shadow-sm" data-aos="fade-up">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 border-bottom pb-3 mb-3">
                    <div class="d-flex align-items-center gap-2">
                        <button type="button" class="rate-type-tab active" onclick="switchRateType('rates', this)">ROOM
                            RATES</button>
                        <button type="button" class="rate-type-tab" onclick="switchRateType('offers', this)">OFFERS
                            &amp; PACKAGES</button>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <div class="form-check form-switch mb-0">
                            <input class="form-check-input" type="checkbox" id="chkShowTaxes"
                                onchange="toggleTaxesDisplay()">
                            <label class="form-check-label small text-muted fw-semibold" for="chkShowTaxes">Show with
                                taxes &amp; fees</label>
                        </div>
                    </div>
                </div>

                <!-- Category Pills -->
                <div class="d-flex flex-wrap gap-2">
                    <button type="button" class="category-pill-btn active" onclick="filterRoomCards('all', this)">All
                        Rooms</button>
                    <button type="button" class="category-pill-btn" onclick="filterRoomCards('twin', this)">Superior
                        Room Twin Bed</button>
                    <button type="button" class="category-pill-btn" onclick="filterRoomCards('king', this)">Superior
                        Room King Bed</button>
                    <button type="button" class="category-pill-btn"
                        onclick="filterRoomCards('deluxe-king', this)">Deluxe Room King Bed</button>
                    <button type="button" class="category-pill-btn"
                        onclick="filterRoomCards('deluxe-twin', this)">Deluxe Room Twin Bed</button>
                    <button type="button" class="category-pill-btn" onclick="filterRoomCards('suite', this)">Luxury
                        Suite</button>
                    <button type="button" class="category-pill-btn"
                        onclick="filterRoomCards('presidential', this)">Presidential Suite</button>
                </div>
            </div>

            <!-- ==========================================
                 4. MAIN CONTENT (8-COL ROOM CARDS + 4-COL STICKY SUMMARY)
                 ========================================== -->
            <div class="row g-4" id="roomsListSection">

                <!-- LEFT COLUMN: ROOM CARDS LIST (8-COL) -->
                <div class="col-lg-8">

                    <!-- ROOM 1: SUPERIOR ROOM TWIN BED -->
                    <div class="room-rate-card room-card-item" data-category="twin">
                        <h2 class="room-card-header-title text-uppercase">Superior Room Twin Bed</h2>
                        <div class="p-4">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room1.jpg" alt="Superior Room Twin Bed"
                                            onerror="this.onerror=null; this.src='images/room-classic-double.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 37 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 3 guests</span>
                                        <span><i class="bi bi-distribute-vertical"></i> Twin Beds</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Superior+Room+Twin+Bed&price=8500&img=images/room1.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Elegantly crafted room featuring twin plush beds, ergonomic work desk, marble
                                        bathroom, and peaceful city views.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Breakfast Inclusive Rate -->
                            <div class="rate-option-box rounded" id="opt-1-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Breakfast Inclusive Rate</h4>
                                        <ul class="option-benefit-list">
                                            <li>Inclusive of buffet breakfast at designated dining venue</li>
                                            <li>Enjoy hands-on pottery, Pool Table &amp; games</li>
                                            <li>One plus One on Drinks during Happy Hours (4pm - 7pm)</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">7,224</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 8,500 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Superior Room Twin Bed', 'Breakfast Inclusive Rate', 7224, 'images/room1.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Option 2: Room Only / Best Available Rate -->
                            <div class="rate-option-box rounded mt-2" id="opt-1-2">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Room Only / Best Available Rate</h4>
                                        <ul class="option-benefit-list">
                                            <li>Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                            <li>Access to heated pool &amp; luxury fitness centre</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">6,375</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 7,500 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Superior Room Twin Bed', 'Room Only / Best Available Rate', 6375, 'images/room1.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                    <!-- ROOM 2: SUPERIOR ROOM KING BED -->
                    <div class="room-rate-card room-card-item" data-category="king">
                        <div class="d-flex align-items-center justify-content-between pe-4">
                            <h2 class="room-card-header-title text-uppercase mb-0 border-0">Superior Room King Bed</h2>
                            <span class="limited-badge"><i class="bi bi-exclamation-circle-fill"></i> Only Few Rooms
                                Available</span>
                        </div>
                        <div class="p-4 border-top">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room-superior-king.jpg" alt="Superior Room King Bed"
                                            onerror="this.onerror=null; this.src='images/room2.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 37 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 3 guests</span>
                                        <span><i class="bi bi-distribute-vertical"></i> King Bed</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Superior+Room+King+Bed&price=9000&img=images/room-superior-king.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Emperor king bedding with artisan wooden headboards, glass rain shower, and
                                        poolside sunbed access privileges.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Breakfast Inclusive Rate -->
                            <div class="rate-option-box rounded" id="opt-2-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Breakfast Inclusive Rate</h4>
                                        <ul class="option-benefit-list">
                                            <li>Gourmet breakfast spread at The Emperor's Pavilion</li>
                                            <li>Poolside sunbed access &amp; afternoon tea privilege</li>
                                            <li>Complimentary late checkout up to 1:00 PM</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">7,650</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 9,000 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Superior Room King Bed', 'Breakfast Inclusive Rate', 7650, 'images/room-superior-king.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Option 2: Royal Staycation & Dining -->
                            <div class="rate-option-box rounded mt-2" id="opt-2-2">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Royal Staycation &amp; Dining</h4>
                                        <ul class="option-benefit-list">
                                            <li>Daily breakfast &amp; dinner at The Royal Zafran</li>
                                            <li>20% savings on Spa therapies &amp; salon treatments</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">10,200</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 12,000 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Superior Room King Bed', 'Royal Staycation & Dining', 10200, 'images/room-superior-king.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>


                    <!-- ROOM 3: DELUXE ROOM KING BED -->
                    <div class="room-rate-card room-card-item" data-category="deluxe-king">
                        <h2 class="room-card-header-title text-uppercase">Deluxe Room King Bed</h2>
                        <div class="p-4">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room-featured-presidential.jpg" alt="Deluxe Room King Bed"
                                            onerror="this.onerror=null; this.src='images/room3.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 42 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 3 guests</span>
                                        <span><i class="bi bi-distribute-vertical"></i> King Bed</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Deluxe+Room+King+Bed&price=11000&img=images/room-featured-presidential.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Spacious luxury room featuring private balcony with garden &amp; skyline views,
                                        evening turndown service, and luxury bath amenities.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Breakfast Inclusive Rate -->
                            <div class="rate-option-box rounded" id="opt-3-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Breakfast Inclusive Rate</h4>
                                        <ul class="option-benefit-list">
                                            <li>Buffet breakfast at designated palace restaurant</li>
                                            <li>Private balcony with garden &amp; skyline views</li>
                                            <li>Evening turn-down service with artisanal chocolates</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">9,350</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 11,000 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Deluxe Room King Bed', 'Breakfast Inclusive Rate', 9350, 'images/room-featured-presidential.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- ROOM 4: DELUXE ROOM TWIN BED -->
                    <div class="room-rate-card room-card-item" data-category="deluxe-twin">
                        <h2 class="room-card-header-title text-uppercase">Deluxe Room Twin Bed</h2>
                        <div class="p-4">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room-mini-garden.jpg" alt="Deluxe Room Twin Bed"
                                            onerror="this.onerror=null; this.src='images/room1.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 42 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 3 guests</span>
                                        <span><i class="bi bi-distribute-vertical"></i> Twin Beds</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Deluxe+Room+Twin+Bed&price=11500&img=images/room-mini-garden.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Twin oversized plush beds, access to tennis &amp; squash courts, complimentary
                                        high-speed digital newspapers.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Breakfast Inclusive Rate -->
                            <div class="rate-option-box rounded" id="opt-4-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Breakfast Inclusive Rate</h4>
                                        <ul class="option-benefit-list">
                                            <li>Buffet breakfast at designated dining venue</li>
                                            <li>Complimentary high-speed Wi-Fi and digital newspapers</li>
                                            <li>Access to tennis &amp; squash courts</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">9,775</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 11,500 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Deluxe Room Twin Bed', 'Breakfast Inclusive Rate', 9775, 'images/room-mini-garden.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- ROOM 5: LUXURY SUITE (EXECUTIVE SUITE) -->
                    <div class="room-rate-card room-card-item" data-category="suite">
                        <h2 class="room-card-header-title text-uppercase">Luxury Suite (Executive Suite)</h2>
                        <div class="p-4">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room-mini-business.jpg" alt="Luxury Suite"
                                            onerror="this.onerror=null; this.src='images/room3.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 68 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 3 guests</span>
                                        <span><i class="bi bi-star"></i> Club Lounge</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Luxury+Suite+(Executive+Suite)&price=16000&img=images/room-mini-business.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Executive Club access, evening cocktails &amp; canapés, one-way luxury sedan
                                        airport transfer included.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Executive Club Lounge & Breakfast -->
                            <div class="rate-option-box rounded" id="opt-5-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Executive Club Lounge &amp; Breakfast</h4>
                                        <ul class="option-benefit-list">
                                            <li>All-day access to Chanakya Executive Club Lounge</li>
                                            <li>Cocktails &amp; canapés during evening happy hours (6pm - 8pm)</li>
                                            <li>One-way luxury sedan airport transfer</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">13,600</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 16,000 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Luxury Suite (Executive Suite)', 'Executive Club Lounge & Breakfast', 13600, 'images/room-mini-business.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- ROOM 6: GRAND PRESIDENTIAL PALACE SUITE -->
                    <div class="room-rate-card room-card-item" data-category="presidential">
                        <div class="d-flex align-items-center justify-content-between pe-4">
                            <h2 class="room-card-header-title text-uppercase mb-0 border-0">Grand Presidential Palace
                                Suite</h2>
                            <span class="limited-badge"><i class="bi bi-crown-fill text-warning"></i> VIP PALACE
                                SUITE</span>
                        </div>
                        <div class="p-4 border-top">
                            <div class="row g-3 mb-3">
                                <div class="col-md-5">
                                    <div class="room-gallery-thumb-wrapper">
                                        <img src="images/room-luxury-penthouse.jpg"
                                            alt="Grand Presidential Palace Suite"
                                            onerror="this.onerror=null; this.src='images/room-featured-presidential.jpg';">
                                        <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2
                                            Photos</span>
                                    </div>
                                    <div class="room-meta-info mt-2">
                                        <span><i class="bi bi-aspect-ratio"></i> 220 sqm</span>
                                        <span><i class="bi bi-people"></i> Up to 6 guests</span>
                                        <span><i class="bi bi-person-badge"></i> 24h Butler</span>
                                    </div>
                                    <a href="RoomDetails.aspx?title=Grand+Presidential+Palace+Suite&price=95999&img=images/room-luxury-penthouse.jpg"
                                        class="details-link d-inline-block mt-2">ROOM DETAILS &gt;</a>
                                </div>
                                <div class="col-md-7">
                                    <p class="text-muted small mb-0">
                                        Our crown jewel accommodation featuring 24-hour royal butler, chauffeur-driven
                                        Rolls-Royce, private chef, and unlimited spa privileges.
                                    </p>
                                </div>
                            </div>

                            <!-- Option 1: Imperial Butler & Royal Inclusions -->
                            <div class="rate-option-box rounded" id="opt-6-1">
                                <div class="row align-items-center g-3">
                                    <div class="col-md-6">
                                        <h4 class="option-title mb-2">Imperial Butler &amp; Royal Inclusions</h4>
                                        <ul class="option-benefit-list">
                                            <li>24-hour dedicated royal butler service &amp; private chef</li>
                                            <li>Chauffeur-driven luxury Rolls-Royce airport transfers</li>
                                            <li>All dining &amp; unlimited spa privileges inclusive</li>
                                        </ul>
                                    </div>
                                    <div class="col-md-6 text-md-end">
                                        <div class="price-rate-type">MEMBER RATE</div>
                                        <div class="member-price-text">&#8377; <span class="base-price">81,599</span>
                                            <small class="text-muted fw-normal">/ Night</small>
                                        </div>
                                        <div class="price-rate-type mt-1">STANDARD RATE</div>
                                        <div class="standard-price-text mb-2">&#8377; 95,999 / Night</div>
                                        <button type="button" class="btn btn-select-rate"
                                            onclick="selectRoomRate(this, 'Grand Presidential Palace Suite', 'Imperial Butler & Royal Inclusions', 81599, 'images/room-luxury-penthouse.jpg')">SELECT</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- RIGHT COLUMN: STICKY "YOUR STAY" SUMMARY CARD (4-COL) -->
                <div class="col-lg-4">
                    <div class="sticky-stay-card">
                        <div class="stay-card-header d-flex align-items-center justify-content-between">
                            <span>YOUR STAY</span>
                            <i class="bi bi-shield-lock-fill fs-5 text-warning"></i>
                        </div>
                        <div class="stay-card-body">

                            <!-- Guests & Room Summary -->
                            <div class="border-bottom pb-3 mb-3">
                                <div class="d-flex align-items-center justify-content-between mb-1">
                                    <span class="fw-bold text-dark small" id="lblSummaryRoom">Room 1: 2 Adults</span>
                                    <span class="badge bg-light text-muted border small" id="lblSummaryDates">1
                                        Night</span>
                                </div>
                                <div class="small text-muted" id="lblSelectedRoomName">No room selected yet</div>
                                <div class="small text-gold fw-semibold" id="lblSelectedRateName"></div>
                            </div>

                            <!-- Pricing Details -->
                            <div class="stay-price-row">
                                <span class="text-secondary">Base Room Price</span>
                                <span class="fw-semibold text-dark">&#8377; <span id="lblBasePrice">0.00</span></span>
                            </div>
                            <div class="stay-price-row">
                                <span class="text-secondary">Taxes &amp; Fees (18% GST)</span>
                                <span class="fw-semibold text-dark">&#8377; <span id="lblTaxes">0.00</span></span>
                            </div>

                            <div class="stay-price-row stay-total-row">
                                <span>Total Amount</span>
                                <span class="text-danger fs-5">&#8377; <span id="lblTotalAmount">0.00</span></span>
                            </div>

                            <!-- Booking CTA Button -->
                            <div class="mt-4">
                                <button type="button" id="btnProceedBooking" class="btn-proceed-booking" disabled
                                    onclick="proceedToBooking()">
                                    Select A Room
                                </button>
                            </div>

                            <!-- Empty Selection Prompt -->
                            <div id="emptyPromptMessage" class="text-center py-3 text-muted small mt-2">
                                <i class="bi bi-hand-index-thumb text-gold fs-4 d-block mb-1"></i>
                                Select a room rate option from the left to proceed with your luxury reservation.
                            </div>

                            <!-- Trust Guarantee -->
                            <div class="trust-badge-footer">
                                <i class="bi bi-lock-fill text-success me-1"></i> 256-Bit SSL Encrypted &bull; Best Rate
                                Guarantee
                            </div>

                        </div>
                    </div>
                </div>

            </div>

        </div>

        <!-- ==========================================
             5. CLIENT-SIDE INTERACTIVE JAVASCRIPT
             ========================================== -->
        <script>
            var selectedRoomData = null;

            document.addEventListener('DOMContentLoaded', function () {
                initDefaultDates();
            });

            function initDefaultDates() {
                var today = new Date();
                var tomorrow = new Date();
                tomorrow.setDate(today.getDate() + 1);

                var cin = document.getElementById('txtCheckIn');
                var cout = document.getElementById('txtCheckOut');

                if (cin && !cin.value) cin.valueAsDate = today;
                if (cout && !cout.value) cout.valueAsDate = tomorrow;

                updateStaySummary();
            }

            function updateStaySummary() {
                var adults = document.getElementById('ddlAdults') ? document.getElementById('ddlAdults').value : "2";
                var summaryRoom = document.getElementById('lblSummaryRoom');
                if (summaryRoom) {
                    summaryRoom.textContent = "Room 1: " + adults + " Adult(s)";
                }

                var cin = document.getElementById('txtCheckIn') ? new Date(document.getElementById('txtCheckIn').value) : null;
                var cout = document.getElementById('txtCheckOut') ? new Date(document.getElementById('txtCheckOut').value) : null;

                if (cin && cout && cout > cin) {
                    var nights = Math.ceil((cout - cin) / (1000 * 60 * 60 * 24));
                    var lblDates = document.getElementById('lblSummaryDates');
                    if (lblDates) lblDates.textContent = nights + " Night(s)";

                    if (selectedRoomData) {
                        calculateTotal(selectedRoomData.price * nights);
                    }
                }
            }

            function filterRoomCards(category, btn) {
                var btns = document.querySelectorAll('.category-pill-btn');
                btns.forEach(function (b) { b.classList.remove('active'); });
                if (btn) btn.classList.add('active');

                var cards = document.querySelectorAll('.room-card-item');
                cards.forEach(function (card) {
                    if (category === 'all' || card.getAttribute('data-category') === category) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            }

            function switchRateType(type, btn) {
                var tabs = document.querySelectorAll('.rate-type-tab');
                tabs.forEach(function (t) { t.classList.remove('active'); });
                if (btn) btn.classList.add('active');
            }

            function toggleTaxesDisplay() {
                var chk = document.getElementById('chkShowTaxes');
                var showTax = chk ? chk.checked : false;

                document.querySelectorAll('.room-rate-card').forEach(function (card) {
                    var baseElements = card.querySelectorAll('.base-price');
                    baseElements.forEach(function (elem) {
                        var base = parseFloat(elem.textContent.replace(/,/g, ''));
                        if (showTax) {
                            var withTax = Math.round(base * 1.18);
                            elem.textContent = withTax.toLocaleString('en-IN');
                        } else {
                            elem.textContent = base.toLocaleString('en-IN');
                        }
                    });
                });
            }

            function selectRoomRate(btn, roomName, rateName, basePrice, imgUrl) {
                // Unselect all boxes
                document.querySelectorAll('.rate-option-box').forEach(function (b) {
                    b.classList.remove('selected-option');
                    var bBtn = b.querySelector('.btn-select-rate');
                    if (bBtn) {
                        bBtn.textContent = 'SELECT';
                    }
                });

                // Highlight selected
                var parentBox = btn.closest('.rate-option-box');
                if (parentBox) {
                    parentBox.classList.add('selected-option');
                }
                btn.textContent = 'SELECTED ✓';

                selectedRoomData = {
                    roomName: roomName,
                    rateName: rateName,
                    price: basePrice,
                    img: imgUrl
                };

                // Update summary labels
                document.getElementById('lblSelectedRoomName').textContent = roomName;
                document.getElementById('lblSelectedRateName').textContent = rateName;

                var promptMsg = document.getElementById('emptyPromptMessage');
                if (promptMsg) promptMsg.style.display = 'none';

                var cin = document.getElementById('txtCheckIn') ? new Date(document.getElementById('txtCheckIn').value) : new Date();
                var cout = document.getElementById('txtCheckOut') ? new Date(document.getElementById('txtCheckOut').value) : new Date();
                var nights = (cout > cin) ? Math.ceil((cout - cin) / (1000 * 60 * 60 * 24)) : 1;

                calculateTotal(basePrice * nights);

                // Enable Proceed button
                var proceedBtn = document.getElementById('btnProceedBooking');
                if (proceedBtn) {
                    proceedBtn.disabled = false;
                    proceedBtn.innerHTML = 'PROCEED TO BOOKING <i class="bi bi-arrow-right ms-2"></i>';
                }
            }

            function calculateTotal(totalBase) {
                var taxes = totalBase * 0.18;
                var grandTotal = totalBase + taxes;

                document.getElementById('lblBasePrice').textContent = totalBase.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                document.getElementById('lblTaxes').textContent = taxes.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                document.getElementById('lblTotalAmount').textContent = grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            }

            function proceedToBooking() {
                if (!selectedRoomData) return;
                var url = "RoomDetails.aspx?title=" + encodeURIComponent(selectedRoomData.roomName) + "&price=" + selectedRoomData.price + "&img=" + encodeURIComponent(selectedRoomData.img);
                window.location.href = url;
            }

            function scrollToRoomsList() {
                var el = document.getElementById('roomsListSection');
                if (el) el.scrollIntoView({ behavior: 'smooth' });
            }
        </script>

    </asp:Content>
    </asp:Content>