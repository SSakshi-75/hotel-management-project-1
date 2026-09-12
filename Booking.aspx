<%@ Page Title="Online Reservation | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <!-- Page Title -->
        <section class="page-title text-center" data-aos="fade-down" data-aos-duration="1000">
            <div class="container relative-z">
                <div class="page-title-badge mb-3 d-inline-flex align-items-center gap-2" data-aos="zoom-in"
                    data-aos-delay="100">
                    <i class="bi bi-shield-check text-gold"></i>
                    <span>Royal Reservation Concierge</span>
                    <i class="bi bi-stars text-gold"></i>
                </div>

                <h1 class="page-title-heading" data-aos="fade-up" data-aos-delay="200">
                    Book Your Luxury Stay
                </h1>

                <div class="page-title-divider" data-aos="fade-up" data-aos-delay="300">
                    <span class="divider-line"></span>
                    <span class="divider-diamond">◆</span>
                    <span class="divider-line"></span>
                </div>

                <p class="page-title-subtitle" data-aos="fade-up" data-aos-delay="350">
                    Reserve your imperial suite in seconds with our 2-step online reservation system and instant
                    confirmation.
                </p>

                <nav aria-label="breadcrumb" class="mt-4" data-aos="fade-up" data-aos-delay="400">
                    <ol class="breadcrumb page-title-breadcrumb justify-content-center mb-0">
                        <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house-door-fill me-1"></i>
                                Home</a></li>
                        <li class="breadcrumb-item"><a href="Room.aspx">Rooms &amp; Suites</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Booking</li>
                    </ol>
                </nav>
            </div>
        </section>
        <!-- End Page Title -->

        <!-- Booking Section -->
        <section id="booking-section" class="booking-section-wrapper">
            <div class="container-fluid px-4 px-lg-5">
                <div class="row g-4">

                    <!-- Left Column: Reservation Form (Reduced Width col-lg-7) -->
                    <div class="col-lg-7" data-aos="fade-right" data-aos-delay="200">
                        <div class="booking-form-card">

                            <div
                                class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2 pb-3 mb-4 border-bottom border-dark border-opacity-10">
                                <div>
                                    <span class="text-uppercase fw-bold small text-gold tracking-wider"><i
                                            class="bi bi-shield-check me-1"></i> Royal Concierge Service</span>
                                    <h2 class="booking-form-header-title mb-0">Online Reservation</h2>
                                </div>
                                <span
                                    class="badge bg-dark text-gold border border-gold px-3 py-2 small align-self-start align-self-sm-auto text-nowrap">6-Step
                                    Reservation</span>
                            </div>

                            <!-- Promotional Offer Applied Banner -->
                            <div id="bookingOfferAppliedBanner" class="p-3 mb-4 rounded-3 border d-none"
                                style="background-color: #faf8f5; border-color: #B88E68 !important;">
                                <div
                                    class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2">
                                    <div class="d-flex align-items-center gap-3">
                                        <i class="bi bi-gift-fill text-warning fs-3"></i>
                                        <div>
                                            <span
                                                class="badge bg-gold-subtle text-warning-dark text-uppercase px-2 py-1 mb-1 small">Special
                                                Offer Active</span>
                                            <h5 class="mb-0 fw-bold font-serif" style="color: #442305;"
                                                id="bookingOfferTitle">Special Offer</h5>
                                        </div>
                                    </div>
                                    <span class="badge bg-dark text-gold border border-gold px-3 py-2 fs-6"
                                        id="bookingOfferRateBadge">&#8377;4,999 / night</span>
                                </div>
                            </div>

                            <form id="onlineBookingForm" onsubmit="handleOnlineBookingSubmit(event)">

                                <!-- 1. Stay Details -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">1</span>
                                        <h3 class="booking-step-title">Stay Details</h3>
                                    </div>
                                    <div class="row g-3">
                                        <!-- Check-in -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-calendar-event me-1 text-gold"></i> Check-in Date
                                                *</label>
                                            <input type="date" class="form-control" id="arrivalDate" required>
                                        </div>

                                        <!-- Check-out -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-calendar-check me-1 text-gold"></i> Check-out Date
                                                *</label>
                                            <input type="date" class="form-control" id="departureDate" required>
                                        </div>

                                        <!-- Adults -->
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-person-fill me-1 text-gold"></i> Adults *</label>
                                            <select class="form-select" id="bookingAdults" required
                                                onchange="updateBookingSummary()">
                                                <option value="1">1 Adult</option>
                                                <option value="2" selected>2 Adults</option>
                                                <option value="3">3 Adults</option>
                                                <option value="4">4+ Adults</option>
                                            </select>
                                        </div>

                                        <!-- Children -->
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-people me-1 text-gold"></i> Children</label>
                                            <select class="form-select" id="bookingChildren"
                                                onchange="updateBookingSummary()">
                                                <option value="0" selected>0 Children</option>
                                                <option value="1">1 Child</option>
                                                <option value="2">2 Children</option>
                                                <option value="3">3+ Children</option>
                                            </select>
                                        </div>

                                        <!-- Rooms -->
                                        <div class="col-md-4">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-door-open-fill me-1 text-gold"></i> Rooms *</label>
                                            <select class="form-select" id="totalRooms" required
                                                onchange="updateBookingSummary()">
                                                <option value="1" selected>1 Room</option>
                                                <option value="2">2 Rooms</option>
                                                <option value="3">3 Rooms</option>
                                                <option value="4+">4+ Rooms</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <!-- 2. Selected Room -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">2</span>
                                        <h3 class="booking-step-title">Selected Room</h3>
                                    </div>

                                    <!-- Hidden select for form compatibility -->
                                    <select class="form-select d-none" id="bookingRoomSelect"
                                        onchange="updateBookingSummary()">
                                        <option value="" disabled selected>Choose a room...</option>
                                        <option value="8500">Executive Business Suite (&#8377; 8,500/night)</option>
                                        <option value="6800">Garden View Deluxe Room (&#8377; 6,800/night)</option>
                                        <option value="11500">Family Comfort Suite (&#8377; 11,500/night)</option>
                                        <option value="14999">Classic Double Luxury Room (&#8377; 14,999/night)</option>
                                        <option value="19999">Superior King Royal Room (&#8377; 19,999/night)</option>
                                        <option value="95999">Royal Penthouse Haven (&#8377; 95,999/night)</option>
                                    </select>

                                    <div class="booking-room-pick-grid">
                                        <!-- Room 1 -->
                                        <div class="booking-room-pick-card" data-room="Executive Business Suite"
                                            data-price="8500"
                                            onclick="selectBookingRoomCard('Executive Business Suite', 8500, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-mini-business.jpg" alt="Executive Business Suite">
                                            </div>
                                            <div class="room-pick-title">Executive Business Suite</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 2 Guests
                                                &bull; 480 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;8,500 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Executive+Business+Suite&price=8500&img=images/room-mini-business.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Room 2 -->
                                        <div class="booking-room-pick-card" data-room="Garden View Deluxe Room"
                                            data-price="6800"
                                            onclick="selectBookingRoomCard('Garden View Deluxe Room', 6800, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-mini-garden.jpg" alt="Garden View Deluxe Room">
                                            </div>
                                            <div class="room-pick-title">Garden View Deluxe Room</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 2 Guests
                                                &bull; 420 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;6,800 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Garden+View+Deluxe+Room&price=6800&img=images/room-mini-garden.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Room 3 -->
                                        <div class="booking-room-pick-card" data-room="Family Comfort Suite"
                                            data-price="11500"
                                            onclick="selectBookingRoomCard('Family Comfort Suite', 11500, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-mini-family.jpg" alt="Family Comfort Suite">
                                            </div>
                                            <div class="room-pick-title">Family Comfort Suite</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 4 Guests
                                                &bull; 650 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;11,500 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Family+Comfort+Suite&price=11500&img=images/room-mini-family.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Room 4 -->
                                        <div class="booking-room-pick-card" data-room="Classic Double Luxury Room"
                                            data-price="14999"
                                            onclick="selectBookingRoomCard('Classic Double Luxury Room', 14999, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-classic-double.jpg"
                                                    alt="Classic Double Luxury Room">
                                            </div>
                                            <div class="room-pick-title">Classic Double Luxury Room</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 3 Guests
                                                &bull; 580 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;14,999 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Classic+Double+Luxury+Room&price=14999&img=images/room-classic-double.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Room 5 -->
                                        <div class="booking-room-pick-card" data-room="Superior King Royal Room"
                                            data-price="19999"
                                            onclick="selectBookingRoomCard('Superior King Royal Room', 19999, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-superior-king.jpg" alt="Superior King Royal Room">
                                            </div>
                                            <div class="room-pick-title">Superior King Royal Room</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 3 Guests
                                                &bull; 750 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;19,999 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Superior+King+Royal+Room&price=19999&img=images/room-superior-king.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>

                                        <!-- Room 6 -->
                                        <div class="booking-room-pick-card" data-room="Royal Penthouse Haven"
                                            data-price="95999"
                                            onclick="selectBookingRoomCard('Royal Penthouse Haven', 95999, this)">
                                            <div class="room-pick-check-icon"><i class="bi bi-check-lg"></i></div>
                                            <div class="room-pick-img-wrap position-relative">
                                                <img src="images/room-luxury-penthouse.jpg" alt="Royal Penthouse Haven">
                                            </div>
                                            <div class="room-pick-title">Royal Penthouse Haven</div>
                                            <div class="room-pick-meta"><i class="bi bi-people me-1"></i> Up to 6 Guests
                                                &bull; 2,400 sq ft</div>
                                            <div
                                                class="d-flex justify-content-between align-items-center mt-auto pt-2 border-top">
                                                <div class="room-pick-price">&#8377;95,999 <small>/ night</small></div>
                                                <a href="RoomDetails.aspx?title=Royal+Penthouse+Haven&price=95999&img=images/room-luxury-penthouse.jpg"
                                                    target="_blank"
                                                    class="btn btn-sm btn-outline-dark px-2 py-1 small fw-semibold"
                                                    onclick="event.stopPropagation();" title="View full room details">
                                                    <i class="bi bi-info-circle me-1"></i> View Details <i
                                                        class="bi bi-box-arrow-up-right ms-1"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 3. Guest Information -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">3</span>
                                        <h3 class="booking-step-title">Guest Information</h3>
                                    </div>
                                    <div class="row g-3">
                                        <!-- Name -->
                                        <div class="col-md-12">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-person me-1 text-gold"></i> Full Name *</label>
                                            <input type="text" class="form-control" id="guestName"
                                                placeholder="Full Name (as on Govt ID)" required>
                                        </div>

                                        <!-- Email -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-envelope me-1 text-gold"></i> Email Address *</label>
                                            <input type="email" class="form-control" id="guestEmail"
                                                placeholder="name@example.com" required>
                                        </div>

                                        <!-- Phone -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-telephone me-1 text-gold"></i> Phone Number *</label>
                                            <input type="tel" class="form-control" id="guestContact"
                                                placeholder="+91 98765 43210" required>
                                        </div>

                                        <!-- Special Request -->
                                        <div class="col-md-12">
                                            <label class="form-label fw-semibold"><i
                                                    class="bi bi-chat-left-text me-1 text-gold"></i> Special
                                                Request</label>
                                            <textarea class="form-control" id="additionalReqs" rows="3"
                                                placeholder="Please specify any special requests (e.g. high floor, airport transfer, quiet room, late check-in)..."></textarea>
                                        </div>

                                        <!-- NeuPass ID (Optional) -->
                                        <div class="col-md-12">
                                            <label class="form-label d-flex justify-content-between align-items-center">
                                                <span><i class="bi bi-stars text-warning me-1"></i> Tata Neu / NeuPass
                                                    Member ID (Optional)</span>
                                                <small class="text-gold">Earn NeuCoins on this stay</small>
                                            </label>
                                            <input type="text" class="form-control text-uppercase" id="guestNeuId"
                                                placeholder="Enter NeuPass ID (e.g. NEU-892182)">
                                        </div>
                                    </div>
                                </div>

                                <!-- 4. Booking Summary -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">4</span>
                                        <h3 class="booking-step-title">Booking Summary</h3>
                                    </div>

                                    <!-- Placeholder when stay details & room not yet chosen -->
                                    <div id="bookingSummaryEmptyState" class="text-center py-4 px-3"
                                        style="background: #faf8f5; border: 1.5px dashed rgba(184, 142, 104, 0.4); border-radius: 12px;">
                                        <i class="bi bi-calendar2-range text-gold fs-2 d-block mb-2"></i>
                                        <h5 class="fw-bold font-serif mb-1" style="color: #442305;">Booking Summary</h5>
                                        <p class="text-muted mb-0" style="font-size: 0.95rem;">
                                            Please select your stay details and room to see the booking summary.
                                        </p>
                                    </div>

                                    <!-- Populated with actual selected data -->
                                    <div class="booking-summary-table-box d-none" id="bookingSummaryTableBox">
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i
                                                    class="bi bi-door-closed me-2 text-gold"></i>Room</span>
                                            <strong id="sumTableRoom" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i
                                                    class="bi bi-calendar3 me-2 text-gold"></i>Dates</span>
                                            <strong id="sumTableDates" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i
                                                    class="bi bi-people me-2 text-gold"></i>Guests</span>
                                            <strong id="sumTableGuests" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i
                                                    class="bi bi-moon-stars me-2 text-gold"></i>Nights</span>
                                            <strong id="sumTableNights" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i class="bi bi-tag me-2 text-gold"></i>Room
                                                Price</span>
                                            <strong id="sumTablePrice" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row">
                                            <span class="text-muted"><i class="bi bi-percent me-2 text-gold"></i>GST
                                                (18%)</span>
                                            <strong id="sumTableTaxes" class="text-dark">--</strong>
                                        </div>
                                        <div class="summary-data-row total-row">
                                            <span><i class="bi bi-cash-stack me-2 text-gold"></i>Total</span>
                                            <span id="sumTableTotal" style="color: #442305;">--</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- 5. Terms & Conditions -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">5</span>
                                        <h3 class="booking-step-title">Terms &amp; Conditions</h3>
                                    </div>
                                    <div class="booking-terms-box">
                                        <ul>
                                            <li><strong>Standard Timings:</strong> Check-in begins at 2:00 PM and
                                                Check-out is scheduled at 12:00 PM local hotel time.</li>
                                            <li><strong>Flexible Cancellation:</strong> Free cancellation up to 48 hours
                                                prior to arrival. Cancellations made within 48 hours or failure to
                                                arrive will incur a 1-night charge.</li>
                                            <li><strong>Identification Policy:</strong> All staying adult guests must
                                                present a valid government-approved photo ID card (Aadhaar, Passport, or
                                                Driving License) upon check-in.</li>
                                            <li><strong>Special Requests:</strong> Requests are honored subject to
                                                availability at the time of check-in and are not guaranteed.</li>
                                        </ul>
                                    </div>
                                    <div class="form-check mt-3">
                                        <input class="form-check-input" type="checkbox" id="termsAgreement" required>
                                        <label class="form-check-label fw-semibold" for="termsAgreement"
                                            style="font-size: 0.92rem; color: #442305;">
                                            I have read, understood, and accept the Terms &amp; Conditions and
                                            Cancellation Policy *
                                        </label>
                                    </div>
                                </div>

                                <!-- 6. Confirm Booking -->
                                <div class="booking-step-container">
                                    <div class="booking-step-header">
                                        <span class="step-num-badge">6</span>
                                        <h3 class="booking-step-title">Confirm Booking</h3>
                                    </div>
                                    <div class="text-center pt-2">
                                        <button type="submit" id="btnConfirmBooking"
                                            class="btn btn-confirm-booking w-100 fs-5 py-3">
                                            <i class="bi bi-shield-check me-2"></i> Confirm Booking
                                        </button>
                                        <p class="text-muted small mt-2 mb-0">
                                            <i class="bi bi-lock-fill me-1 text-success"></i> Instant Confirmation
                                            &bull; No upfront deposit required &bull; Pay at Hotel
                                        </p>
                                    </div>
                                </div>

                            </form>

                            <!-- Booking Confirmation Voucher (Revealed upon submit) -->
                            <div id="bookingConfirmationPass" class="d-none pt-2">
                                <div class="text-center p-4 rounded-4 border shadow-sm"
                                    style="background: #faf8f5; border-color: #B88E68 !important;">
                                    <span
                                        class="badge bg-success text-white px-3 py-2 text-uppercase fw-bold rounded-pill mb-3">
                                        <i class="bi bi-check2-circle me-1"></i> Booking Confirmed &amp; Guaranteed
                                    </span>
                                    <h3 class="display-6 font-serif fw-bold" style="color: #442305;">Royal Stay
                                        Confirmed</h3>
                                    <p class="text-muted small mb-4">Thank you for choosing Grand Imperial Hotel. Your
                                        reservation pass has been dispatched to your email.</p>

                                    <div class="bg-white p-4 rounded-3 border text-start mb-4 shadow-sm">
                                        <div class="row g-3">
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Booking Reference #</small>
                                                <span class="fs-5 fw-bold" style="color: #B88E68;"
                                                    id="confRefNumber">HM-RES-789210</span>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Primary Guest</small>
                                                <strong class="text-dark fs-6" id="confGuestName">Mr. Guest</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Guest Contact</small>
                                                <strong class="text-dark fs-6" id="confGuestContact">+91 98765
                                                    43210</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Guest Email</small>
                                                <strong class="text-dark fs-6"
                                                    id="confGuestEmail">guest@example.com</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Selected Room</small>
                                                <strong class="text-dark fs-6" id="confRoomName">Executive Business
                                                    Suite</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Stay Schedule</small>
                                                <strong class="text-dark fs-6" id="confStaySchedule">Today &mdash;
                                                    Tomorrow (1 Night)</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Guests &amp; Rooms</small>
                                                <strong class="text-dark fs-6" id="confGuestsRooms">2 Adults, 0
                                                    Children, 1 Room</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Special Request</small>
                                                <strong class="text-dark fs-6" id="confSpecialRequest">None</strong>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Base Rate &amp; Taxes</small>
                                                <span class="text-dark fs-6" id="confBaseAndTax">&#8377;8,500 +
                                                    &#8377;1,530 GST</span>
                                            </div>
                                            <div class="col-sm-6">
                                                <small class="text-muted text-uppercase d-block"
                                                    style="font-size: 0.72rem;">Total Amount Payable at Check-in</small>
                                                <strong class="fs-4 fw-bold" style="color: #442305;"
                                                    id="confTotalAmount">&#8377;10,030</strong>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="d-flex gap-3 justify-content-center flex-wrap">
                                        <button type="button" class="btn btn-outline-dark px-4 py-2 fw-bold"
                                            onclick="window.print()">
                                            <i class="bi bi-printer me-1"></i> Print Reservation Pass
                                        </button>
                                        <a href="index.aspx" class="btn btn-navbar-theme px-4 py-2 fw-bold">
                                            <i class="bi bi-house me-1"></i> Return To Home
                                        </a>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- Right Column: Hotel Building Image, Why Choose Card & Trust Badges (col-lg-5) -->
                    <div class="col-lg-5" data-aos="fade-left" data-aos-delay="300">



                        <!-- 1. Small Hotel Building Image -->
                        <div class="hotel-building-img-box mb-4">
                            <img src="images/indian-palace-hero.jpg" loading="lazy" alt="Grand Imperial Hotel Building"
                                class="img-fluid">
                            <span class="img-caption-badge"><i class="bi bi-building me-1"></i> Grand Imperial
                                Hotel</span>
                        </div>

                        <!-- 2. "Why Choose Our Hotel" Card -->
                        <div class="why-choose-card mb-4">
                            <h4 class="why-choose-title">
                                <i class="bi bi-award-fill text-gold me-2"></i> Why Choose Our Hotel
                            </h4>
                            <ul class="why-choose-list">
                                <li>
                                    <div class="icon-box"><i class="bi bi-wifi"></i></div>
                                    <div>
                                        <strong>Premium Connectivity</strong>
                                        <p>High-speed internet access in all areas</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="icon-box"><i class="bi bi-clock-history"></i></div>
                                    <div>
                                        <strong>24/7 Service</strong>
                                        <p>Round-the-clock assistance and support</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="icon-box"><i class="bi bi-car-front-fill"></i></div>
                                    <div>
                                        <strong>Valet Parking</strong>
                                        <p>Complimentary parking with valet service</p>
                                    </div>
                                </li>
                                <li>
                                    <div class="icon-box"><i class="bi bi-heart-pulse-fill"></i></div>
                                    <div>
                                        <strong>Wellness Center</strong>
                                        <p>Full-service spa and fitness facilities</p>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <!-- 3. Space & External Trust Badges Row (Outside the Card) -->
                        <div class="trust-features-row">
                            <div class="trust-badge-item">
                                <i class="bi bi-shield-lock-fill"></i>
                                <span>Secure Booking</span>
                            </div>
                            <div class="trust-badge-item">
                                <i class="bi bi-arrow-repeat"></i>
                                <span>Flexible Cancellation</span>
                            </div>
                            <div class="trust-badge-item">
                                <i class="bi bi-headset"></i>
                                <span>24/7 Support</span>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </section>
        <!-- End Booking Section -->

        <!-- JS for Booking Page -->
        <script src="js/booking.js"></script>
    </asp:Content>