<%@ Page Title="Book Now - Room Rates & Packages | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="BookNow.aspx.cs" Inherits="BookNow" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link href="css/booknow.css?v=6.0" rel="stylesheet" />
        <script src="js/book-now.js?v=6.0"></script>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <div class="booknow-page-container">

            <!-- ==========================================
             1. STAY SCHEDULE MODIFIER BAR (TOP STRIP)
             ========================================== -->
            <section class="py-3 border-bottom shadow-sm bg-white">
                <div class="container-fluid px-4 px-lg-5">
                    <div class="row g-3 align-items-center">
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label text-muted small fw-bold mb-1">
                                <i class="bi bi-calendar-check text-warning me-1"></i> CHECK-IN
                            </label>
                            <input type="date" class="form-control schedule-bar-input fw-semibold" id="arrivalDate">
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label class="form-label text-muted small fw-bold mb-1">
                                <i class="bi bi-calendar-x text-warning me-1"></i> CHECK-OUT
                            </label>
                            <input type="date" class="form-control schedule-bar-input fw-semibold" id="departureDate">
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <label class="form-label text-muted small fw-bold mb-1">
                                <i class="bi bi-person text-warning me-1"></i> ADULTS
                            </label>
                            <select class="form-select schedule-bar-input fw-semibold" id="bookingAdults">
                                <option value="1">1 Adult</option>
                                <option value="2" selected>2 Adults</option>
                                <option value="3">3 Adults</option>
                                <option value="4">4 Adults</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <label class="form-label text-muted small fw-bold mb-1">
                                <i class="bi bi-people text-warning me-1"></i> CHILDREN
                            </label>
                            <select class="form-select schedule-bar-input fw-semibold" id="bookingChildren">
                                <option value="0" selected>0 Children</option>
                                <option value="1">1 Child</option>
                                <option value="2">2 Children</option>
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <label class="form-label text-muted small fw-bold mb-1">
                                <i class="bi bi-door-open text-warning me-1"></i> ROOMS
                            </label>
                            <select class="form-select schedule-bar-input fw-semibold" id="totalRooms">
                                <option value="1" selected>1 Room</option>
                                <option value="2">2 Rooms</option>
                                <option value="3">3 Rooms</option>
                            </select>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ==========================================
             2. RATES & PACKAGES CONTAINER (IMAGE 1 SECTION)
             ========================================== -->
            <div class="container-fluid px-4 px-lg-5 pt-4">

                <!-- ==========================================
                 GRAND ANIMATED PAGE HEADING (MATCHING ALL PAGES)
                 ========================================== -->
                <div class="text-center mb-4 pt-1" data-aos="fade-down" data-aos-duration="1000">
                    <span class="welcome-subtitle-anim">
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        Best Rate Guaranteed Accommodations
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                    </span>
                    <h1 class="welcome-title-anim mb-2">
                        Choose Your <span class="welcome-title-gold">Luxury Room &amp; Rates</span>
                    </h1>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                </div>

                <!-- Best Rate Guarantee Banner -->
                <div
                    class="best-rate-banner d-flex flex-column flex-sm-row align-items-center justify-content-between gap-2 mb-4">
                    <div class="d-flex align-items-center gap-2 text-dark small">
                        <i class="bi bi-patch-check-fill text-warning fs-5"></i>
                        <span><strong>Best Rate Guaranteed</strong> When You Book Direct With Us.</span>
                        <a href="javascript:void(0)" class="text-decoration-underline fw-bold text-dark ms-1">Learn
                            More</a>
                    </div>
                    <div class="small text-muted">
                        <i class="bi bi-lock-fill text-warning me-1"></i> Instant Confirmation &bull; No Hidden Booking
                        Fees
                    </div>
                </div>

                <!-- Tabs & Taxes Control Bar -->
                <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-3">
                    <div class="d-inline-flex gap-2">
                        <button type="button" class="bn-tab-button active"
                            onclick="switchRatesTab('rates', this); return false;" id="tabBtnRates">
                            ROOM RATES
                        </button>
                        <button type="button" class="bn-tab-button"
                            onclick="switchRatesTab('offers', this); return false;" id="tabBtnOffers">
                            OFFERS &amp; PACKAGES
                        </button>
                    </div>

                    <div class="form-check form-switch mb-0">
                        <input class="form-check-input" type="checkbox" role="switch" id="showTaxesToggle"
                            onchange="toggleTaxesDisplay(this.checked)">
                        <label class="form-check-label fw-semibold text-dark small" for="showTaxesToggle">
                            Show with taxes and fees
                        </label>
                    </div>
                </div>

                <!-- ==========================================
                 VIEW 1: ROOM RATES SECTION
                 ========================================== -->
                <div id="viewRoomRatesSection">
                    <!-- Section Subtitle & Filter Pills Bar -->
                    <div class="mb-4">
                        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                            <h5 class="font-serif fw-bold mb-0" style="color: #442305;">Rooms For Your Search</h5>
                            <span class="text-muted small" id="searchContextSummary">Showing 6 available luxury rooms
                                &bull; 2 Adults</span>
                        </div>

                        <div class="d-flex flex-wrap gap-2 pt-1" id="filterPillsContainer">
                            <button type="button" class="bn-filter-pill active" data-filter="all"
                                onclick="filterBookNowRooms('all', this); return false;">All Rooms</button>
                            <button type="button" class="bn-filter-pill" data-filter="superior-twin"
                                onclick="filterBookNowRooms('superior-twin', this); return false;">Superior Room Twin
                                Bed</button>
                            <button type="button" class="bn-filter-pill" data-filter="superior-king"
                                onclick="filterBookNowRooms('superior-king', this); return false;">Superior Room King
                                Bed</button>
                            <button type="button" class="bn-filter-pill" data-filter="deluxe-king"
                                onclick="filterBookNowRooms('deluxe-king', this); return false;">Deluxe Room King
                                Bed</button>
                            <button type="button" class="bn-filter-pill" data-filter="deluxe-twin"
                                onclick="filterBookNowRooms('deluxe-twin', this); return false;">Deluxe Room Twin
                                Bed</button>
                            <button type="button" class="bn-filter-pill" data-filter="luxury-suite"
                                onclick="filterBookNowRooms('luxury-suite', this); return false;">Luxury Suite</button>
                            <button type="button" class="bn-filter-pill" data-filter="presidential"
                                onclick="filterBookNowRooms('presidential', this); return false;">Presidential
                                Suite</button>
                        </div>
                    </div>

                    <!-- ==========================================
                 3. ROOM CARDS LIST (IMAGE 3 DESIGN FOR EACH ROOM)
                 ========================================== -->

                    <!-- ROOM CARD 1: SUPERIOR ROOM TWIN BED -->
                    <div class="room-card-luxury-block" data-category="superior-twin" id="card_superior_twin" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">
                                            Superior
                                            Room</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Superior Room Twin Bed</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">Spacious, elegant and
                                    thoughtfully
                                    designed for your perfect stay.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 37 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 3 guests</span>
                                    <span><i class="bi bi-door-open text-dark me-1"></i> Twin Beds</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery -->
                            <div class="col-lg-5" data-aos="fade-right" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_superior_twin" src="images/room-classic-double.jpg"
                                        alt="Superior Room Twin Bed"
                                        onclick="openImageLightbox('mainImg_superior_twin', 'Superior Room Twin Bed')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_superior_twin', 'Superior Room Twin Bed')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('superior_twin')"><i
                                            class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('superior_twin')"><i
                                            class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-classic-double.jpg"
                                            class="img-fluid thumb-preview-img thumb_superior_twin active w-100"
                                            onclick="selectRoomPhoto('superior_twin', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-superior-king.jpg"
                                            class="img-fluid thumb-preview-img thumb_superior_twin w-100"
                                            onclick="selectRoomPhoto('superior_twin', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details -->
                            <div class="col-lg-4" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-wifi fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Complimentary high-speed Wi-Fi &amp;
                                                valet parking</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-house fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Modern amenities and elegant
                                                interiors
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-water fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Access to heated pool &amp; luxury
                                                fitness centre</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i
                                                    class="fa-solid fa-bell-concierge fs-5"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">24/7 room service &amp; concierge
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('superior_twin', 7225, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;7,225 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_superior_twin"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('superior_twin', 8500, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;8,500 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_superior_twin"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>


                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card -->
                            <div class="col-lg-3" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">7,225.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">1,300.50</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">8,525.50</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Superior%20Room%20Twin%20Bed&price=7225&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM CARD 2: SUPERIOR ROOM KING BED -->
                    <div class="room-card-luxury-block" data-category="superior-king" id="card_superior_king" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">
                                            Superior
                                            Room King</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Superior Room King Bed</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">Crafted with royal elegance,
                                    plush
                                    emperor bedding &amp; panoramic views.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 40 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 3 guests</span>
                                    <span><i class="bi bi-door-open text-dark me-1"></i> King Emperor Bed</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Right) -->
                            <div class="col-lg-5" data-aos="fade-left" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_superior_king" src="images/room-superior-king.jpg"
                                        alt="Superior Room King Bed"
                                        onclick="openImageLightbox('mainImg_superior_king', 'Superior Room King Bed')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_superior_king', 'Superior Room King Bed')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('superior_king')"><i
                                             class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('superior_king')"><i
                                             class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-superior-king.jpg"
                                            class="img-fluid thumb-preview-img thumb_superior_king active w-100"
                                            onclick="selectRoomPhoto('superior_king', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-classic-double.jpg"
                                            class="img-fluid thumb-preview-img thumb_superior_king w-100"
                                            onclick="selectRoomPhoto('superior_king', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details (Enters from Left) -->
                            <div class="col-lg-4" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-wifi fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Complimentary high-speed Wi-Fi &amp;
                                                valet parking</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="fa-solid fa-bath fs-5"></i></div>
                                            <div class="small text-secondary lh-sm">Marble bath with Italian rainfall
                                                shower
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-water fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Access to heated pool &amp; luxury
                                                fitness centre</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i
                                                    class="fa-solid fa-bell-concierge fs-5"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">24/7 room service &amp; concierge
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('superior_king', 8200, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;8,200 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_superior_king"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('superior_king', 9500, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;9,500 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_superior_king"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card (Enters from Left) -->
                            <div class="col-lg-3" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">8,200.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">1,476.00</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">9,676.00</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Superior%20Room%20King%20Bed&price=8200&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM CARD 3: DELUXE ROOM KING BED -->
                    <div class="room-card-luxury-block" data-category="deluxe-king" id="card_deluxe_king" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">Deluxe
                                            Room
                                            King</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Deluxe Room King Bed</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">Lush botanical views, sun
                                    balcony,
                                    acoustic glass &amp; luxury comfort.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 45 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 2 guests</span>
                                    <span><i class="bi bi-tree text-dark me-1"></i> Garden View</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Left) -->
                            <div class="col-lg-5" data-aos="fade-right" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_deluxe_king" src="images/room-mini-garden.jpg"
                                        alt="Deluxe Room King Bed"
                                        onclick="openImageLightbox('mainImg_deluxe_king', 'Deluxe Room King Bed')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_deluxe_king', 'Deluxe Room King Bed')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('deluxe_king')"><i
                                            class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('deluxe_king')"><i
                                            class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-mini-garden.jpg"
                                            class="img-fluid thumb-preview-img thumb_deluxe_king active w-100"
                                            onclick="selectRoomPhoto('deluxe_king', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-classic-double.jpg"
                                            class="img-fluid thumb-preview-img thumb_deluxe_king w-100"
                                            onclick="selectRoomPhoto('deluxe_king', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details (Enters from Right) -->
                            <div class="col-lg-4" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-tree fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Private sun terrace overlooking
                                                botanical gardens</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-wifi fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Complimentary high-speed Wi-Fi &amp;
                                                valet parking</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-tv fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">50" 4K Smart OLED TV with soundbar
                                            </div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i
                                                    class="bi bi-person-workspace fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">24/7 room service &amp; concierge
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('deluxe_king', 9800, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;9,800 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_deluxe_king"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('deluxe_king', 11500, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;11,500 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_deluxe_king"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card (Enters from Right) -->
                            <div class="col-lg-3" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">9,800.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">1,764.00</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">11,564.00</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Deluxe%20Room%20King%20Bed&price=9800&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM CARD 4: DELUXE ROOM TWIN BED -->
                    <div class="room-card-luxury-block" data-category="deluxe-twin" id="card_deluxe_twin" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">Deluxe
                                            Room
                                            Twin</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Deluxe Room Twin Bed</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">Serene garden view,
                                    acoustically treated windows &amp; deluxe twin comfort.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 48 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 3 guests</span>
                                    <span><i class="bi bi-door-open text-dark me-1"></i> Deluxe Twin Beds</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Right) -->
                            <div class="col-lg-5" data-aos="fade-left" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_deluxe_twin" src="images/room-mini-family.jpg"
                                        alt="Deluxe Room Twin Bed"
                                        onclick="openImageLightbox('mainImg_deluxe_twin', 'Deluxe Room Twin Bed')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_deluxe_twin', 'Deluxe Room Twin Bed')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('deluxe_twin')"><i
                                            class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('deluxe_twin')"><i
                                            class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-mini-family.jpg"
                                            class="img-fluid thumb-preview-img thumb_deluxe_twin active w-100"
                                            onclick="selectRoomPhoto('deluxe_twin', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-classic-double.jpg"
                                            class="img-fluid thumb-preview-img thumb_deluxe_twin w-100"
                                            onclick="selectRoomPhoto('deluxe_twin', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details (Enters from Left) -->
                            <div class="col-lg-4" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-door-open fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Two plush ergonomic twin single beds
                                                with feather pillows</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-volume-mute fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Garden courtyard view with acoustic
                                                soundproofing</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-wifi fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Complimentary high-speed Wi-Fi &amp;
                                                valet parking</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-droplet-half fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Deluxe marble bathroom with separate
                                                rainfall shower</div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('deluxe_twin', 10500, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;10,500 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_deluxe_twin"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('deluxe_twin', 12000, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;12,000 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_deluxe_twin"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card (Enters from Left) -->
                            <div class="col-lg-3" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">10,500.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">1,890.00</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">12,390.00</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Deluxe%20Room%20Twin%20Bed&price=10500&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM CARD 5: LUXURY SUITE -->
                    <div class="room-card-luxury-block" data-category="luxury-suite" id="card_luxury_suite" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">Luxury
                                            Suite</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Luxury Suite</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">Spacious executive living
                                    salon, panoramic skyline views &amp; VIP club lounge access.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 65 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 4 guests</span>
                                    <span><i class="bi bi-door-open text-dark me-1"></i> King Bed &amp; Lounge</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Left) -->
                            <div class="col-lg-5" data-aos="fade-right" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_luxury_suite" src="images/room-mini-business.jpg"
                                        alt="Luxury Suite"
                                        onclick="openImageLightbox('mainImg_luxury_suite', 'Luxury Suite')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_luxury_suite', 'Luxury Suite')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('luxury_suite')"><i
                                            class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('luxury_suite')"><i
                                            class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-mini-business.jpg"
                                            class="img-fluid thumb-preview-img thumb_luxury_suite active w-100"
                                            onclick="selectRoomPhoto('luxury_suite', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-superior-king.jpg"
                                            class="img-fluid thumb-preview-img thumb_luxury_suite w-100"
                                            onclick="selectRoomPhoto('luxury_suite', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details (Enters from Right) -->
                            <div class="col-lg-4" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-house fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Separate living salon &amp;
                                                executive dining area</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-cup-hot fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Complimentary gourmet breakfast
                                                buffet at signature restaurant</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-stars fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Access to exclusive Club Lounge with
                                                all-day refreshments</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-person-check fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Dedicated personal butler service
                                                upon request</div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('luxury_suite', 16500, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;16,500 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_luxury_suite"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('luxury_suite', 19000, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;19,000 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_luxury_suite"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card (Enters from Right) -->
                            <div class="col-lg-3" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">16,500.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">2,970.00</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">19,470.00</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Luxury%20Suite&price=16500&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM CARD 6: PRESIDENTIAL SUITE -->
                    <div class="room-card-luxury-block" data-category="presidential" id="card_presidential" data-aos="fade-up">
                        <!-- Card Top Header -->
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <nav aria-label="breadcrumb" class="mb-2">
                                    <ol class="breadcrumb small text-muted mb-0 align-items-center">
                                        <li class="breadcrumb-item"><a href="Default.aspx"
                                                class="text-decoration-none text-muted"><i
                                                    class="bi bi-house-door-fill text-warning me-1"></i> Home</a></li>
                                        <li class="breadcrumb-item"><a href="Room.aspx"
                                                class="text-decoration-none text-muted">Rooms</a></li>
                                        <li class="breadcrumb-item active text-dark fw-bold" aria-current="page">
                                            Presidential
                                            Suite</li>
                                    </ol>
                                </nav>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Presidential Suite</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-3 font-serif fst-italic">The pinnacle of royal luxury
                                    with private jacuzzi, personal butler &amp; bespoke dining.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-aspect-ratio text-dark me-1"></i> 120 sq m</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> Up to 5 guests</span>
                                    <span><i class="bi bi-door-open text-dark me-1"></i> Master Royal Bed &amp;
                                        Suite</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Comfort &bull; Luxury &bull;
                                    Unforgettable Stays</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <!-- Card 3-Column Content Grid -->
                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Right) -->
                            <div class="col-lg-5" data-aos="fade-left" data-aos-duration="1000">
                                <div class="room-gallery-frame mb-3">
                                    <img id="mainImg_presidential" src="images/room-luxury-penthouse.jpg"
                                        alt="Presidential Suite"
                                        onclick="openImageLightbox('mainImg_presidential', 'Presidential Suite')">
                                    <span class="photo-count-badge"><i class="bi bi-camera me-1"></i> 2 Photos</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('mainImg_presidential', 'Presidential Suite')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                    <button type="button" class="gallery-nav-btn prev"
                                        onclick="prevRoomPhoto('presidential')"><i
                                            class="bi bi-chevron-left"></i></button>
                                    <button type="button" class="gallery-nav-btn next"
                                        onclick="nextRoomPhoto('presidential')"><i
                                            class="bi bi-chevron-right"></i></button>
                                </div>
                                <div class="row g-2">
                                    <div class="col-6">
                                        <img src="images/room-luxury-penthouse.jpg"
                                            class="img-fluid thumb-preview-img thumb_presidential active w-100"
                                            onclick="selectRoomPhoto('presidential', 0)">
                                    </div>
                                    <div class="col-6">
                                        <img src="images/room-featured-presidential.jpg"
                                            class="img-fluid thumb-preview-img thumb_presidential w-100"
                                            onclick="selectRoomPhoto('presidential', 1)">
                                    </div>
                                </div>
                            </div>

                            <!-- Middle: Room Highlights & Rate Details (Enters from Left) -->
                            <div class="col-lg-4" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box mb-4">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Room Highlights</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="fa-solid fa-crown fs-5"></i></div>
                                            <div class="small text-secondary lh-sm">Grand royal master bedroom with
                                                walk-in dressing salon</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-water fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Private heated jacuzzi, sauna &amp;
                                                expansive terrace</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-car-front fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Complimentary airport limousine
                                                transfer &amp; 24/7 butler</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-cup-straw fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Full gourmet dining room &amp;
                                                private bar service</div>
                                        </div>
                                    </div>
                                </div>

                                <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Rate Details</h4>
                                <div class="rate-plan-card active mb-3"
                                    onclick="selectRatePlan('presidential', 35000, 'Room Only', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1">Room Only</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-danger fw-semibold mb-1"><i class="bi bi-x-circle me-1"></i> No meals included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;35,000 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_presidential"
                                                class="form-check-input rate-radio mt-2" checked>
                                        </div>
                                    </div>
                                </div>

                                <div class="rate-plan-card mb-3" onclick="selectRatePlan('presidential', 40000, 'Standard Rate', this)">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="fw-bold text-dark mb-1"><i
                                                    class="bi bi-crown text-warning me-1"></i> Standard Rate</div>
                                            <ul class="list-unstyled small text-muted mb-0" style="font-size: 0.78rem;">
                                                <li class="text-success fw-semibold mb-1"><i class="bi bi-cup-hot-fill text-warning me-1"></i> Daily Buffet Breakfast Included</li>
                                                <li class="mb-1">&bull; Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                <li class="mb-1">&bull; Access to heated pool &amp; luxury fitness centre</li>
                                                <li class="text-success mb-1" style="font-size: 0.73rem;"><i class="bi bi-check-circle me-1"></i> Free cancellation up to 48h prior</li>
                                                <li class="text-secondary" style="font-size: 0.73rem;"><i class="bi bi-credit-card me-1"></i> Pay at hotel &bull; No deposit required</li>
                                            </ul>
                                        </div>
                                        <div class="text-end ms-2">
                                            <span class="badge text-uppercase fw-semibold p-1 member-rate-badge"
                                                style="font-size: 0.65rem; background: #faf0e6; color: #9A724E;">MEMBER RATE</span>
                                            <div class="fw-bold text-dark fs-5">&#8377;40,000 <small class="text-muted"
                                                    style="font-size: 0.7rem;">/ Night</small></div>
                                            <div class="text-muted" style="font-size: 0.65rem;">Taxes &amp; fees may apply</div>
                                            <input type="radio" name="rate_presidential"
                                                class="form-check-input rate-radio mt-2">
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Right: Your Stay Booking Sidebar Card (Enters from Left) -->
                            <div class="col-lg-3" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">YOUR STAY</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Your Stay</h3>
                                        <p class="text-white-50 small mb-0">Luxury stays, premium experiences</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="guest-info-select mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <i class="bi bi-people fs-4 text-dark"></i>
                                                <div>
                                                    <div class="fw-bold text-dark small mb-0">Room 1: 2 Adults</div>
                                                    <div class="text-muted" style="font-size: 0.72rem;">Not selected
                                                    </div>
                                                </div>
                                            </div>
                                            <i class="bi bi-chevron-down text-muted"></i>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Price <i class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-base-price">35,000.00</span></span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes and Fees <i
                                                    class="bi bi-info-circle text-muted ms-1"></i></span>
                                            <span class="fw-semibold text-dark">&#8377; <span
                                                    class="sidebar-tax-price">6,300.00</span></span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; <span
                                                    class="sidebar-total-price">41,300.00</span></span>
                                        </div>
                                        <div class="border border-dashed p-3 rounded-3 text-center bg-light mb-3">
                                            <i class="bi bi-crown text-warning fs-5 mb-1 d-block"></i>
                                            <div class="text-muted" style="font-size: 0.78rem;">Select a room rate above
                                                to
                                                proceed with your luxury reservation.</div>
                                        </div>
                                        <a href="Booking.aspx?room=Presidential%20Suite&price=35000&rate=Room%20Only"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Now</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End of card_presidential -->
                </div>
                <!-- End of viewRoomRatesSection -->

                <!-- ==========================================
                 VIEW 2: OFFERS & PACKAGES SECTION
                 ========================================== -->
                <div id="viewOffersPackagesSection" style="display: none;">
                    <!-- Section Subtitle & Package Filters -->
                    <div class="mb-4">
                        <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                            <h5 class="font-serif fw-bold mb-0" style="color: #442305;">Curated Offers &amp; Packages
                            </h5>
                            <span class="text-muted small" id="packageContextSummary">Showing 4 special packages &bull;
                                Best rate guaranteed</span>
                        </div>

                        <div class="d-flex flex-wrap gap-2 pt-1" id="packageFiltersContainer">
                            <button type="button" class="bn-package-pill active" data-package-filter="all"
                                onclick="filterPackages('all', this); return false;">All Packages</button>
                            <button type="button" class="bn-package-pill" data-package-filter="stay-dine"
                                onclick="filterPackages('stay-dine', this); return false;">Stay &amp; Dine</button>
                            <button type="button" class="bn-package-pill" data-package-filter="spa"
                                onclick="filterPackages('spa', this); return false;">Spa &amp; Wellness</button>
                            <button type="button" class="bn-package-pill" data-package-filter="weekend"
                                onclick="filterPackages('weekend', this); return false;">Weekend Romance</button>
                            <button type="button" class="bn-package-pill" data-package-filter="family"
                                onclick="filterPackages('family', this); return false;">Family Retreat</button>
                        </div>
                    </div>

                    <!-- PACKAGE 1: Royal Breakfast & Dining Experience -->
                    <div class="package-offer-card-block" data-package-category="stay-dine" data-aos="fade-up">
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <span class="badge text-uppercase bg-warning text-dark fw-bold mb-2">LIMITED TIME
                                    DEAL</span>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Royal Breakfast &amp; Dining Package</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-2 font-serif fst-italic">Indulge in lavish buffet
                                    breakfast, 4-course gourmet dinner &amp; chef's welcome amenity.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-gift text-dark me-1"></i> Special Package</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> 2 Guests</span>
                                    <span><i class="bi bi-cup-hot text-dark me-1"></i> Breakfast &amp; Dinner
                                        Included</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Save 25% Off Standard
                                    Pricing</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Left) -->
                            <div class="col-lg-5" data-aos="fade-right" data-aos-duration="1000">
                                <div class="room-gallery-frame">
                                    <img id="pkgImg_1" src="images/room-classic-double.jpg" alt="Dining Package"
                                        style="height: 280px; object-fit: cover; width: 100%;"
                                        onclick="openImageLightbox('pkgImg_1', 'Royal Breakfast &amp; Dining Package')">
                                    <span class="photo-count-badge"><i class="bi bi-stars me-1"></i> Special
                                        Offer</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('pkgImg_1', 'Royal Breakfast &amp; Dining Package')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                            <!-- Middle: Highlights (Enters from Right) -->
                            <div class="col-lg-4" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Package Inclusions</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-egg-fried fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Daily royal breakfast buffet for 2
                                                adults</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-cup-straw fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">&#8377;2,500 daily dining &amp;
                                                beverage credit included</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-clock-history fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Guaranteed late checkout up to 3:00
                                                PM</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-wifi fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">High-speed Wi-Fi, valet &amp; pool
                                                access</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Right: Sidebar (Enters from Right) -->
                            <div class="col-lg-3" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">PACKAGE DEAL</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Package</h3>
                                        <p class="text-white-50 small mb-0">Inclusive of all privileges</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Package Price</span>
                                            <span class="fw-semibold text-dark">&#8377; 9,999.00</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes &amp; Fees (18%)</span>
                                            <span class="fw-semibold text-dark">&#8377; 1,799.82</span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; 11,798.82</span>
                                        </div>
                                        <a href="Booking.aspx?room=Royal%20Dining%20Package&price=9999"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Package</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PACKAGE 2: Ayurveda Spa & Wellness Retreat -->
                    <div class="package-offer-card-block" data-package-category="spa" data-aos="fade-up">
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <span class="badge text-uppercase bg-warning text-dark fw-bold mb-2">SPA &amp;
                                    WELLNESS</span>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Ayurveda Spa &amp; Wellness Retreat</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-2 font-serif fst-italic">Rejuvenate mind and body with
                                    60-minute therapeutic massage &amp; wellness consultation.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-flower1 text-dark me-1"></i> Wellness Therapy</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> 2 Guests</span>
                                    <span><i class="bi bi-water text-dark me-1"></i> Spa Credit Included</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Ultimate Holistic
                                    Relaxation</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Right) -->
                            <div class="col-lg-5" data-aos="fade-left" data-aos-duration="1000">
                                <div class="room-gallery-frame">
                                    <img id="pkgImg_2" src="images/room-superior-king.jpg" alt="Spa Package"
                                        style="height: 280px; object-fit: cover; width: 100%;"
                                        onclick="openImageLightbox('pkgImg_2', 'Luxury Ayurveda &amp; Spa Rejuvenation Package')">
                                    <span class="photo-count-badge"><i class="bi bi-stars me-1"></i> Wellness
                                        Retreat</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('pkgImg_2', 'Luxury Ayurveda &amp; Spa Rejuvenation Package')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                            <!-- Middle: Inclusions (Enters from Left) -->
                            <div class="col-lg-4" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Package Inclusions</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-flower1 fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">60-minute signature aromatherapy
                                                massage for two</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-water fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Unlimited access to sauna, steam
                                                &amp; hydrotherapy pool</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-egg-fried fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Healthy organic breakfast &amp;
                                                cold-pressed detox juices</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-check2-circle fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Doctor consultation &amp; customized
                                                wellness advice</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Right: Sidebar (Enters from Left) -->
                            <div class="col-lg-3" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">PACKAGE DEAL</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Package</h3>
                                        <p class="text-white-50 small mb-0">Rejuvenating getaway</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Package Price</span>
                                            <span class="fw-semibold text-dark">&#8377; 13,500.00</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes &amp; Fees (18%)</span>
                                            <span class="fw-semibold text-dark">&#8377; 2,430.00</span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; 15,930.00</span>
                                        </div>
                                        <a href="Booking.aspx?room=Spa%20Wellness%20Retreat&price=13500"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Package</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PACKAGE 3: Weekend Romantic Suite Getaway -->
                    <div class="package-offer-card-block" data-package-category="weekend" data-aos="fade-up">
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <span class="badge text-uppercase bg-warning text-dark fw-bold mb-2">COUPLES &amp;
                                    ROMANCE</span>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Weekend Romantic Suite Getaway</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-2 font-serif fst-italic">Chilled champagne, rose petal
                                    turndown, candlelight dinner &amp; luxury suite accommodation.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-heart-fill text-danger me-1"></i> Honeymoon &amp;
                                        Couples</span>
                                    <span><i class="bi bi-people text-dark me-1"></i> 2 Adults</span>
                                    <span><i class="bi bi-cup-straw text-dark me-1"></i> Candlelight Dinner</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Unforgettable Memories</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Left) -->
                            <div class="col-lg-5" data-aos="fade-right" data-aos-duration="1000">
                                <div class="room-gallery-frame">
                                    <img id="pkgImg_3" src="images/room-luxury-penthouse.jpg" alt="Romantic Getaway"
                                        style="height: 280px; object-fit: cover; width: 100%;"
                                        onclick="openImageLightbox('pkgImg_3', 'Weekend Romantic Suite Getaway')">
                                    <span class="photo-count-badge"><i class="bi bi-heart me-1"></i> Romantic
                                        Getaway</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('pkgImg_3', 'Weekend Romantic Suite Getaway')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                            <!-- Middle: Inclusions (Enters from Right) -->
                            <div class="col-lg-4" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Package Inclusions</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-cup-straw fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Chilled champagne bottle &amp;
                                                artisanal chocolate gift</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-stars fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Romantic rose petal turndown in
                                                luxury suite</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-lamp fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">Private poolside 4-course
                                                candlelight dinner for two</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-clock-history fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Guaranteed late checkout till 4:00
                                                PM on Sunday</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Right: Sidebar (Enters from Right) -->
                            <div class="col-lg-3" data-aos="fade-left" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">PACKAGE DEAL</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Package</h3>
                                        <p class="text-white-50 small mb-0">Romantic escape</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Package Price</span>
                                            <span class="fw-semibold text-dark">&#8377; 18,000.00</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes &amp; Fees (18%)</span>
                                            <span class="fw-semibold text-dark">&#8377; 3,240.00</span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; 21,240.00</span>
                                        </div>
                                        <a href="Booking.aspx?room=Weekend%20Romantic%20Getaway&price=18000"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Package</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- PACKAGE 4: Family Holiday & Heritage Explorer -->
                    <div class="package-offer-card-block" data-package-category="family" data-aos="fade-up">
                        <div class="row align-items-center mb-3" data-aos="fade-down" data-aos-duration="1000">
                            <div class="col-md-8">
                                <span class="badge text-uppercase bg-warning text-dark fw-bold mb-2">FAMILY
                                    RETREAT</span>
                                <h2 class="display-6 font-serif fw-bold text-navy mb-1 room-title-text welcome-title-anim">
                                    <span class="welcome-title-gold">Family Holiday &amp; Heritage Explorer</span>
                                </h2>
                                <p class="text-secondary fs-6 mb-2 font-serif fst-italic">Kids stay and dine free,
                                    curated city heritage tour &amp; connected luxury family room.</p>
                                <div class="d-flex align-items-center flex-wrap gap-4 text-secondary small fw-medium">
                                    <span><i class="bi bi-people-fill text-dark me-1"></i> Family Friendly</span>
                                    <span><i class="bi bi-person-hearts text-dark me-1"></i> 2 Adults + 2 Kids</span>
                                    <span><i class="bi bi-geo-alt text-dark me-1"></i> City Tour Included</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end d-none d-md-block">
                                <span class="font-serif fst-italic text-secondary fs-6">Family Moments Together</span>
                                <div
                                    style="height: 2.5px; width: 70px; background: var(--bn-theme-gold); margin-left: auto; margin-top: 4px; border-radius: 2px;">
                                </div>
                            </div>
                        </div>

                        <div class="row g-4">
                            <!-- Left: Photo Gallery (Enters from Right) -->
                            <div class="col-lg-5" data-aos="fade-left" data-aos-duration="1000">
                                <div class="room-gallery-frame">
                                    <img id="pkgImg_4" src="images/room-mini-family.jpg" alt="Family Package"
                                        style="height: 280px; object-fit: cover; width: 100%;"
                                        onclick="openImageLightbox('pkgImg_4', 'Family Holiday &amp; Heritage Explorer')">
                                    <span class="photo-count-badge"><i class="bi bi-people me-1"></i> Family
                                        Retreat</span>
                                    <button type="button" class="gallery-zoom-btn"
                                        onclick="openImageLightbox('pkgImg_4', 'Family Holiday &amp; Heritage Explorer')"
                                        title="View larger image"><i class="bi bi-eye-fill"></i></button>
                                </div>
                            </div>
                            <!-- Middle: Inclusions (Enters from Left) -->
                            <div class="col-lg-4" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="100">
                                <div class="room-highlights-box">
                                    <h4 class="font-serif fw-bold text-navy mb-3 fs-5">Package Inclusions</h4>
                                    <div class="row g-3">
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-person-check fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Kids under 12 stay and dine
                                                complimentary</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-car-front fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Private chauffeured city heritage
                                                sightseeing tour</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-controller fs-4"></i>
                                            </div>
                                            <div class="small text-secondary lh-sm">Access to kids game lounge &amp;
                                                heated splash pool</div>
                                        </div>
                                        <div class="col-12 d-flex align-items-center gap-3">
                                            <div class="highlight-icon-wrapper"><i class="bi bi-percent fs-4"></i></div>
                                            <div class="small text-secondary lh-sm">20% savings on spa therapies and
                                                laundry service</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Right: Sidebar (Enters from Left) -->
                            <div class="col-lg-3" data-aos="fade-right" data-aos-duration="1000" data-aos-delay="200">
                                <div class="your-stay-card">
                                    <div class="your-stay-header">
                                        <span class="text-uppercase text-warning fw-bold d-block mb-1"
                                            style="font-size: 0.68rem; letter-spacing: 1.5px;">PACKAGE DEAL</span>
                                        <h3 class="font-serif fw-bold text-white mb-1 fs-4">Book Package</h3>
                                        <p class="text-white-50 small mb-0">All-inclusive family trip</p>
                                    </div>
                                    <div class="your-stay-body">
                                        <div class="d-flex justify-content-between text-secondary small mb-2">
                                            <span>Package Price</span>
                                            <span class="fw-semibold text-dark">&#8377; 14,500.00</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-secondary small mb-3">
                                            <span>Taxes &amp; Fees (18%)</span>
                                            <span class="fw-semibold text-dark">&#8377; 2,610.00</span>
                                        </div>
                                        <hr class="my-2 border-secondary-subtle">
                                        <div class="d-flex justify-content-between text-dark fw-bold mb-3">
                                            <span class="fs-6">Total Amount</span>
                                            <span class="fs-5 text-navy">&#8377; 17,110.00</span>
                                        </div>
                                        <a href="Booking.aspx?room=Family%20Holiday%20Explorer&price=14500"
                                            class="btn-book-gold sidebar-book-btn">
                                            <span>Book Package</span> <i class="bi bi-arrow-right ms-1"></i>
                                        </a>
                                        <div class="d-flex justify-content-between align-items-center mt-3 pt-2 text-muted"
                                            style="font-size: 0.7rem;">
                                            <span><i class="bi bi-shield-lock text-success me-1"></i> 256-Bit SSL</span>
                                            <span><i class="bi bi-check-circle-fill text-success me-1"></i> Best
                                                Rate</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- End of viewOffersPackagesSection -->

            </div>
        </div>

        <!-- ==========================================
         LUXURY IMAGE ENLARGE LIGHTBOX MODAL
         ========================================== -->
        <div id="luxuryImageLightbox" class="bn-lightbox-modal" style="display: none;"
            onclick="closeImageLightbox(event)">
            <div class="bn-lightbox-content" onclick="event.stopPropagation()">
                <button type="button" class="bn-lightbox-close" onclick="closeImageLightbox(event)"
                    title="Close Preview (Esc)">
                    <i class="bi bi-x-lg"></i>
                </button>
                <div class="bn-lightbox-image-wrapper">
                    <img id="bnLightboxImg" src="" alt="Enlarged Room Preview">
                </div>
                <div class="bn-lightbox-caption text-center pt-3">
                    <h4 id="bnLightboxTitle" class="font-serif fw-bold text-white mb-1 fs-5">Room Preview</h4>
                    <span class="text-warning small"><i class="bi bi-patch-check-fill me-1"></i> 5-Star Luxury
                        Accommodations</span>
                </div>
            </div>
        </div>

        <!-- External Book Now JS Script with cache buster -->
        <script src="js/book-now.js?v=4.0"></script>

        <!-- Inline Tab, Filter & Lightbox Handler for Instant Responsiveness -->
        <script>
            function openImageLightbox(target, title) {
                var src = '';
                if (typeof target === 'string') {
                    var el = document.getElementById(target);
                    if (el && el.src) {
                        src = el.src;
                    } else {
                        src = target;
                    }
                } else if (target && target.src) {
                    src = target.src;
                }

                var modal = document.getElementById('luxuryImageLightbox');
                var modalImg = document.getElementById('bnLightboxImg');
                var modalTitle = document.getElementById('bnLightboxTitle');

                if (modal && modalImg) {
                    modalImg.src = src;
                    if (modalTitle) {
                        modalTitle.textContent = title || 'Luxury Room View';
                    }
                    modal.style.display = 'flex';
                    document.body.style.overflow = 'hidden';
                }
            }
            window.openImageLightbox = openImageLightbox;

            function closeImageLightbox(e) {
                if (e && e.target && e.target.closest && e.target.closest('.bn-lightbox-content') && !e.target.closest('.bn-lightbox-close')) {
                    return;
                }
                var modal = document.getElementById('luxuryImageLightbox');
                if (modal) {
                    modal.style.display = 'none';
                    document.body.style.overflow = '';
                }
            }
            window.closeImageLightbox = closeImageLightbox;

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' || e.keyCode === 27) {
                    closeImageLightbox();
                }
            });

            document.addEventListener('DOMContentLoaded', function () {
                var btnRates = document.getElementById('tabBtnRates');
                var btnOffers = document.getElementById('tabBtnOffers');

                if (btnRates) {
                    btnRates.onclick = function (e) {
                        if (e) e.preventDefault();
                        if (window.switchRatesTab) window.switchRatesTab('rates', this);
                    };
                }

                if (btnOffers) {
                    btnOffers.onclick = function (e) {
                        if (e) e.preventDefault();
                        if (window.switchRatesTab) window.switchRatesTab('offers', this);
                    };
                }

                document.querySelectorAll('.bn-filter-pill').forEach(function (pill) {
                    pill.onclick = function (e) {
                        if (e) e.preventDefault();
                        var cat = this.getAttribute('data-filter') || 'all';
                        if (window.filterBookNowRooms) window.filterBookNowRooms(cat, this);
                    };
                });

                document.querySelectorAll('.bn-package-pill').forEach(function (pill) {
                    pill.onclick = function (e) {
                        if (e) e.preventDefault();
                        var cat = this.getAttribute('data-package-filter') || 'all';
                        if (window.filterPackages) window.filterPackages(cat, this);
                    };
                });
            });
        </script>
    </asp:Content>