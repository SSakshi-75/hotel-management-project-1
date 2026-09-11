<%@ Page Title="Rooms & Suites | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Room.aspx.cs" Inherits="Room" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <!-- ==========================================
         1. COMPACT ROOM HERO BANNER SECTION
         ========================================== -->
        <section class="room-compact-hero text-white text-center">
            <div class="container py-2 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
                <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                    <i class="bi bi-stars me-1 text-warning"></i> 5-Star Royal Accommodations
                </span>
                <h1 class="display-4 font-serif fw-bold text-white mb-2">Our Rooms &amp; Suites</h1>
                <p class="text-champagne-gold fs-5 mb-0 font-serif">
                    Handcrafted Sanctuaries Of Serenity, Elegance &amp; Royalty
                </p>
            </div>
        </section>

        <!-- ==========================================
         2. CHECK-IN & CHECK-OUT SEARCH CARD STRIP
         ========================================== -->
        <div class="container px-3 px-md-5 room-search-wrapper mb-5">
            <div class="room-search-box" data-aos="fade-up" data-aos-delay="100">
                <form id="roomFilterForm" onsubmit="return false;">
                    <div class="row g-3 align-items-end">

                        <div class="col-lg-3 col-md-6">
                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-calendar-check text-warning me-1"></i> Check-In Date
                            </label>
                            <input type="date" class="form-control room-input-field shadow-none fs-6">
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-calendar-x text-warning me-1"></i> Check-Out Date
                            </label>
                            <input type="date" class="form-control room-input-field shadow-none fs-6">
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-people-fill text-warning me-1"></i> Guests &amp; Rooms
                            </label>
                            <select class="form-select room-input-field shadow-none fs-6">
                                <option selected>1 Adult, 1 Room</option>
                                <option>2 Adults, 1 Suite</option>
                                <option>3 Adults, 2 Rooms</option>
                                <option>Family (4+ Guests)</option>
                            </select>
                        </div>

                        <div class="col-lg-3 col-md-6">
                            <button type="button" class="btn btn-room-search w-100 shadow-sm" onclick="scrollToRooms()">
                                <i class="bi bi-search me-2"></i> Check Availability
                            </button>
                        </div>

                    </div>
                </form>
            </div>
        </div>

        <!-- ==========================================
         3. EXACT 6 LUXURY ROOM CARDS GRID
         ========================================== -->
        <section id="all-rooms-grid" class="py-4 bg-light">
            <div class="container-fluid px-4 px-lg-5 py-2">

                <!-- Section Title & Category Filter Tabs -->
                <div class="text-center mb-4" data-aos="fade-down">
                    <span class="welcome-subtitle-anim">
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        Featured Accommodations
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                    </span>
                    <h2 class="welcome-title-anim mb-3">
                        Choose Your <span class="welcome-title-gold">Luxury Room</span>
                    </h2>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                </div>

                <!-- Filter Category Buttons -->
                <div class="text-center mb-5" data-aos="fade-up">
                    <div class="room-filter-bar">
                        <button type="button" class="room-filter-btn active" onclick="filterRooms('all', this)">All
                            Rooms</button>
                        <button type="button" class="room-filter-btn"
                            onclick="filterRooms('executive', this)">Executive</button>
                        <button type="button" class="room-filter-btn"
                            onclick="filterRooms('deluxe', this)">Deluxe</button>
                        <button type="button" class="room-filter-btn"
                            onclick="filterRooms('family', this)">Family</button>
                        <button type="button" class="room-filter-btn"
                            onclick="filterRooms('presidential', this)">Penthouse &amp; Royal</button>
                    </div>
                </div>

                <!-- Exactly 6 Room Cards Grid (3 columns x 2 rows) -->
                <div class="row g-4" id="roomsContainer">

                    <!-- Room Card 1: Executive Business Suite -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="executive" data-aos="fade-up"
                        data-aos-delay="100">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-mini-business.jpg" loading="lazy" alt="Executive Business Suite">
                                <span class="room-card-tag"><i class="fa-solid fa-crown me-1 text-warning"></i>
                                    EXECUTIVE</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 8,500 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(4.9)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Executive Business Suite</h3>
                                <p class="room-card-full-desc">
                                    Crafted for modern business leaders, featuring ergonomic workstation, soundproof
                                    windows, high-speed Wi-Fi &amp; luxury king bedding.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 2 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 55 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-building"></i> City View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-wifi"></i> High-Speed WiFi</span>
                                    <span class="room-amenity-tag"><i class="bi bi-briefcase"></i> Work Desk</span>
                                    <span class="room-amenity-tag"><i class="bi bi-cup-hot"></i> Coffee Maker</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Executive+Business+Suite&price=8500&img=images/room-mini-business.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Card 2: Garden View Deluxe Room -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="deluxe" data-aos="fade-up"
                        data-aos-delay="200">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-mini-garden.jpg" loading="lazy" alt="Garden View Deluxe Room">
                                <span class="room-card-tag"><i class="fa-solid fa-leaf me-1 text-success"></i>
                                    DELUXE</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 6,800 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(4.8)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Garden View Deluxe Room</h3>
                                <p class="room-card-full-desc">
                                    Surround yourself with lush botanical greenery, private sun balcony, soothing room
                                    acoustics, and plush premium bedding.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 2 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 45 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-tree-fill"></i> Garden View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-door-open"></i> Private
                                        Terrace</span>
                                    <span class="room-amenity-tag"><i class="bi bi-snow"></i> Air Conditioning</span>
                                    <span class="room-amenity-tag"><i class="bi bi-tv"></i> 50" Smart TV</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Garden+View+Deluxe+Room&price=6800&img=images/room-mini-garden.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Card 3: Family Comfort Suite -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="family" data-aos="fade-up"
                        data-aos-delay="300">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-mini-family.jpg" loading="lazy" alt="Family Comfort Suite">
                                <span class="room-card-tag"><i class="fa-solid fa-heart me-1 text-danger"></i>
                                    FAMILY</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 11,500 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(5.0)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Family Comfort Suite</h3>
                                <p class="room-card-full-desc">
                                    Spacious multi-room luxury suite equipped with a family lounge, double vanity marble
                                    bathroom &amp; kids entertainment area.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 4 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 85 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-sun-fill"></i> Pool View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-controller"></i> Kids Area</span>
                                    <span class="room-amenity-tag"><i class="bi bi-house"></i> 2 Bedrooms</span>
                                    <span class="room-amenity-tag"><i class="bi bi-cup-straw"></i> Mini Bar</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Family+Comfort+Suite&price=11500&img=images/room-mini-family.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Card 4: Classic Double Luxury Room -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="deluxe" data-aos="fade-up"
                        data-aos-delay="100">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-classic-double.jpg" loading="lazy" alt="Classic Double Luxury Room">
                                <span class="room-card-tag"><i class="fa-solid fa-gem me-1 text-info"></i> DELUXE</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 14,999 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(4.9)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Classic Double Luxury Room</h3>
                                <p class="room-card-full-desc">
                                    Perfect harmony of classic luxury and essential modern amenities with twin queen
                                    bedding and glass rain shower.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 2 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 38 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-flower1"></i> Courtyard View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-wifi"></i> Free WiFi</span>
                                    <span class="room-amenity-tag"><i class="bi bi-shield-lock"></i> Safe Box</span>
                                    <span class="room-amenity-tag"><i class="bi bi-droplet-fill"></i> Rain Shower</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Classic+Double+Luxury+Room&price=14999&img=images/room-classic-double.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Card 5: Superior King Royal Room -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="executive" data-aos="fade-up"
                        data-aos-delay="200">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-superior-king.jpg" loading="lazy" alt="Superior King Royal Room">
                                <span class="room-card-tag"><i class="fa-solid fa-crown me-1 text-warning"></i> ROYAL
                                    KING</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 19,999 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(5.0)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Superior King Royal Room</h3>
                                <p class="room-card-full-desc">
                                    Featuring an emperor-size bed, private marble jacuzzi, floor-to-ceiling glass
                                    windows and complimentary high tea.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 2 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 60 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-sky"></i> Skyline View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-hottub"></i> Jacuzzi</span>
                                    <span class="room-amenity-tag"><i class="bi bi-person-badge"></i> Butler
                                        Service</span>
                                    <span class="room-amenity-tag"><i class="bi bi-cup-hot-fill"></i> Free High
                                        Tea</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Superior+King+Royal+Room&price=19999&img=images/room-superior-king.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Room Card 6: Royal Penthouse Haven -->
                    <div class="col-lg-4 col-md-6 room-item-col" data-category="presidential" data-aos="fade-up"
                        data-aos-delay="300">
                        <div class="room-card-full">
                            <div class="room-card-full-img">
                                <img src="images/room-luxury-penthouse.jpg" loading="lazy" alt="Royal Penthouse Haven">
                                <span class="room-card-tag"><i class="fa-solid fa-chess-king me-1 text-warning"></i>
                                    PENTHOUSE</span>
                                <div class="room-card-price-tag"><span class="currency">&#8377;</span> 95,999 <small>/
                                        night</small></div>
                            </div>
                            <div class="room-card-full-body">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <div class="room-card-stars">
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <i class="fa-solid fa-star text-warning"></i>
                                        <span class="rating-num ms-1">(5.0)</span>
                                    </div>
                                    <span class="badge-verified"><i class="bi bi-shield-check text-success me-1"></i>
                                        Verified</span>
                                </div>
                                <h3 class="room-card-full-title">Royal Penthouse Haven</h3>
                                <p class="room-card-full-desc">
                                    Ultimate luxury living with private infinity pool, dedicated chef kitchen, 3 king
                                    suites and VIP airport limo transfer.
                                </p>
                                <div class="room-specs-grid">
                                    <span class="room-spec-pill"><i class="bi bi-people-fill"></i> 6 Guests</span>
                                    <span class="room-spec-pill"><i class="bi bi-aspect-ratio-fill"></i> 220 m²</span>
                                    <span class="room-spec-pill"><i class="bi bi-water"></i> Ocean &amp; City
                                        View</span>
                                </div>
                                <div class="room-amenities-list">
                                    <span class="room-amenity-tag"><i class="bi bi-water"></i> Heated Pool</span>
                                    <span class="room-amenity-tag"><i class="bi bi-car-front-fill"></i> Limo
                                        Transfer</span>
                                    <span class="room-amenity-tag"><i class="bi bi-shield-check"></i> Private
                                        Elevator</span>
                                </div>
                                <div class="room-card-full-footer justify-content-end">
                                    <a href="RoomDetails.aspx?title=Royal+Penthouse+Haven&price=95999&img=images/room-luxury-penthouse.jpg" class="btn btn-room-book text-decoration-none">
                                        <span>View Details</span> <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </section>



    </asp:Content>