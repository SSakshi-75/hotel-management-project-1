<%@ Page Title="Hotel Management | Luxury Hotel & Resort System" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

            <!-- ==========================================
             FULL WIDTH & FULL HEIGHT HERO SECTION WITH REAL IMG
             ========================================== -->
            <section id="booking-hero" class="hero-full-width-wrapper position-relative w-100 overflow-hidden">

                <!-- Real Hero Image Element (Full width & height) -->
                <div class="hero-img-overlay-wrapper">
                    <img src="images/hero-bg-luxury.jpg" alt="Luxury Hotel Room" class="hero-banner-img img-fluid">
                    <div class="hero-img-gradient-overlay"></div>
                </div>

                <div
                    class="container-fluid px-4 px-lg-5 position-relative z-2 py-5 min-vh-85 d-flex align-items-center">
                    <div class="row align-items-center g-4 g-lg-5 w-100 mx-auto">

                        <!-- Left Column: Side Animated Title & Custom Explore Rooms Button (From Left Side) -->
                        <div class="col-lg-7 text-dark hero-text-container animate-slide-left" data-aos="fade-right"
                            data-aos-duration="1200">
                            <!-- 5 Luxury Animated Stars & Glass Badge -->
                            <div class="mb-3">
                                <div class="glass-luxury-badge">
                                    <div class="welcome-stars-wrap mb-0 me-2">
                                        <i class="fa-solid fa-star welcome-star" style="font-size: 0.95rem;"></i>
                                        <i class="fa-solid fa-star welcome-star" style="font-size: 0.95rem;"></i>
                                        <i class="fa-solid fa-star welcome-star"
                                            style="font-size: 1.1rem; color: #9A724E;"></i>
                                        <i class="fa-solid fa-star welcome-star" style="font-size: 0.95rem;"></i>
                                        <i class="fa-solid fa-star welcome-star" style="font-size: 0.95rem;"></i>
                                    </div>
                                    <span class="badge-text">5-Star Luxury Experience</span>
                                </div>
                            </div>

                            <h1 class="hero-title display-3 fw-bold mb-4 text-dark animated-hero-title">
                                Hotel Management Your Gateway To <span
                                    class="text-gradient-gold hero-animated-word">Serenity.</span>
                            </h1>

                            <div class="mt-4 pt-2 hero-btn-animate">
                                <a href="Rooms.aspx" class="btn-explore-custom">
                                    Explore Rooms
                                </a>
                            </div>
                        </div>

                        <!-- Right Column: Professional Luxury Check Availability Card (From Right Side) -->
                        <div class="col-lg-5 animate-slide-right" data-aos="fade-left" data-aos-duration="1200">
                            <div class="card booking-hero-card border-0 p-4 p-md-5 rounded-4 bg-white shadow-luxury">

                                <!-- Card Header with logo matching badge -->
                                <div class="text-center mb-4">
                                    <span
                                        class="badge bg-gold-subtle text-warning-dark rounded-pill px-3 py-2 text-uppercase fw-semibold letter-spacing-1 small mb-2 d-inline-block">
                                        <i class="bi bi-shield-check me-1"></i> Direct Reservation
                                    </span>
                                    <h2 class="card-title text-dark font-serif fw-bold mb-1 fs-2">Check Availability
                                    </h2>
                                    <div class="mx-auto bg-warning mt-2"
                                        style="width: 45px; height: 2px; border-radius: 2px; opacity: 0.9;"></div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-uppercase text-dark fw-bold small letter-spacing-1">
                                        <i class="bi bi-calendar-event text-warning me-1"></i> CHECK-IN DATE
                                    </label>
                                    <div class="input-group luxury-input-group">
                                        <input type="date"
                                            class="form-control border-0 bg-light text-dark fs-6 rounded-3 px-3 fw-semibold"
                                            id="checkInDate" name="checkInDate" required />
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-uppercase text-dark fw-bold small letter-spacing-1">
                                        <i class="bi bi-calendar-check text-warning me-1"></i> CHECK-OUT DATE
                                    </label>
                                    <div class="input-group luxury-input-group">
                                        <input type="date"
                                            class="form-control border-0 bg-light text-dark fs-6 rounded-3 px-3 fw-semibold"
                                            id="checkOutDate" name="checkOutDate" required />
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-uppercase text-dark fw-bold small letter-spacing-1">
                                        <i class="bi bi-door-open text-warning me-1"></i> SELECT SUITE CATEGORY
                                    </label>
                                    <div class="input-group luxury-input-group">
                                        <select
                                            class="form-select border-0 bg-light text-dark fs-6 rounded-3 px-3 fw-semibold"
                                            id="roomTypeSelect" name="roomTypeSelect">
                                            <option value="1">1 Room (Deluxe King Suite)</option>
                                            <option value="2">2 Rooms (Executive Ocean Suite)</option>
                                            <option value="3">3 Rooms (Presidential Villa)</option>
                                            <option value="4">4+ Rooms (Luxury Family Villa)</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label text-uppercase text-dark fw-bold small letter-spacing-1">
                                        <i class="bi bi-people text-warning me-1"></i> GUESTS & CHILDREN
                                    </label>
                                    <div class="input-group luxury-input-group">
                                        <select
                                            class="form-select border-0 bg-light text-dark fs-6 rounded-3 px-3 fw-semibold"
                                            id="guestsSelect" name="guestsSelect">
                                            <option value="1">1 Adult (Single Guest)</option>
                                            <option value="2" selected>2 Adults (Recommended)</option>
                                            <option value="3">2 Adults, 1 Child</option>
                                            <option value="4">3 Adults, 2 Children</option>
                                            <option value="5">Family & Group (5+ Guests)</option>
                                        </select>
                                    </div>
                                </div>

                                <button type="button"
                                    class="btn btn-luxury-check w-100 py-3 rounded-3 fw-bold text-uppercase shadow-sm"
                                    onclick="alert('Checking Room Availability... Directing to Reservation System.');">
                                    <span>CHECK ROOM AVAILABILITY</span> <i
                                        class="bi bi-arrow-right-circle-fill ms-2 fs-5"></i>
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

            <!-- ==========================================
             LUXURY STATS & HIGHLIGHTS BAR
             ========================================== -->
            <section class="stats-section py-5">
                <div class="container px-4 px-lg-5">
                    <div class="stats-bar-card p-4 p-md-5 rounded-4">
                        <div class="row g-4 text-center align-items-center">

                            <!-- Stat 1 -->
                            <div class="col-6 col-md-3 border-end-md">
                                <div class="stat-item p-2" data-aos="fade-up" data-aos-delay="100">
                                    <div class="stat-icon-wrapper mb-2">
                                        <i class="bi bi-building fs-3 text-champagne-gold"></i>
                                    </div>
                                    <h2 class="stat-number display-6 fw-bold mb-1">150+</h2>
                                    <p class="stat-label text-uppercase mb-0">Luxury Rooms & Suites</p>
                                </div>
                            </div>

                            <!-- Stat 2 -->
                            <div class="col-6 col-md-3 border-end-md">
                                <div class="stat-item p-2" data-aos="fade-up" data-aos-delay="200">
                                    <div class="stat-icon-wrapper mb-2">
                                        <i class="bi bi-star-fill fs-3 text-champagne-gold"></i>
                                    </div>
                                    <h2 class="stat-number display-6 fw-bold mb-1">4.9 / 5</h2>
                                    <p class="stat-label text-uppercase mb-0">Guest Rating</p>
                                </div>
                            </div>

                            <!-- Stat 3 -->
                            <div class="col-6 col-md-3 border-end-md">
                                <div class="stat-item p-2" data-aos="fade-up" data-aos-delay="300">
                                    <div class="stat-icon-wrapper mb-2">
                                        <i class="bi bi-cup-hot-fill fs-3 text-champagne-gold"></i>
                                    </div>
                                    <h2 class="stat-number display-6 fw-bold mb-1">3</h2>
                                    <p class="stat-label text-uppercase mb-0">Gourmet Dining</p>
                                </div>
                            </div>

                            <!-- Stat 4 -->
                            <div class="col-6 col-md-3">
                                <div class="stat-item p-2" data-aos="fade-up" data-aos-delay="400">
                                    <div class="stat-icon-wrapper mb-2">
                                        <i class="bi bi-headset fs-3 text-champagne-gold"></i>
                                    </div>
                                    <h2 class="stat-number display-6 fw-bold mb-1">24 / 7</h2>
                                    <p class="stat-label text-uppercase mb-0">Concierge Service</p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </section>

            <!-- ==========================================
             WELCOME / ABOUT SECTION (MATCHING USER SCREENSHOT)
             ========================================== -->
            <section id="about-us" class="py-5 bg-white">
                <div class="container-fluid px-4 px-lg-5 py-5" data-aos="fade-up">

                    <!-- Centered Animated Title -->
                    <div class="text-center mb-4 mb-lg-5" data-aos="fade-down" data-aos-duration="1000">
                        <div>
                            <span class="welcome-subtitle-anim">
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                                Experience True Tranquility
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                            </span>
                        </div>
                        <h2 class="welcome-title-anim mb-2">
                            Hotel Management: <span class="welcome-title-gold">Your Gateway</span><br
                                class="d-none d-md-inline"> <span class="welcome-title-gold">To Serenity</span>
                        </h2>
                        <div class="welcome-decor-line">
                            <div class="line"></div>
                            <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                            <div class="line right"></div>
                        </div>
                    </div>

                    <!-- 2-Column Photo & Text Grid -->
                    <div class="row align-items-center g-4 g-lg-5">

                        <!-- Left Column: Text (From Left) + Pool Image (From Left) -->
                        <div class="col-lg-6">
                            <!-- Welcome Text (Slides from Left) -->
                            <div class="pe-lg-4 mb-4" data-aos="fade-right" data-aos-duration="1100">
                                <p class="welcome-desc-text mb-4">
                                    Welcome to Hotel Management, where comfort meets tranquility. Nestled in the heart
                                    of a bustling city, our hotel offers a peaceful retreat for both business and
                                    leisure travelers. With modern amenities, and a warm, inviting atmosphere, we strive
                                    to make your stay with us.
                                </p>
                                <a href="About.aspx" class="btn-welcome-about">
                                    <span>Read About Us</span>
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                            <!-- Left Image (Slides from Left) -->
                            <div class="mt-4 pt-2" data-aos="fade-right" data-aos-duration="1200" data-aos-delay="200">
                                <div class="welcome-img-card welcome-img-primary shadow-sm">
                                    <img src="images/about-img1.jpg" alt="Resort Pool" class="img-fluid w-100 h-100">
                                </div>
                            </div>
                        </div>

                        <!-- Right Column: 2 Stacked Images (Slide from Right) -->
                        <div class="col-lg-6">
                            <!-- Right Image 1 (Slides from Right) -->
                            <div class="mb-4" data-aos="fade-left" data-aos-duration="1100" data-aos-delay="150">
                                <div class="welcome-img-card welcome-img-secondary shadow-sm">
                                    <img src="images/about-img2.jpg" alt="Luxury Suite" class="img-fluid w-100 h-100">
                                </div>
                            </div>
                            <!-- Right Image 2 (Slides from Right) -->
                            <div data-aos="fade-left" data-aos-duration="1100" data-aos-delay="300">
                                <div class="welcome-img-card welcome-img-secondary shadow-sm">
                                    <img src="images/about-img3.jpg" alt="Hotel Experience"
                                        class="img-fluid w-100 h-100">
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

            <!-- ==========================================
             LUXURY ROOMS SECTION (EXACT SCREENSHOT LAYOUT)
             ========================================== -->
            <section id="rooms-showcase" class="py-5 bg-white">
                <div class="container-fluid px-4 px-lg-5 py-4">

                    <!-- Section Header matching Home Page Luxury Style -->
                    <div class="text-center mb-4 mb-lg-5" data-aos="fade-down" data-aos-duration="1000">
                        <div>
                            <span class="welcome-subtitle-anim">
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                                Exclusive Living Spaces
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                            </span>
                        </div>
                        <h2 class="welcome-title-anim mb-2">
                            Luxury Rooms &amp; <span class="welcome-title-gold">Suites Collection</span>
                        </h2>
                        <div class="welcome-decor-line">
                            <div class="line"></div>
                            <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                            <div class="line right"></div>
                        </div>
                    </div>

                    <!-- 2-Column Grid (Left: Featured Suite | Right: 3 Stacked Rooms) -->
                    <div class="row g-4 g-lg-5 align-items-stretch">

                        <!-- Left Column: Featured Grand Presidential Suite Card -->
                        <div class="col-lg-7" data-aos="fade-right" data-aos-duration="1000">
                            <div class="featured-suite-card">

                                <!-- Top Image with Badges -->
                                <div class="featured-suite-img-wrap">
                                    <img src="images/room-featured-presidential.jpg" alt="Grand Presidential Suite"
                                        class="img-fluid">
                                    <span class="badge-presidential-pill">PRESIDENTIAL</span>
                                    <div class="suite-overlay-pills">
                                        <span class="suite-overlay-pill">
                                            <i class="bi bi-people-fill"></i> 6 Guests
                                        </span>
                                        <span class="suite-overlay-pill">
                                            <i class="bi bi-house-door-fill"></i> 180m²
                                        </span>
                                        <span class="suite-overlay-pill">
                                            <i class="bi bi-geo-alt-fill"></i> Top Floor
                                        </span>
                                    </div>
                                </div>

                                <!-- Body -->
                                <div class="featured-suite-body">
                                    <div class="suite-title-row">
                                        <h3 class="suite-title">Grand Presidential Suite</h3>
                                        <div class="suite-rating-box">
                                            <div class="suite-rating-stars">
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                                <i class="fa-solid fa-star"></i>
                                            </div>
                                            <div class="suite-rating-text">5.0 Excellence</div>
                                        </div>
                                    </div>

                                    <p class="suite-desc">
                                        Indulge in unmatched opulence with panoramic city skyline views, private jacuzzi
                                        terrace, master king bedroom, handcrafted marble interiors, and 24/7 dedicated
                                        butler service.
                                    </p>

                                    <div class="suite-amenities-row">
                                        <span class="suite-amenity-item">
                                            <i class="bi bi-wifi"></i> Premium WiFi
                                        </span>
                                        <span class="suite-amenity-item">
                                            <i class="bi bi-tv"></i> Smart TV
                                        </span>
                                        <span class="suite-amenity-item">
                                            <i class="bi bi-cup-hot"></i> Coffee Bar
                                        </span>
                                        <span class="suite-amenity-item">
                                            <i class="bi bi-snow"></i> Climate Control
                                        </span>
                                    </div>

                                    <div class="suite-price-action-row">
                                        <div class="suite-price-wrap">
                                            <span class="currency">&#8377;</span>
                                            <span class="amount">18,500</span>
                                            <span class="period">/ night</span>
                                        </div>
                                        <a href="Rooms.aspx" class="btn btn-reserve-suite">
                                            <span>Reserve Suite</span>
                                            <i class="fa-solid fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Right Column: 3 Stacked Horizontal Room Cards (Staggered Animation) -->
                        <div class="col-lg-5 d-flex flex-column justify-content-between">

                            <!-- Mini Room 1: Executive Business Room -->
                            <div class="mini-room-card" data-aos="fade-left" data-aos-duration="800"
                                data-aos-delay="100">
                                <div class="mini-room-img-wrap">
                                    <img src="images/room-mini-business.jpg" alt="Executive Business Room">
                                </div>
                                <div class="mini-room-body">
                                    <div>
                                        <h4 class="mini-room-title">Executive Business Room</h4>
                                        <p class="mini-room-desc">
                                            Designed for modern business executives, featuring an ergonomic workstation,
                                            high-speed Wi-Fi, premium king bedding, and lounge access.
                                        </p>
                                        <div class="mini-room-tags">
                                            <span><i class="bi bi-briefcase"></i> Work Space</span>
                                            <span><i class="bi bi-building"></i> City Views</span>
                                        </div>
                                    </div>
                                    <div class="mini-room-footer">
                                        <div class="mini-room-price"><span class="currency">&#8377;</span>8,500 <small>/
                                                night</small></div>
                                        <a href="Rooms.aspx" class="btn btn-book-mini">
                                            <span>Book</span>
                                            <i class="fa-solid fa-arrow-right" style="font-size: 0.72rem;"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Mini Room 2: Garden View Deluxe -->
                            <div class="mini-room-card" data-aos="fade-left" data-aos-duration="800"
                                data-aos-delay="250">
                                <div class="mini-room-img-wrap">
                                    <img src="images/room-mini-garden.jpg" alt="Garden View Deluxe">
                                </div>
                                <div class="mini-room-body">
                                    <div>
                                        <h4 class="mini-room-title">Garden View Deluxe</h4>
                                        <p class="mini-room-desc">
                                            Surround yourself with tranquil tropical greenery, featuring a private sun
                                            terrace, soothing natural ambiance, and plush king bedding.
                                        </p>
                                        <div class="mini-room-tags">
                                            <span><i class="bi bi-tree"></i> Garden View</span>
                                            <span><i class="bi bi-door-open"></i> Private Terrace</span>
                                        </div>
                                    </div>
                                    <div class="mini-room-footer">
                                        <div class="mini-room-price"><span class="currency">&#8377;</span>6,800 <small>/
                                                night</small></div>
                                        <a href="Rooms.aspx" class="btn btn-book-mini">
                                            <span>Book</span>
                                            <i class="fa-solid fa-arrow-right" style="font-size: 0.72rem;"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>

                            <!-- Mini Room 3: Family Comfort Suite -->
                            <div class="mini-room-card" data-aos="fade-left" data-aos-duration="800"
                                data-aos-delay="400">
                                <div class="mini-room-img-wrap">
                                    <img src="images/room-mini-family.jpg" alt="Family Comfort Suite">
                                </div>
                                <div class="mini-room-body">
                                    <div>
                                        <h4 class="mini-room-title">Family Comfort Suite</h4>
                                        <p class="mini-room-desc">
                                            Spacious multi-room luxury suite perfect for family stays, equipped with a
                                            dedicated children's area, lounge space, and luxury bath amenities.
                                        </p>
                                        <div class="mini-room-tags">
                                            <span><i class="bi bi-people"></i> Family Space</span>
                                            <span><i class="bi bi-controller"></i> Kids Area</span>
                                        </div>
                                    </div>
                                    <div class="mini-room-footer">
                                        <div class="mini-room-price"><span class="currency">&#8377;</span>11,500
                                            <small>/ night</small></div>
                                        <a href="Rooms.aspx" class="btn btn-book-mini">
                                            <span>Book</span>
                                            <i class="fa-solid fa-arrow-right" style="font-size: 0.72rem;"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </section>

            <!-- ==========================================
             FEATURED ACCOMMODATIONS GRID SECTION (MATCHING SCREENSHOT)
             ========================================== -->
            <section id="accommodations-grid" class="accommodations-grid-section">
                <div class="container-fluid px-4 px-lg-5">

                    <div class="row g-4 justify-content-center">

                        <!-- Card 1: Classic Double -->
                        <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800"
                            data-aos-delay="100">
                            <div class="accommodations-card">
                                <div class="accommodations-card-img-wrap">
                                    <img src="images/room-classic-double.jpg" alt="Classic Double Room">
                                    <a href="Rooms.aspx" class="accommodations-card-overlay" title="Quick View Room">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                                <div class="accommodations-card-body">
                                    <div>
                                        <h3 class="accommodations-card-title">Classic Double</h3>
                                        <div class="accommodations-card-price">
                                            <span>&#8377;14,999</span><span class="period">/night</span>
                                        </div>
                                    </div>
                                    <div class="accommodations-card-icons">
                                        <i class="bi bi-wifi" title="High-Speed Wi-Fi"></i>
                                        <i class="bi bi-tv" title="Smart TV"></i>
                                        <i class="bi bi-telephone" title="Direct Phone"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 2: Superior King -->
                        <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800"
                            data-aos-delay="200">
                            <div class="accommodations-card">
                                <div class="accommodations-card-img-wrap">
                                    <img src="images/room-superior-king.jpg" alt="Superior King Room">
                                    <a href="Rooms.aspx" class="accommodations-card-overlay" title="Quick View Room">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                                <div class="accommodations-card-body">
                                    <div>
                                        <h3 class="accommodations-card-title">Superior King</h3>
                                        <div class="accommodations-card-price">
                                            <span>&#8377;19,999</span><span class="period">/night</span>
                                        </div>
                                    </div>
                                    <div class="accommodations-card-icons">
                                        <i class="bi bi-wifi" title="High-Speed Wi-Fi"></i>
                                        <i class="bi bi-cup-hot" title="Coffee Maker"></i>
                                        <i class="bi bi-snow" title="Air Conditioning"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 3: Premium Ocean View -->
                        <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800"
                            data-aos-delay="300">
                            <div class="accommodations-card">
                                <div class="accommodations-card-img-wrap">
                                    <img src="images/room-ocean-view.jpg" alt="Premium Ocean View Room">
                                    <a href="Rooms.aspx" class="accommodations-card-overlay" title="Quick View Room">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                                <div class="accommodations-card-body">
                                    <div>
                                        <h3 class="accommodations-card-title">Premium Ocean View</h3>
                                        <div class="accommodations-card-price">
                                            <span>&#8377;28,999</span><span class="period">/night</span>
                                        </div>
                                    </div>
                                    <div class="accommodations-card-icons">
                                        <i class="bi bi-water" title="Ocean View & Pool Access"></i>
                                        <i class="bi bi-door-open" title="Private Balcony"></i>
                                        <i class="bi bi-lightbulb" title="Ambient Lighting"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 4: Luxury Penthouse -->
                        <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800"
                            data-aos-delay="400">
                            <div class="accommodations-card">
                                <div class="accommodations-card-img-wrap">
                                    <img src="images/room-luxury-penthouse.jpg" alt="Luxury Penthouse Room">
                                    <a href="Rooms.aspx" class="accommodations-card-overlay" title="Quick View Room">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                </div>
                                <div class="accommodations-card-body">
                                    <div>
                                        <h3 class="accommodations-card-title">Luxury Penthouse</h3>
                                        <div class="accommodations-card-price">
                                            <span>&#8377;95,999</span><span class="period">/night</span>
                                        </div>
                                    </div>
                                    <div class="accommodations-card-icons">
                                        <i class="bi bi-star" title="5-Star Rating"></i>
                                        <i class="bi bi-house-door" title="Penthouse Suite"></i>
                                        <i class="bi bi-gem" title="VIP Amenities"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Bottom Link matching screenshot -->
                    <div class="text-center mt-5" data-aos="fade-up" data-aos-delay="500">
                        <a href="Rooms.aspx" class="btn-explore-accommodations">
                            <span>Explore All Accommodations</span>
                            <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>

                </div>
            </section>

            <!-- ==========================================
             TESTIMONIALS SECTION (MATCHING WEBSITE LUXURY THEME)
             ========================================== -->
            <section id="testimonials-grid" class="testimonials-section">
                <div class="container px-4 px-lg-5">

                    <!-- Section Header with Watermark & Luxury Website Styling -->
                    <div class="text-center mb-5 position-relative" data-aos="fade-down" data-aos-duration="1000">
                        <div class="testimonials-watermark">TESTIMONIALS</div>
                        <div class="mb-2">
                            <span class="welcome-subtitle-anim">
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                                Guest Experience &amp; Reviews
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                            </span>
                        </div>
                        <h2 class="welcome-title-anim mb-2">
                            What Our <span class="welcome-title-gold">Guests Say</span>
                        </h2>
                        <div class="welcome-decor-line">
                            <div class="line"></div>
                            <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                            <div class="line right"></div>
                        </div>
                        <p class="testimonials-subtitle mt-3">
                            Discover how our executive travelers and distinguished guests describe their unforgettable
                            stay, gourmet dining, and world-class hospitality.
                        </p>
                    </div>

                    <!-- 2x2 Grid of Testimonial Cards -->
                    <div class="row g-4">

                        <!-- Card 1: Rahul Singh -->
                        <div class="col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                            <div class="testimonial-card">
                                <div>
                                    <div class="testimonial-card-top">
                                        <span class="testimonial-quote-icon">
                                            <i class="bi bi-quote"></i>
                                        </span>
                                        <div class="testimonial-stars">
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                        </div>
                                    </div>
                                    <p class="testimonial-quote-text">
                                        Staying at Hotel Management was an exceptional luxury experience. The suite
                                        views, 24/7 concierge assistance, and world-class hospitality exceeded all
                                        expectations during our corporate executive stay.
                                    </p>
                                </div>
                                <div class="testimonial-author-row">
                                    <img src="images/testimonial-user1.jpg" alt="Rahul Singh"
                                        class="testimonial-avatar">
                                    <div>
                                        <h4 class="testimonial-author-name">Rahul Singh</h4>
                                        <p class="testimonial-author-role">Chief Executive Officer</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 2: Priya Singhania -->
                        <div class="col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                            <div class="testimonial-card">
                                <div>
                                    <div class="testimonial-card-top">
                                        <span class="testimonial-quote-icon">
                                            <i class="bi bi-quote"></i>
                                        </span>
                                        <div class="testimonial-stars">
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                        </div>
                                    </div>
                                    <p class="testimonial-quote-text">
                                        An oasis of true tranquility in the heart of the city! The fine gourmet dining
                                        and soothing spa treatments made our weekend getaway truly unforgettable. We
                                        will definitely return soon.
                                    </p>
                                </div>
                                <div class="testimonial-author-row">
                                    <img src="images/testimonial-user2.jpg" alt="Priya Singhania"
                                        class="testimonial-avatar">
                                    <div>
                                        <h4 class="testimonial-author-name">Priya Singhania</h4>
                                        <p class="testimonial-author-role">Marketing Director</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 3: Rajesh Sharma -->
                        <div class="col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                            <div class="testimonial-card">
                                <div>
                                    <div class="testimonial-card-top">
                                        <span class="testimonial-quote-icon">
                                            <i class="bi bi-quote"></i>
                                        </span>
                                        <div class="testimonial-stars">
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                        </div>
                                    </div>
                                    <p class="testimonial-quote-text">
                                        The attention to detail and personalized service here is unmatched. From the
                                        effortless booking process to the state-of-the-art suite amenities, every moment
                                        felt tailored to absolute perfection.
                                    </p>
                                </div>
                                <div class="testimonial-author-row">
                                    <img src="images/testimonial-user3.jpg" alt="Rajesh Sharma"
                                        class="testimonial-avatar">
                                    <div>
                                        <h4 class="testimonial-author-name">Rajesh Sharma</h4>
                                        <p class="testimonial-author-role">Product Manager</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Card 4: Ananya Verma -->
                        <div class="col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                            <div class="testimonial-card">
                                <div>
                                    <div class="testimonial-card-top">
                                        <span class="testimonial-quote-icon">
                                            <i class="bi bi-quote"></i>
                                        </span>
                                        <div class="testimonial-stars">
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                            <i class="fa-solid fa-star"></i>
                                        </div>
                                    </div>
                                    <p class="testimonial-quote-text">
                                        The interior architecture and aesthetic ambient lighting of the ocean view
                                        penthouse are breathtaking! Impeccable craftsmanship, plush bedding, and a
                                        serene atmosphere offering total relaxation.
                                    </p>
                                </div>
                                <div class="testimonial-author-row">
                                    <img src="images/testimonial-user4.jpg" alt="Ananya Verma"
                                        class="testimonial-avatar">
                                    <div>
                                        <h4 class="testimonial-author-name">Ananya Verma</h4>
                                        <p class="testimonial-author-role">Design Lead</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </section>

            <!-- ==========================================
             5-IMAGE LUXURY GALLERY SHOWCASE SECTION (INFINITE SCROLL & EYE LIGHTBOX)
             ========================================== -->
            <section id="gallery-showcase" class="gallery-showcase-section overflow-hidden">
                <div class="container-fluid px-0">

                    <!-- Continuous Horizontal Auto-Scrolling Track with Eye Lightbox Trigger -->
                    <div class="gallery-marquee-container mb-4 mb-md-5">
                        <div class="gallery-marquee-track">
                            <!-- Set 1 (Original 5 Images) -->
                            <div class="gallery-card-item">
                                <img src="images/gallery-1.jpg" alt="Luxury Hotel Suite Lounge">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-1.jpg" data-title="Luxury Hotel Suite Lounge"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-2.jpg" alt="Fine Dining Breakfast Service">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-2.jpg"
                                    data-title="Fine Dining Gourmet Breakfast Service" title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-3.jpg" alt="Sky Lounge Panoramic Bar">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-3.jpg"
                                    data-title="Sky Lounge &amp; Executive Panoramic Bar"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-4.jpg" alt="Night Courtyard Architecture">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-4.jpg"
                                    data-title="Illuminated Night Courtyard &amp; Royal Palace Architecture"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-5.jpg" alt="Infinity Pool Villa Resort">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-5.jpg"
                                    data-title="Infinity Heated Swimming Pool &amp; Luxury Villa Deck"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>

                            <!-- Set 2 (Duplicated 5 Images for Seamless Infinite Loop) -->
                            <div class="gallery-card-item">
                                <img src="images/gallery-1.jpg" alt="Luxury Hotel Suite Lounge">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-1.jpg" data-title="Luxury Hotel Suite Lounge"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-2.jpg" alt="Fine Dining Breakfast Service">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-2.jpg"
                                    data-title="Fine Dining Gourmet Breakfast Service" title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-3.jpg" alt="Sky Lounge Panoramic Bar">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-3.jpg"
                                    data-title="Sky Lounge &amp; Executive Panoramic Bar"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-4.jpg" alt="Night Courtyard Architecture">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-4.jpg"
                                    data-title="Illuminated Night Courtyard &amp; Royal Palace Architecture"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                            <div class="gallery-card-item">
                                <img src="images/gallery-5.jpg" alt="Infinity Pool Villa Resort">
                                <a href="javascript:void(0);" class="gallery-card-overlay gallery-lightbox-trigger"
                                    data-img-src="images/gallery-5.jpg"
                                    data-title="Infinity Heated Swimming Pool &amp; Luxury Villa Deck"
                                    title="Click to View Full Size">
                                    <i class="bi bi-eye"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Centered Pill Button matching website primary gold/brown theme -->
                    <div class="text-center" data-aos="fade-up" data-aos-duration="700">
                        <a href="Services.aspx" class="btn btn-discover-gallery">
                            <i class="bi bi-briefcase"></i> Discover Our Full Gallery
                        </a>
                    </div>

                </div>
            </section>

    <!-- Gallery Lightbox Modal (Matching Website Theme) -->
    <div class="modal fade" id="galleryLightboxModal" tabindex="-1" aria-labelledby="galleryLightboxModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content bg-transparent border-0">
                <div class="modal-body p-0 text-center position-relative">
                    <button type="button"
                        class="btn-close btn-close-white position-absolute top-0 end-0 m-3 z-3 shadow-sm"
                        data-bs-dismiss="modal" aria-label="Close"
                        style="background-color: rgba(68, 35, 5, 0.85); padding: 12px; border-radius: 50%; border: 1.5px solid #9A724E; opacity: 1;"></button>
                    <img id="galleryModalPreviewImg" src="" alt="Gallery Preview"
                        class="img-fluid rounded-4 shadow-luxury"
                        style="max-height: 82vh; width: auto; object-fit: contain; border: 2px solid #9A724E; box-shadow: 0 20px 50px rgba(0,0,0,0.6);">
                    <div id="galleryModalCaption"
                        class="text-white mt-3 fs-5 font-serif fw-bold text-center px-3 py-2 rounded-3 d-inline-block"
                        style="background: rgba(44, 23, 5, 0.85); border: 1px solid rgba(154, 114, 78, 0.4); backdrop-filter: blur(4px);">
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>