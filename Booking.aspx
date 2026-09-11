<%@ Page Title="Online Reservation | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <!-- Page Title -->
        <section class="page-title text-center" data-aos="fade-down" data-aos-duration="1000">
            <div class="container relative-z">
                <div class="page-title-badge mb-3 d-inline-flex align-items-center gap-2" data-aos="zoom-in" data-aos-delay="100">
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
                    Reserve your imperial suite in seconds with our 2-step online reservation system and instant confirmation.
                </p>

                <nav aria-label="breadcrumb" class="mt-4" data-aos="fade-up" data-aos-delay="400">
                    <ol class="breadcrumb page-title-breadcrumb justify-content-center mb-0">
                        <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house-door-fill me-1"></i> Home</a></li>
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

                            <div class="d-flex flex-column flex-sm-row align-items-start align-items-sm-center justify-content-between gap-2 pb-3 mb-4 border-bottom border-dark border-opacity-10">
                                <div>
                                    <span class="text-uppercase fw-bold small text-gold tracking-wider"><i class="bi bi-shield-check me-1"></i> Royal Concierge Service</span>
                                    <h2 class="booking-form-header-title mb-0">Online Reservation</h2>
                                </div>
                                <span class="badge bg-dark text-gold border border-gold px-3 py-2 small align-self-start align-self-sm-auto text-nowrap">Step 1 of 2</span>
                            </div>

                            <form id="onlineBookingForm" onsubmit="handleOnlineBookingSubmit(event)">

                                <!-- 1. Booking Details -->
                                <h4 class="booking-form-section-heading">
                                    <i class="bi bi-calendar-check me-2 text-gold"></i> Booking Details
                                </h4>

                                <div class="row g-3 mb-3">
                                    <!-- Arrival Date -->
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Arrival Date *</label>
                                        <input type="date" class="form-control" id="arrivalDate" required>
                                    </div>

                                    <!-- Departure Date -->
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Departure Date *</label>
                                        <input type="date" class="form-control" id="departureDate" required>
                                    </div>

                                    <!-- Total Guests -->
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Total Guests *</label>
                                        <select class="form-select" id="totalGuests" required>
                                            <option value="" disabled selected>Choose guests</option>
                                            <option value="1">1 Guest</option>
                                            <option value="2">2 Guests</option>
                                            <option value="3">3 Guests</option>
                                            <option value="4">4 Guests</option>
                                            <option value="5+">5+ Guests (Family / Group)</option>
                                        </select>
                                    </div>

                                    <!-- Total Rooms -->
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Total Rooms *</label>
                                        <select class="form-select" id="totalRooms" required>
                                            <option value="" disabled selected>Choose rooms</option>
                                            <option value="1">1 Room</option>
                                            <option value="2">2 Rooms</option>
                                            <option value="3">3 Rooms</option>
                                            <option value="4+">4+ Rooms</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Room Preferences -->
                                <div class="row g-3 mb-3">
                                    <div class="col-md-12 mb-2">
                                        <label class="form-label">Room Preferences (Accommodation Type)</label>
                                        <select class="form-select" id="bookingRoomSelect" onchange="updateBookingSummary()">
                                            <option value="8500" selected>No preference (Default: Executive Business Suite - &#8377; 8,500/night)</option>
                                            <option value="6800">Garden View Deluxe Room (&#8377; 6,800/night)</option>
                                            <option value="11500">Family Comfort Suite (&#8377; 11,500/night)</option>
                                            <option value="14999">Classic Double Luxury Room (&#8377; 14,999/night)</option>
                                            <option value="19999">Superior King Royal Room (&#8377; 19,999/night)</option>
                                            <option value="95999">Royal Penthouse Haven (&#8377; 95,999/night)</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Additional Requirements -->
                                <div class="mb-4">
                                    <label class="form-label">Additional Requirements</label>
                                    <textarea class="form-control" id="additionalReqs" rows="4" placeholder="Please specify any special arrangements or preferences..."></textarea>
                                </div>

                                <!-- 2. Guest Information -->
                                <h4 class="booking-form-section-heading">
                                    <i class="bi bi-person-badge me-2 text-gold"></i> Guest Information
                                </h4>

                                <div class="row g-3 mb-4">
                                    <div class="col-md-12 mb-2">
                                        <label class="form-label">Primary Guest Name *</label>
                                        <input type="text" class="form-control" id="guestName" placeholder="Enter your full name" required>
                                    </div>

                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Email Address *</label>
                                        <input type="email" class="form-control" id="guestEmail" placeholder="name@example.com" required>
                                    </div>

                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Contact Number *</label>
                                        <input type="tel" class="form-control" id="guestContact" placeholder="+91 98765 43210" required>
                                    </div>
                                </div>

                                <!-- Submit Button -->
                                <div class="mt-4 pt-2">
                                    <button type="submit" class="btn btn-submit-reservation">
                                        <i class="bi bi-send-fill me-2"></i> Submit Reservation Request
                                    </button>
                                </div>

                            </form>

                        </div>
                    </div>

                    <!-- Right Column: Hotel Building Image, Why Choose Card & Trust Badges (col-lg-5) -->
                    <div class="col-lg-5" data-aos="fade-left" data-aos-delay="300">
                        
                        <!-- 1. Small Hotel Building Image -->
                        <div class="hotel-building-img-box mb-4">
                            <img src="images/indian-palace-hero.jpg" loading="lazy" alt="Grand Imperial Hotel Building" class="img-fluid">
                            <span class="img-caption-badge"><i class="bi bi-building me-1"></i> Grand Imperial Hotel</span>
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