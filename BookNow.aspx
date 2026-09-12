<%@ Page Title="Book Now - Room Rates & Packages | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="BookNow.aspx.cs" Inherits="BookNow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- ==========================================
         1. COMPACT HERO BANNER & BREADCRUMB
         ========================================== -->
    <section class="booking-hero-strip py-3" style="background: linear-gradient(135deg, #2a1401 0%, #442305 100%); color: #ffffff;">
        <div class="container-fluid px-4 px-lg-5">
            <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2">
                <div class="d-flex align-items-center gap-3">
                    <span class="badge bg-gold-subtle text-warning-dark text-uppercase px-2 py-1 small fw-bold">
                        <i class="bi bi-stars me-1"></i> Best Rate Guaranteed
                    </span>
                    <h1 class="font-serif fw-bold h4 mb-0 text-white">Select Your Room &amp; Rates</h1>
                </div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0 small">
                        <li class="breadcrumb-item"><a href="index.aspx" class="text-white-50 text-decoration-none">Home</a></li>
                        <li class="breadcrumb-item"><a href="Room.aspx" class="text-white-50 text-decoration-none">Rooms</a></li>
                        <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Book Now</li>
                    </ol>
                </nav>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. STAY SCHEDULE MODIFIER BAR
         ========================================== -->
    <section class="py-3 border-bottom shadow-sm" style="background-color: #ffffff;">
        <div class="container-fluid px-4 px-lg-5">
            <div class="row g-3 align-items-center">
                <div class="col-lg-3 col-md-6">
                    <label class="form-label text-muted small fw-bold mb-1"><i class="bi bi-calendar-check text-gold me-1"></i> CHECK-IN</label>
                    <input type="date" class="form-control form-control-sm fw-semibold" id="arrivalDate" onchange="handleScheduleChange()">
                </div>
                <div class="col-lg-3 col-md-6">
                    <label class="form-label text-muted small fw-bold mb-1"><i class="bi bi-calendar-x text-gold me-1"></i> CHECK-OUT</label>
                    <input type="date" class="form-control form-control-sm fw-semibold" id="departureDate" onchange="handleScheduleChange()">
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label text-muted small fw-bold mb-1"><i class="bi bi-person text-gold me-1"></i> ADULTS</label>
                    <select class="form-select form-select-sm fw-semibold" id="bookingAdults" onchange="handleScheduleChange()">
                        <option value="1">1 Adult</option>
                        <option value="2" selected>2 Adults</option>
                        <option value="3">3 Adults</option>
                        <option value="4">4 Adults</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label text-muted small fw-bold mb-1"><i class="bi bi-people text-gold me-1"></i> CHILDREN</label>
                    <select class="form-select form-select-sm fw-semibold" id="bookingChildren" onchange="handleScheduleChange()">
                        <option value="0" selected>0 Children</option>
                        <option value="1">1 Child</option>
                        <option value="2">2 Children</option>
                    </select>
                </div>
                <div class="col-lg-2 col-md-4">
                    <label class="form-label text-muted small fw-bold mb-1"><i class="bi bi-door-open text-gold me-1"></i> ROOMS</label>
                    <select class="form-select form-select-sm fw-semibold" id="totalRooms" onchange="handleScheduleChange()">
                        <option value="1" selected>1 Room</option>
                        <option value="2">2 Rooms</option>
                        <option value="3">3 Rooms</option>
                    </select>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         3. TAJ HOTELS RATES & PACKAGES CONTAINER
         ========================================== -->
    <section class="py-4" style="background-color: #faf8f5;">
        <div class="container-fluid px-4 px-lg-5">

            <!-- Best Rate Guarantee Strip -->
            <div class="taj-best-rate-strip d-flex flex-column flex-sm-row align-items-center justify-content-between p-2 px-3 mb-4 rounded-3 border" style="background: #ffffff; border-color: rgba(184, 142, 104, 0.3) !important;">
                <div class="d-flex align-items-center gap-2 text-dark small">
                    <i class="bi bi-patch-check-fill text-warning fs-5"></i>
                    <span><strong>Best Rate Guaranteed</strong> When You Book Direct With Us.</span>
                    <a href="javascript:void(0)" onclick="openPolicyModal('best-rate')" class="text-decoration-underline fw-bold text-dark">Learn More</a>
                </div>
                <div class="small text-muted mt-2 mt-sm-0">
                    <i class="bi bi-lock-fill text-gold me-1"></i> Instant Confirmation &bull; No Hidden Booking Fees
                </div>
            </div>

            <!-- Tabs & Taxes Control Bar -->
            <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-3">
                
                <!-- Room Rates vs Offers & Packages Tabs -->
                <div class="taj-main-tabs d-inline-flex gap-2">
                    <button type="button" class="taj-tab-btn active" id="tabRoomRates" onclick="switchRatesView('rates')">
                        ROOM RATES
                    </button>
                    <button type="button" class="taj-tab-btn" id="tabOffersPackages" onclick="switchRatesView('offers')">
                        OFFERS &amp; PACKAGES
                    </button>
                </div>

                <!-- Show with taxes and fees Checkbox -->
                <div class="form-check form-switch mb-0">
                    <input class="form-check-input" type="checkbox" role="switch" id="showTaxesToggle" onchange="toggleTaxesDisplay(this.checked)">
                    <label class="form-check-label fw-semibold text-dark small" for="showTaxesToggle">
                        Show with taxes and fees
                    </label>
                </div>

            </div>

            <!-- "Rooms for your search" Bar & Filter Pills -->
            <div class="mb-4">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                    <h5 class="font-serif fw-bold mb-0" style="color: #442305;">Rooms for your search</h5>
                    <span class="text-muted small" id="searchContextSummary">Showing 6 available luxury rooms &bull; 2 Adults</span>
                </div>

                <!-- Quick Category Filter Pills -->
                <div class="taj-filter-pills-wrap d-flex flex-wrap gap-2 pt-1" id="tajFilterPills">
                    <button type="button" class="taj-filter-pill active" onclick="filterRoomCards('all', this)">All Rooms</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('superior-twin', this)">Superior Room Twin Bed</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('superior-king', this)">Superior Room King Bed</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('deluxe-king', this)">Deluxe Room King Bed</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('deluxe-twin', this)">Deluxe Room Twin Bed</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('luxury-suite', this)">Luxury Suite</button>
                    <button type="button" class="taj-filter-pill" onclick="filterRoomCards('presidential', this)">Presidential Suite</button>
                </div>
            </div>

            <!-- MAIN 2-COLUMN GRID (Left: Room Cards | Right: Sticky YOUR STAY) -->
            <div class="row g-4 align-items-start">

                <!-- ==========================================
                     LEFT COLUMN: TAJ ROOM & RATE CARDS (col-lg-8)
                     ========================================== -->
                <div class="col-lg-8" id="roomCardsContainer">

                    <!-- ROOM 1: SUPERIOR ROOM TWIN BED -->
                    <div class="taj-room-card mb-4" data-category="superior-twin" id="room-superior-twin" data-aos="fade-up">
                        <div class="p-3 pb-0">
                            <h3 class="taj-room-title mb-1">SUPERIOR ROOM TWIN BED</h3>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-classic-double.jpg" alt="Superior Room Twin Bed" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/about-img3.jpg" alt="Superior Room Details" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 37 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 3 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-layout-split me-1 text-gold"></i> Twin Beds</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Superior+Room+Twin+Bed&price=8500&img=images/room-classic-double.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Breakfast Inclusive Rate -->
                                    <div class="taj-rate-plan-box mb-3" id="plan-superior-twin-breakfast">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Breakfast Inclusive Rate</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Inclusive of buffet breakfast at designated dining venue</li>
                                                    <li>Enjoy hands-on pottery, Pool Table &amp; games</li>
                                                    <li>One plus One on Drinks during Happy Hours (4pm - 8pm)</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('breakfast-incl')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="7225">&#8377; 7,225 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="8500">&#8377; 8,500 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="superior-twin-b"
                                                            data-room-name="Superior Room Twin Bed" 
                                                            data-plan-name="Breakfast Inclusive Rate" 
                                                            data-price="8500" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Plan 2: Room Only Rate -->
                                    <div class="taj-rate-plan-box" id="plan-superior-twin-ro">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Room Only / Best Available Rate</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Complimentary high-speed Wi-Fi &amp; valet parking</li>
                                                    <li>Access to heated pool &amp; luxury fitness centre</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('room-only')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="6375">&#8377; 6,375 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="7500">&#8377; 7,500 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="superior-twin-ro"
                                                            data-room-name="Superior Room Twin Bed" 
                                                            data-plan-name="Room Only Rate" 
                                                            data-price="7500" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM 2: SUPERIOR ROOM KING BED -->
                    <div class="taj-room-card mb-4" data-category="superior-king" id="room-superior-king" data-aos="fade-up">
                        <div class="p-3 pb-0 d-flex flex-wrap align-items-center justify-content-between">
                            <h3 class="taj-room-title mb-1">SUPERIOR ROOM KING BED</h3>
                            <span class="text-danger small fw-bold"><i class="bi bi-fire me-1"></i> Only Few Rooms Available</span>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-superior-king.jpg" alt="Superior Room King Bed" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/about-img2.jpg" alt="Superior Room Details" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 37 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 3 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-square me-1 text-gold"></i> King Bed</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Superior+Room+King+Bed&price=9000&img=images/room-superior-king.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Breakfast Inclusive Rate -->
                                    <div class="taj-rate-plan-box mb-3" id="plan-superior-king-breakfast">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Breakfast Inclusive Rate</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Gourmet breakfast spread at The Emperor's Pavilion</li>
                                                    <li>Poolside sunbed access &amp; afternoon tea privilege</li>
                                                    <li>Complimentary late checkout up to 1:00 PM</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('breakfast-incl')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="7650">&#8377; 7,650 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="9000">&#8377; 9,000 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="superior-king-b"
                                                            data-room-name="Superior Room King Bed" 
                                                            data-plan-name="Breakfast Inclusive Rate" 
                                                            data-price="9000" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Plan 2: Royal Staycation Experience -->
                                    <div class="taj-rate-plan-box" id="plan-superior-king-staycation">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Royal Staycation &amp; Dining</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Daily breakfast &amp; dinner at The Royal Zafran</li>
                                                    <li>20% savings on Spa therapies &amp; salon treatments</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('staycation')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="10200">&#8377; 10,200 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="12000">&#8377; 12,000 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="superior-king-stay"
                                                            data-room-name="Superior Room King Bed" 
                                                            data-plan-name="Royal Staycation &amp; Dining" 
                                                            data-price="12000" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM 3: DELUXE ROOM KING BED -->
                    <div class="taj-room-card mb-4" data-category="deluxe-king" id="room-deluxe-king" data-aos="fade-up">
                        <div class="p-3 pb-0">
                            <h3 class="taj-room-title mb-1">DELUXE ROOM KING BED</h3>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-mini-garden.jpg" alt="Deluxe Room King Bed" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/room-ocean-view.jpg" alt="Deluxe Room Details" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 42 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 3 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-square me-1 text-gold"></i> King Bed</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Deluxe+Room+King+Bed&price=11000&img=images/room-mini-garden.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Breakfast Inclusive Rate -->
                                    <div class="taj-rate-plan-box" id="plan-deluxe-king-breakfast">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Breakfast Inclusive Rate</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Buffet breakfast at designated palace restaurant</li>
                                                    <li>Private balcony with garden &amp; skyline views</li>
                                                    <li>Evening turn-down service with artisanal chocolates</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('breakfast-incl')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="9350">&#8377; 9,350 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="11000">&#8377; 11,000 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="deluxe-king-b"
                                                            data-room-name="Deluxe Room King Bed" 
                                                            data-plan-name="Breakfast Inclusive Rate" 
                                                            data-price="11000" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM 4: DELUXE ROOM TWIN BED -->
                    <div class="taj-room-card mb-4" data-category="deluxe-twin" id="room-deluxe-twin" data-aos="fade-up">
                        <div class="p-3 pb-0">
                            <h3 class="taj-room-title mb-1">DELUXE ROOM TWIN BED</h3>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-mini-family.jpg" alt="Deluxe Room Twin Bed" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/room-mini-business.jpg" alt="Deluxe Room Details" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 42 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 3 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-layout-split me-1 text-gold"></i> Twin Beds</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Deluxe+Room+Twin+Bed&price=11500&img=images/room-mini-family.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Breakfast Inclusive Rate -->
                                    <div class="taj-rate-plan-box" id="plan-deluxe-twin-breakfast">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Breakfast Inclusive Rate</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>Buffet breakfast at designated dining venue</li>
                                                    <li>Complimentary high-speed Wi-Fi and digital newspapers</li>
                                                    <li>Access to tennis &amp; squash courts</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('breakfast-incl')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="9775">&#8377; 9,775 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="11500">&#8377; 11,500 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="deluxe-twin-b"
                                                            data-room-name="Deluxe Room Twin Bed" 
                                                            data-plan-name="Breakfast Inclusive Rate" 
                                                            data-price="11500" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM 5: LUXURY SUITE -->
                    <div class="taj-room-card mb-4" data-category="luxury-suite" id="room-luxury-suite" data-aos="fade-up">
                        <div class="p-3 pb-0">
                            <h3 class="taj-room-title mb-1">LUXURY SUITE (EXECUTIVE SUITE)</h3>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-mini-business.jpg" alt="Luxury Suite" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/room-featured-presidential.jpg" alt="Suite Lounge" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 58 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 3 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-star-fill text-gold"></i> Club Lounge</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Luxury+Executive+Suite&price=16000&img=images/room-mini-business.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Club Lounge & Breakfast -->
                                    <div class="taj-rate-plan-box" id="plan-luxury-suite-club">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Executive Club Lounge &amp; Breakfast</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>All-day access to Chanakya Executive Club Lounge</li>
                                                    <li>Cocktails &amp; canapés during evening happy hours (6pm - 8pm)</li>
                                                    <li>One-way luxury sedan airport transfer</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('club-lounge')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="13600">&#8377; 13,600 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="16000">&#8377; 16,000 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="luxury-suite-club"
                                                            data-room-name="Luxury Suite" 
                                                            data-plan-name="Executive Club Lounge &amp; Breakfast" 
                                                            data-price="16000" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ROOM 6: GRAND PRESIDENTIAL PALACE SUITE -->
                    <div class="taj-room-card mb-4" data-category="presidential" id="room-presidential" data-aos="fade-up">
                        <div class="p-3 pb-0 d-flex flex-wrap align-items-center justify-content-between">
                            <h3 class="taj-room-title mb-1">GRAND PRESIDENTIAL PALACE SUITE</h3>
                            <span class="badge bg-gold-subtle text-warning-dark text-uppercase px-2 py-1 small fw-bold">VIP Imperial Haven</span>
                        </div>

                        <div class="p-3 pt-2">
                            <div class="row g-3">
                                <!-- Image Gallery Preview -->
                                <div class="col-md-5">
                                    <div class="taj-gallery-preview position-relative rounded-3 overflow-hidden">
                                        <div class="d-flex h-100">
                                            <div class="w-70 h-100">
                                                <img src="images/room-featured-presidential.jpg" alt="Presidential Suite" class="w-100 h-100 object-fit-cover">
                                            </div>
                                            <div class="w-30 h-100 ps-1">
                                                <img src="images/room-luxury-penthouse.jpg" alt="Penthouse View" class="w-100 h-100 object-fit-cover">
                                            </div>
                                        </div>
                                        <span class="taj-photo-badge"><i class="bi bi-images me-1"></i> 2 Photos</span>
                                    </div>

                                    <!-- Specs Row -->
                                    <div class="d-flex flex-wrap gap-2 text-muted small mt-2">
                                        <span><i class="bi bi-arrows-fullscreen me-1 text-gold"></i> 220 sq m</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-people me-1 text-gold"></i> Up to 6 guests</span>
                                        <span>&bull;</span>
                                        <span><i class="bi bi-gem me-1 text-gold"></i> 24h Butler</span>
                                    </div>
                                    <div class="mt-2">
                                        <a href="RoomDetails.aspx?title=Grand+Presidential+Suite&price=95999&img=images/room-featured-presidential.jpg" target="_blank" class="taj-room-details-link">
                                            ROOM DETAILS
                                        </a>
                                    </div>
                                </div>

                                <!-- Nested Rate Plans -->
                                <div class="col-md-7">
                                    
                                    <!-- Plan 1: Imperial Royal Inclusions -->
                                    <div class="taj-rate-plan-box" id="plan-presidential-royal">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-sm-7">
                                                <h5 class="taj-plan-name mb-2">Imperial Butler &amp; Royal Inclusions</h5>
                                                <ul class="taj-inclusions-list mb-2">
                                                    <li>24-hour dedicated royal butler service &amp; private chef</li>
                                                    <li>Chauffeur-driven luxury Rolls-Royce airport transfers</li>
                                                    <li>All dining &amp; unlimited spa privileges inclusive</li>
                                                </ul>
                                                <a href="javascript:void(0)" onclick="openPolicyModal('royal-butler')" class="taj-rate-details-link">Rate Details</a>
                                            </div>
                                            <div class="col-sm-5 border-start-sm text-end">
                                                <div class="taj-member-rate-box mb-2">
                                                    <span class="taj-tier-label text-uppercase">MEMBER RATE</span>
                                                    <div class="taj-tier-price" data-base-price="81599">&#8377; 81,599 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-member-join" onclick="openPolicyModal('member-rate')">LOGIN / JOIN</button>
                                                </div>
                                                <div class="taj-standard-rate-box">
                                                    <span class="taj-tier-label text-uppercase">STANDARD RATE</span>
                                                    <div class="taj-tier-price" data-base-price="95999">&#8377; 95,999 <small>/ Night</small></div>
                                                    <button type="button" class="btn btn-taj-select" 
                                                            data-room-id="presidential-royal"
                                                            data-room-name="Grand Presidential Palace Suite" 
                                                            data-plan-name="Imperial Butler &amp; Royal Inclusions" 
                                                            data-price="95999" 
                                                            onclick="handleRateSelectToggle(this)">
                                                        SELECT
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- ==========================================
                     RIGHT COLUMN: STICKY "YOUR STAY" SIDEBAR (col-lg-4)
                     ========================================== -->
                <div class="col-lg-4 sticky-top" style="top: 90px; z-index: 10;">
                    
                    <div class="taj-your-stay-card" id="yourStaySidebar" data-aos="fade-left">
                        
                        <!-- Header -->
                        <h4 class="taj-your-stay-header mb-3">YOUR STAY</h4>

                        <!-- Collapsible Room 1 Accordion -->
                        <div class="taj-stay-accordion-item mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <strong class="text-dark small" id="stayRoomLabel">Room 1 : 2 Adults</strong>
                                <i class="bi bi-chevron-up text-muted small" id="stayAccordionIcon"></i>
                            </div>
                            <div id="staySelectedRoomTitle" class="text-muted small">Not selected</div>
                            <div id="stayDatesDuration" class="small text-muted mt-1 d-none"></div>
                        </div>

                        <!-- Price Breakdown -->
                        <div class="taj-stay-price-breakdown pt-3 border-top">
                            
                            <div class="d-flex justify-content-between align-items-center mb-2 small">
                                <span class="text-muted">Price <i class="bi bi-chevron-down ms-1" style="font-size: 0.7rem;"></i></span>
                                <strong class="text-dark" id="stayBasePrice">&#8377; 0.00</strong>
                            </div>

                            <div class="d-flex justify-content-between align-items-center mb-3 small">
                                <span class="text-muted">Taxes and Fees <i class="bi bi-chevron-down ms-1" style="font-size: 0.7rem;"></i></span>
                                <strong class="text-dark" id="stayTaxesPrice">&#8377; 0.00</strong>
                            </div>

                            <div class="taj-stay-total-row pt-2 border-top d-flex justify-content-between align-items-center mb-4">
                                <span class="font-serif fw-bold" style="color: #442305;">Total Amount</span>
                                <strong class="fs-5 font-serif" style="color: #442305;" id="stayTotalPrice">&#8377; 0.00</strong>
                            </div>

                        </div>

                        <!-- CTA Actions -->
                        <div id="stayPromptNotSelected" class="text-center p-3 text-muted small rounded-3 mb-2" style="background: #faf8f5; border: 1px dashed rgba(184, 142, 104, 0.4);">
                            <i class="bi bi-hand-index-thumb text-gold d-block mb-1 fs-5"></i>
                            Select a room rate above to proceed with your luxury reservation.
                        </div>

                        <button type="button" id="btnProceedBooking" class="btn btn-taj-proceed w-100 py-3 d-none fw-bold text-uppercase" onclick="openGuestDetailsModal()">
                            <i class="bi bi-check-circle me-1"></i> Proceed To Guest Details
                        </button>

                        <button type="button" id="btnUncheckRoomSidebar" class="btn btn-outline-danger btn-sm w-100 mt-2 d-none fw-semibold rounded-pill" onclick="uncheckSelectedRatePlan()">
                            <i class="bi bi-x-circle me-1"></i> Uncheck Selected Room
                        </button>

                        <div class="taj-secure-lock-note text-center mt-3 text-muted small">
                            <i class="bi bi-shield-lock-fill text-gold me-1"></i> 256-Bit SSL Encrypted &bull; Best Rate Guarantee
                        </div>

                    </div>

                </div>

            </div>

        </div>
    </section>

    <!-- ==========================================
         4. GUEST DETAILS & CONFIRMATION MODAL
         ========================================== -->
    <div class="modal fade" id="guestDetailsModal" tabindex="-1" aria-labelledby="guestDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                
                <div class="modal-header text-white p-4" style="background: linear-gradient(135deg, #2a1401 0%, #442305 100%);">
                    <div>
                        <span class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold mb-1">Final Step &bull; Guest Information</span>
                        <h4 class="modal-title font-serif fw-bold text-white mb-0" id="guestDetailsModalLabel">Complete Your Luxury Stay</h4>
                    </div>
                    <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-4">
                    
                    <!-- Selected Room & Price Summary Card -->
                    <div class="bg-light p-3 rounded-3 border mb-4">
                        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-2">
                            <div>
                                <span class="text-muted text-uppercase small" style="font-size: 0.72rem;">Selected Room &amp; Plan</span>
                                <h6 class="font-serif fw-bold mb-0 text-dark" id="modalSelectedRoomSummary">Superior Room Twin Bed</h6>
                                <small class="text-muted" id="modalDatesSummary">Dates: Selected Dates &bull; 2 Adults</small>
                            </div>
                            <div class="text-sm-end">
                                <span class="text-muted text-uppercase small" style="font-size: 0.72rem;">Total Payable</span>
                                <h5 class="fw-bold mb-0" style="color: #B88E68;" id="modalTotalSummary">&#8377; 10,030</h5>
                            </div>
                        </div>
                    </div>

                    <!-- Guest Details Form -->
                    <form id="tajGuestDetailsForm" onsubmit="handleTajReservationSubmit(event)">
                        <div class="row g-3 mb-3">
                            <div class="col-md-12">
                                <label class="form-label fw-semibold"><i class="bi bi-person me-1 text-gold"></i> Full Name (as per Govt ID) *</label>
                                <input type="text" class="form-control" id="modalGuestName" placeholder="e.g. Vikramaditya Roy" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold"><i class="bi bi-envelope me-1 text-gold"></i> Email Address *</label>
                                <input type="email" class="form-control" id="modalGuestEmail" placeholder="vikram@example.com" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold"><i class="bi bi-telephone me-1 text-gold"></i> Mobile Number *</label>
                                <input type="tel" class="form-control" id="modalGuestPhone" placeholder="+91 98765 43210" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-semibold"><i class="bi bi-chat-left-text me-1 text-gold"></i> Special Requests</label>
                                <textarea class="form-control" id="modalGuestRequests" rows="2" placeholder="e.g. Quiet floor, early check-in, dietary preferences, airport pickup..."></textarea>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label small text-muted"><i class="bi bi-stars text-warning me-1"></i> NeuPass / Loyalty Member ID (Optional)</label>
                                <input type="text" class="form-control form-control-sm text-uppercase" id="modalNeuId" placeholder="NEU-892182">
                            </div>
                        </div>

                        <!-- Terms Checkbox -->
                        <div class="form-check p-3 rounded-3 mb-4" style="background: #faf8f5; border: 1px solid #ede8e1;">
                            <input class="form-check-input ms-0 me-2" type="checkbox" id="modalTermsCheckbox" required>
                            <label class="form-check-label fw-semibold small text-dark" for="modalTermsCheckbox">
                                I agree to the <a href="javascript:void(0)" onclick="openPolicyModal('terms')" class="text-decoration-underline text-dark">Terms &amp; Conditions</a> and understand the 48-hour free cancellation policy. *
                            </label>
                        </div>

                        <div class="d-flex gap-2 justify-content-end">
                            <button type="button" class="btn btn-outline-dark px-4 py-2" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-navbar-theme px-4 py-2 fw-bold text-uppercase">
                                <i class="bi bi-shield-check me-1"></i> Confirm Booking
                            </button>
                        </div>
                    </form>

                    <!-- Instant Confirmation Pass Voucher (Revealed upon submit) -->
                    <div id="tajConfirmationVoucherPass" class="d-none text-center p-4 rounded-3 border" style="background: #faf8f5; border-color: #B88E68 !important;">
                        <span class="badge bg-success text-white px-3 py-2 text-uppercase fw-bold rounded-pill mb-3">
                            <i class="bi bi-check-circle-fill me-1"></i> Stay Confirmed &amp; Reserved
                        </span>
                        <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">Royal Reservation Confirmed</h3>
                        <p class="text-muted small mb-4">We look forward to welcoming you to Grand Imperial Hotel. Your official stay voucher has been emailed.</p>

                        <div class="bg-white p-3 rounded-3 border text-start mb-4 shadow-sm">
                            <div class="row g-2 small">
                                <div class="col-6">
                                    <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Reservation Ref #</span>
                                    <strong class="fs-6" style="color: #B88E68;" id="voucherConfRef">HM-RES-789210</strong>
                                </div>
                                <div class="col-6">
                                    <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Guest Name</span>
                                    <strong class="fs-6 text-dark" id="voucherGuestName">Mr. Guest</strong>
                                </div>
                                <div class="col-12 mt-2 pt-2 border-top">
                                    <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Room &amp; Rate Plan</span>
                                    <strong class="text-dark" id="voucherRoomPlan">Superior Room Twin Bed (Breakfast Inclusive Rate)</strong>
                                </div>
                                <div class="col-6 mt-2">
                                    <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Stay Dates</span>
                                    <strong class="text-dark" id="voucherDates">20 Sep - 22 Sep (2 Nights)</strong>
                                </div>
                                <div class="col-6 mt-2">
                                    <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Total Amount</span>
                                    <strong class="fs-6" style="color: #442305;" id="voucherTotal">&#8377; 10,030</strong>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn btn-outline-dark px-4 py-2 small fw-bold" onclick="window.print()">
                                <i class="bi bi-printer me-1"></i> Print Voucher Pass
                            </button>
                            <button type="button" class="btn btn-navbar-theme px-4 py-2 small fw-bold" data-bs-dismiss="modal">
                                Close Window
                            </button>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>

    <!-- Policy / Info Modal -->
    <div class="modal fade" id="tajPolicyInfoModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content rounded-4 border-0 shadow">
                <div class="modal-header border-bottom">
                    <h5 class="font-serif fw-bold mb-0" id="policyModalTitle">Rate Details &amp; Policies</h5>
                    <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4" id="policyModalBody">
                    <p class="small text-muted mb-0">Policy details loading...</p>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-navbar-theme btn-sm px-4 fw-bold" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Book Now Javascript Engine -->
    <script src="js/book-now.js"></script>

</asp:Content>
