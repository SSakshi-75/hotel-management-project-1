<%@ Page Title="Hotel Management | Luxury Hotel & Resort System" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
             FULL WIDTH & FULL HEIGHT HERO SECTION WITH REAL IMG
             ========================================== -->
        <section id="booking-hero" class="hero-full-width-wrapper position-relative w-100 overflow-hidden">

            <!-- Real Hero Image Element (Full width & height) -->
            <div class="hero-img-overlay-wrapper">
                <img src="images/hero-bg-luxury.jpg" fetchpriority="high" decoding="async" alt="Luxury Hotel Room"
                    class="hero-banner-img img-fluid">
                <div class="hero-img-gradient-overlay"></div>
            </div>

            <div class="container-fluid px-4 px-lg-5 position-relative z-2 py-5 min-vh-85 d-flex align-items-center">
                <div class="row align-items-center g-4 g-lg-5 w-100 mx-auto">

                    <!-- Hero Title & Custom Explore Rooms Button -->
                    <div class="col-lg-10 col-xl-9 text-dark hero-text-container animate-slide-left" data-aos="fade-right"
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
                            <a href="Room.aspx" class="btn-explore-custom">
                                Explore Rooms
                            </a>
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
                                <img src="images/about-img1.jpg" loading="lazy" alt="Resort Pool"
                                    class="img-fluid w-100 h-100">
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: 2 Stacked Images (Slide from Right) -->
                    <div class="col-lg-6">
                        <!-- Right Image 1 (Slides from Right) -->
                        <div class="mb-4" data-aos="fade-left" data-aos-duration="1100" data-aos-delay="150">
                            <div class="welcome-img-card welcome-img-secondary shadow-sm">
                                <img src="images/about-img2.jpg" loading="lazy" alt="Luxury Suite"
                                    class="img-fluid w-100 h-100">
                            </div>
                        </div>
                        <!-- Right Image 2 (Slides from Right) -->
                        <div data-aos="fade-left" data-aos-duration="1100" data-aos-delay="300">
                            <div class="welcome-img-card welcome-img-secondary shadow-sm">
                                <img src="images/about-img3.jpg" loading="lazy" alt="Hotel Experience"
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

                    <!-- Left Column: Featured Room Card -->
                    <div class="col-lg-7" data-aos="fade-right" data-aos-duration="1000">
                        <asp:Repeater ID="rptFeaturedRoom" runat="server">
                            <ItemTemplate>
                                <div class="featured-suite-card">

                                    <!-- Top Image with Badges -->
                                    <div class="featured-suite-img-wrap">
                                        <img src='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>' loading="lazy"
                                            alt='<%# Eval("RoomName") %>' class="img-fluid"
                                            onerror="this.onerror=null; this.src='images/room-featured-presidential.jpg';">
                                        <span class="badge-presidential-pill" style="color: #442305 !important; font-weight: 800;"><%# GetBadgeText(Eval("CategoryBadge"), Eval("RoomCategory")) %></span>
                                        <div class="suite-overlay-pills">
                                            <span class="suite-overlay-pill">
                                                <i class="bi bi-people-fill"></i> <%# Eval("MaxGuests") %>
                                            </span>
                                            <span class="suite-overlay-pill">
                                                <i class="bi bi-house-door-fill"></i> <%# Eval("RoomArea") %>
                                            </span>
                                            <span class="suite-overlay-pill">
                                                <i class="bi bi-geo-alt-fill"></i> <%# string.IsNullOrEmpty(Convert.ToString(Eval("ViewType"))) ? "City View" : Eval("ViewType") %>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Body -->
                                    <div class="featured-suite-body">
                                        <div class="suite-title-row">
                                            <h3 class="suite-title"><%# Eval("RoomName") %></h3>
                                            <div class="suite-rating-box">
                                                <div class="suite-rating-stars">
                                                    <%# RenderRatingStars(Eval("Rating")) %>
                                                </div>
                                                <div class="suite-rating-text"><%# Eval("Rating") %> Excellence</div>
                                            </div>
                                        </div>

                                        <p class="suite-desc">
                                            <%# Eval("ShortDescription") %>
                                        </p>

                                        <div class="suite-amenities-row">
                                            <%# RenderFeaturedAmenities(Eval("KeyAmenities")) %>
                                        </div>

                                        <div class="suite-price-action-row">
                                            <div class="suite-price-wrap">
                                                <span class="currency">&#8377;</span>
                                                <span class="amount"><%# Eval("PricePerNight", "{0:N0}") %></span>
                                                <span class="period">/ night</span>
                                            </div>
                                            <a href='<%# "RoomDetails.aspx?RoomId=" + Eval("RoomID") %>'
                                                class="btn btn-reserve-suite">
                                                <span>Reserve Suite</span>
                                                <i class="fa-solid fa-arrow-right"></i>
                                            </a>
                                        </div>
                                    </div>

                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Right Column: 3 Stacked Horizontal Room Cards (Staggered Animation) -->
                    <div class="col-lg-5 d-flex flex-column justify-content-between">
                        <asp:Repeater ID="rptMiniRooms" runat="server">
                            <ItemTemplate>
                                <div class="mini-room-card" data-aos="fade-left" data-aos-duration="800" data-aos-delay='<%# (Container.ItemIndex + 1) * 150 %>'>
                                    <div class="mini-room-img-wrap">
                                        <img src='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>' loading="lazy" alt='<%# Eval("RoomName") %>'
                                            onerror="this.onerror=null; this.src='images/room-mini-business.jpg';">
                                    </div>
                                    <div class="mini-room-body">
                                        <div>
                                            <h4 class="mini-room-title"><%# Eval("RoomName") %></h4>
                                            <p class="mini-room-desc">
                                                <%# Eval("ShortDescription") %>
                                            </p>
                                            <div class="mini-room-tags">
                                                <%# RenderMiniTags(Eval("ViewType"), Eval("KeyAmenities"), Eval("MaxGuests")) %>
                                            </div>
                                        </div>
                                        <div class="mini-room-footer">
                                            <div class="mini-room-price"><span class="currency">&#8377;</span><%# Eval("PricePerNight", "{0:N0}") %> <small>/ night</small></div>
                                            <a href='<%# "RoomDetails.aspx?RoomId=" + Eval("RoomID") %>'
                                                class="btn btn-book-mini">
                                                <span>Book</span>
                                                <i class="fa-solid fa-arrow-right" style="font-size: 0.72rem;"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                </div>

            </div>
        </section>


        <!-- ==========================================
             SIGNATURE DINING SHOWCASE SECTION (THE ROYAL KITCHEN)
             ========================================== -->
        <section id="dining-showcase" class="py-5" style="background-color: #faf8f5;">
            <div class="container-fluid px-4 px-lg-5 py-4">

                <!-- Section Header -->
                <div class="text-center mb-5" data-aos="fade-down" data-aos-duration="1000">
                    <div>
                        <span class="welcome-subtitle-anim">
                            <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                            Haute Gastronomy &amp; Culinary Art
                            <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        </span>
                    </div>
                    <h2 class="welcome-title-anim mb-2">
                        Hotel Signature Restaurant: <span class="welcome-title-gold">The Royal Kitchen</span>
                    </h2>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                    <p class="text-muted mx-auto mt-3" style="max-width: 720px; font-size: 0.95rem; line-height: 1.7;">
                        Hotel's premier fine dining destination offering authentic Awadhi dum-pukht, royal Indian curries, kebabs, and international gourmet cuisine.
                    </p>
                </div>

                <!-- Single Restaurant Showcase Card: The Royal Kitchen (Matching Dining.aspx) -->
                <div class="row justify-content-center">
                    <div class="col-xl-11 col-12" data-aos="fade-up" data-aos-duration="900">
                        <div class="dining-venue-card shadow-sm overflow-hidden" style="border: 1px solid rgba(184, 142, 104, 0.28);">
                            <div class="row g-0 align-items-center">
                                <!-- Image Column -->
                                <div class="col-lg-6">
                                    <div class="dining-venue-img-wrap">
                                        <picture class="w-100 h-100 d-block">
                                            <source srcset="images/dining-royal-zafran.webp" type="image/webp">
                                            <img src="images/dining-royal-zafran.jpg" alt="The Royal Kitchen Fine Dining" class="dining-venue-img" loading="lazy" decoding="async">
                                        </picture>
                                        <span class="dining-venue-badge">
                                            <i class="bi bi-crown me-1 text-warning"></i>Fine Dining &bull; Indian, Mughlai &amp; Continental
                                        </span>
                                    </div>
                                </div>
                                <!-- Content Column -->
                                <div class="col-lg-6">
                                    <div class="p-4 p-md-5">
                                        <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-2">
                                            <span class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold">Exclusive Hotel Restaurant</span>
                                            <span class="text-muted small"><i class="bi bi-geo-alt me-1 text-gold"></i>Ground Floor, Garden Wing</span>
                                        </div>
                                        <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">The Royal Kitchen</h3>
                                        <p class="text-muted mb-4 leading-relaxed" style="font-size: 0.95rem; line-height: 1.7;">
                                            An iconic fine-dining sanctuary celebrating regal culinary creations. Dine beneath ornate marble arches and crystal chandeliers while savouring slow-cooked Galouti kebabs, Dal Royal, artisanal tandoori breads, and aromatic Dum Biryanis crafted by master chefs.
                                        </p>

                                        <div class="row g-3 mb-4 small text-muted">
                                            <div class="col-sm-6">
                                                <div class="p-3 bg-light rounded-3 border">
                                                    <strong class="d-block text-dark mb-1"><i class="bi bi-clock me-1 text-gold"></i>Operating Hours:</strong>
                                                    <span>11:00 AM &ndash; 11:00 PM (Daily)</span>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="p-3 bg-light rounded-3 border">
                                                    <strong class="d-block text-dark mb-1"><i class="bi bi-person-badge me-1 text-gold"></i>Seating &amp; Ambience:</strong>
                                                    <span>Capacity: 90 Guests &bull; 2 Private Salons</span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="d-flex gap-3 flex-wrap">
                                            <a href="TableReservation.aspx" class="btn btn-navbar-theme px-4 py-2.5 fw-bold">
                                                <i class="bi bi-calendar2-check me-1"></i>Reserve Your Table
                                            </a>
                                            <a href="Dining.aspx#menuShowcase" class="btn btn-outline-dark px-4 py-2.5 fw-bold">
                                                <i class="bi bi-journal-text me-1"></i>View Chef's Menu
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bottom CTA Buttons -->
                <div class="d-flex flex-wrap justify-content-center gap-3 mt-5" data-aos="fade-up" data-aos-delay="300">
                    <a href="Dining.aspx" class="btn-welcome-about">
                        <span>Explore Full Dining &amp; Menus</span>
                        <i class="bi bi-arrow-right"></i>
                    </a>
                    <a href="TableReservation.aspx" class="btn btn-outline-dark px-4 py-3 rounded-pill fw-bold text-uppercase letter-spacing-1 small shadow-sm d-inline-flex align-items-center gap-2">
                        <i class="bi bi-calendar2-check text-gold"></i>
                        <span>Reserve A Table</span>
                    </a>
                </div>

            </div>
        </section>

        <!-- ==========================================
             SPECIAL OFFERS & PROMOTIONS SECTION (STEP 2)
             ========================================== -->
        <section id="special-offers" class="special-offers-section" style="display: none !important;">
            <div class="special-offers-watermark">SPECIAL OFFERS</div>
            <div class="container px-4 px-lg-5 position-relative z-1">

                <!-- Section Header -->
                <div class="text-center mb-5 position-relative" data-aos="fade-down" data-aos-duration="1000">
                    <div class="mb-2">
                        <span class="welcome-subtitle-anim">
                            <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                            Exclusive Offers For Your Stay
                            <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        </span>
                    </div>
                    <h2 class="welcome-title-anim mb-2">
                        Special <span class="welcome-title-gold">Offers</span>
                    </h2>
                    <div class="welcome-divider mx-auto my-3">
                        <span class="divider-line"></span>
                        <span class="divider-diamond">◆</span>
                        <span class="divider-line"></span>
                    </div>
                    <p class="text-muted mx-auto" style="max-width: 620px; font-size: 0.95rem; line-height: 1.7;">
                        Indulge in handcrafted seasonal packages, gourmet dining credits, and wellness privileges designed to make every stay extraordinary.
                    </p>
                </div>

                <!-- 3 Special Offers Cards Grid -->
                <div class="row g-4 justify-content-center mb-5">

                    <!-- Offer Card 1: Breakfast Included -->
                    <div class="col-lg-4 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                        <div class="special-offer-card">
                            <div class="offer-card-img-wrap">
                                <img src="images/amenity-restaurant.jpg" loading="lazy" alt="Breakfast Included Offer">
                                <span class="offer-card-overlay-badge">
                                    <i class="bi bi-star-fill text-warning"></i> Breakfast Included
                                </span>
                                <span class="offer-card-validity-pill">Daily Inclusions</span>
                            </div>
                            <div class="offer-card-body">
                                <div>
                                    <span class="offer-card-category">Stay &amp; Dining</span>
                                    <h3 class="offer-card-title">Breakfast Inclusive Offer</h3>
                                    <p class="offer-card-desc">
                                        Wake up to a lavish culinary spread with live chef stations, artisanal pastries, and freshly squeezed tropical juices.
                                    </p>
                                    <ul class="offer-inclusions-list">
                                        <li><i class="bi bi-check-circle-fill"></i> Gourmet Breakfast for 2 Guests</li>
                                        <li><i class="bi bi-check-circle-fill"></i> High-Speed Wi-Fi &amp; Valet Parking</li>
                                        <li><i class="bi bi-check-circle-fill"></i> Complimentary Welcome Drink</li>
                                    </ul>
                                </div>
                                <div class="offer-card-footer">
                                    <div class="offer-price-box">
                                        <span class="offer-price-label">Starting From</span>
                                        <span class="offer-price-val" data-inr-price="4999">&#8377;4,999 <span class="period">/ night</span></span>
                                    </div>
                                    <a href="OfferDetails.aspx?id=breakfast-included" class="btn-offer-view">
                                        <span>View Offer</span>
                                        <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Offer Card 2: Weekend Getaway -->
                    <div class="col-lg-4 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="250">
                        <div class="special-offer-card">
                            <div class="offer-card-img-wrap">
                                <img src="images/amenity-pool.jpg" loading="lazy" alt="Weekend Getaway Offer">
                                <span class="offer-card-overlay-badge">
                                    <i class="bi bi-calendar-heart text-warning"></i> Weekend Getaway
                                </span>
                                <span class="offer-card-validity-pill">Fri - Sun Special</span>
                            </div>
                            <div class="offer-card-body">
                                <div>
                                    <span class="offer-card-category">Weekend Leisure</span>
                                    <h3 class="offer-card-title">Weekend Royal Getaway</h3>
                                    <p class="offer-card-desc">
                                        Escape routine with our revitalizing weekend sanctuary featuring poolside cabanas, afternoon high tea, and spa privileges.
                                    </p>
                                    <ul class="offer-inclusions-list">
                                        <li><i class="bi bi-check-circle-fill"></i> Heritage High Tea Service</li>
                                        <li><i class="bi bi-check-circle-fill"></i> 20% Savings On Spa Treatments</li>
                                        <li><i class="bi bi-check-circle-fill"></i> Guaranteed 2:00 PM Late Checkout</li>
                                    </ul>
                                </div>
                                <div class="offer-card-footer">
                                    <div class="offer-price-box">
                                        <span class="offer-price-label">Starting From</span>
                                        <span class="offer-price-val" data-inr-price="5499">&#8377;5,499 <span class="period">/ night</span></span>
                                    </div>
                                    <a href="OfferDetails.aspx?id=weekend-getaway" class="btn-offer-view">
                                        <span>View Offer</span>
                                        <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Offer Card 3: Long Stay Offer -->
                    <div class="col-lg-4 col-md-6 col-12" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                        <div class="special-offer-card">
                            <div class="offer-card-img-wrap">
                                <img src="images/room-featured-presidential.jpg" loading="lazy" alt="Long Stay Offer">
                                <span class="offer-card-overlay-badge">
                                    <i class="bi bi-percent text-warning"></i> Long Stay Offer
                                </span>
                                <span class="offer-card-validity-pill">Min 3 Nights</span>
                            </div>
                            <div class="offer-card-body">
                                <div>
                                    <span class="offer-card-category">Extended Stay</span>
                                    <h3 class="offer-card-title">Long Stay Offer</h3>
                                    <p class="offer-card-desc">
                                        Immerse deeper into comfort. Stay for 3 nights or more and enjoy 20% savings along with private airport transfers.
                                    </p>
                                    <ul class="offer-inclusions-list">
                                        <li><i class="bi bi-check-circle-fill"></i> 20% Flat Discount on Entire Stay</li>
                                        <li><i class="bi bi-check-circle-fill"></i> One-Way Airport Luxury Transfer</li>
                                        <li><i class="bi bi-check-circle-fill"></i> Daily Laundry Credit (4 garments)</li>
                                    </ul>
                                </div>
                                <div class="offer-card-footer">
                                    <div class="offer-price-box">
                                        <span class="offer-price-label">Special Discount</span>
                                        <span class="offer-price-val" style="color: #B88E68;">20% OFF <span class="period">/ stay</span></span>
                                    </div>
                                    <a href="OfferDetails.aspx?id=long-stay" class="btn-offer-view">
                                        <span>View Offer</span>
                                        <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Centered Bottom CTA: VIEW ALL OFFERS -->
                <div class="text-center" data-aos="fade-up" data-aos-delay="300">
                    <a href="Offers.aspx" class="btn-view-all-offers">
                        <i class="bi bi-gift-fill me-1"></i>
                        <span>View All Offers</span>
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

                <!-- Section Header with Luxury Website Styling -->
                <div class="text-center mb-5 position-relative" data-aos="fade-down" data-aos-duration="1000">
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
                                <img src="images/testimonial-user1.jpg" loading="lazy" alt="Rahul Singh"
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
                                <img src="images/testimonial-user2.jpg" loading="lazy" alt="Priya Singhania"
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
                                <img src="images/testimonial-user3.jpg" loading="lazy" alt="Rajesh Sharma"
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
                                <img src="images/testimonial-user4.jpg" loading="lazy" alt="Ananya Verma"
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
                            <img src="images/gallery-1.jpg" loading="lazy" alt="Luxury Hotel Suite Lounge">
                            <a href="images/gallery-1.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-1.jpg" data-title="Luxury Hotel Suite Lounge"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-2.jpg" loading="lazy" alt="Fine Dining Breakfast Service">
                            <a href="images/gallery-2.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-2.jpg" data-title="Fine Dining Gourmet Breakfast Service"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-3.jpg" loading="lazy" alt="Sky Lounge Panoramic Bar">
                            <a href="images/gallery-3.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-3.jpg"
                                data-title="Sky Lounge &amp; Executive Panoramic Bar" title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-4.jpg" loading="lazy" alt="Night Courtyard Architecture">
                            <a href="images/gallery-4.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-4.jpg"
                                data-title="Illuminated Night Courtyard &amp; Royal Palace Architecture"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-5.jpg" loading="lazy" alt="Infinity Pool Villa Resort">
                            <a href="images/gallery-5.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-5.jpg"
                                data-title="Infinity Heated Swimming Pool &amp; Luxury Villa Deck"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>

                        <!-- Set 2 (Duplicated 5 Images for Seamless Infinite Loop) -->
                        <div class="gallery-card-item">
                            <img src="images/gallery-1.jpg" loading="lazy" alt="Luxury Hotel Suite Lounge">
                            <a href="images/gallery-1.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-1.jpg" data-title="Luxury Hotel Suite Lounge"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-2.jpg" loading="lazy" alt="Fine Dining Breakfast Service">
                            <a href="images/gallery-2.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-2.jpg" data-title="Fine Dining Gourmet Breakfast Service"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-3.jpg" loading="lazy" alt="Sky Lounge Panoramic Bar">
                            <a href="images/gallery-3.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-3.jpg"
                                data-title="Sky Lounge &amp; Executive Panoramic Bar" title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-4.jpg" loading="lazy" alt="Night Courtyard Architecture">
                            <a href="images/gallery-4.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
                                data-img-src="images/gallery-4.jpg"
                                data-title="Illuminated Night Courtyard &amp; Royal Palace Architecture"
                                title="Click to View Full Size">
                                <i class="bi bi-eye"></i>
                            </a>
                        </div>
                        <div class="gallery-card-item">
                            <img src="images/gallery-5.jpg" loading="lazy" alt="Infinity Pool Villa Resort">
                            <a href="images/gallery-5.jpg" class="gallery-card-overlay gallery-lightbox-trigger"
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

        <!-- Gallery Lightbox Modal (Matching Luxury Website Theme) -->
        <div class="modal fade" id="galleryLightboxModal" tabindex="-1" aria-labelledby="galleryModalCaption"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0">
                    <!-- Top Header: Title at TOP + Close Button -->
                    <div class="modal-header d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-2 pe-3">
                            <i class="bi bi-camera text-gold fs-5"></i>
                            <h5 class="modal-title font-serif mb-0 fs-5 fw-semibold" id="galleryModalCaption">
                                Photo Preview
                            </h5>
                        </div>
                        <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal"
                            aria-label="Close">
                        </button>
                    </div>

                    <!-- Modal Image -->
                    <div class="modal-body text-center p-2 p-md-3">
                        <img id="galleryModalPreviewImg" src="" alt="Gallery Preview"
                            class="img-fluid rounded-3">
                    </div>
                </div>
            </div>
        </div>

    </asp:Content>