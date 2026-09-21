<%@ Page Title="Rooms & Suites | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Room.aspx.cs" Inherits="Room" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
         1. COMPACT ROOM HERO BANNER SECTION
         ========================================== -->
        <section class="room-compact-hero text-white text-center">
            <div class="container py-2 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">

                <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                    <i class="bi bi-stars me-1 text-warning"></i>
                    5-Star Royal Accommodations
                </span>

                <h1 class="display-4 font-serif fw-bold text-white mb-2">
                    Our Rooms &amp; Suites
                </h1>

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

                        <!-- Check-In -->
                        <div class="col-lg-3 col-md-6">

                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-calendar-check text-warning me-1"></i>
                                Check-In Date
                            </label>

                            <input type="date" class="form-control room-input-field shadow-none fs-6">

                        </div>


                        <!-- Check-Out -->
                        <div class="col-lg-3 col-md-6">

                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-calendar-x text-warning me-1"></i>
                                Check-Out Date
                            </label>

                            <input type="date" class="form-control room-input-field shadow-none fs-6">

                        </div>


                        <!-- Guests & Rooms -->
                        <div class="col-lg-3 col-md-6">

                            <label class="form-label small fw-bold text-uppercase mb-1 ms-2">
                                <i class="bi bi-people-fill text-warning me-1"></i>
                                Guests &amp; Rooms
                            </label>

                            <select class="form-select room-input-field shadow-none fs-6">

                                <option selected>
                                    1 Adult, 1 Room
                                </option>

                                <option>
                                    2 Adults, 1 Suite
                                </option>

                                <option>
                                    3 Adults, 2 Rooms
                                </option>

                                <option>
                                    Family (4+ Guests)
                                </option>

                            </select>

                        </div>


                        <!-- Availability Button -->
                        <div class="col-lg-3 col-md-6">

                            <button type="button" class="btn btn-room-search w-100 shadow-sm" onclick="scrollToRooms()">

                                <i class="bi bi-search me-2"></i>
                                Check Availability

                            </button>

                        </div>

                    </div>

                </form>

            </div>

        </div>


        <!-- ==========================================
         3. DYNAMIC ROOM CARDS SECTION
         ========================================== -->
        <section id="all-rooms-grid" class="py-4 bg-light">

            <div class="container-fluid px-4 px-lg-5 py-2">


                <!-- ==========================================
                 SECTION TITLE
                 ========================================== -->
                <div class="text-center mb-4" data-aos="fade-down">

                    <span class="welcome-subtitle-anim">

                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>

                        Featured Accommodations

                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>

                    </span>


                    <h2 class="welcome-title-anim mb-3">

                        Choose Your
                        <span class="welcome-title-gold">
                            Luxury Room
                        </span>

                    </h2>


                    <div class="welcome-decor-line">

                        <div class="line"></div>

                        <div class="diamond">
                            <i class="fa-solid fa-gem"></i>
                        </div>

                        <div class="line right"></div>

                    </div>

                </div>


                <!-- ==========================================
                 CATEGORY FILTER BUTTONS
                 ========================================== -->
                <div class="text-center mb-5" data-aos="fade-up">

                    <div class="room-filter-bar">

                        <button type="button" class="room-filter-btn active" onclick="filterRooms('all', this)">
                            All Rooms
                        </button>


                        <button type="button" class="room-filter-btn" onclick="filterRooms('executive', this)">
                            Executive
                        </button>


                        <button type="button" class="room-filter-btn" onclick="filterRooms('deluxe', this)">
                            Deluxe
                        </button>


                        <button type="button" class="room-filter-btn" onclick="filterRooms('family', this)">
                            Family
                        </button>


                        <button type="button" class="room-filter-btn" onclick="filterRooms('presidential', this)">
                            Penthouse &amp; Royal
                        </button>

                    </div>

                </div>


                <!-- ==========================================
                 DYNAMIC ROOM CARDS
                 ========================================== -->
                <div class="row g-4" id="roomsContainer">


                    <!-- ======================================
                     REPEATER START
                     ====================================== -->
                    <asp:Repeater ID="rptRooms" runat="server">

                        <ItemTemplate>


                            <!-- ==================================
                             ONE DYNAMIC ROOM CARD
                             ================================== -->
                            <div class="col-lg-4 col-md-6 room-item-col"
                                data-category='<%# GetCategoryFilter(Eval("RoomCategory")) %>' data-aos="fade-up">


                                <div class="room-card-full">


                                    <!-- ==================================
                                     ROOM IMAGE
                                     ================================== -->
                                    <div class="room-card-full-img">

                                        <img src='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>' loading="lazy"
                                            alt='<%# Eval("RoomName") %>' />


                                        <!-- Category Badge -->
                                        <span class="room-card-tag">

                                            <i class="fa-solid fa-crown me-1 text-warning"></i>

                                            <%# Eval("CategoryBadge") %>

                                        </span>


                                        <!-- Price -->
                                        <div class="room-card-price-tag">

                                            <span class="currency">
                                                &#8377;
                                            </span>

                                            <%# Eval("PricePerNight", "{0:N0}" ) %>

                                                <small>
                                                    / night
                                                </small>

                                        </div>

                                    </div>


                                    <!-- ==================================
                                     ROOM CARD BODY
                                     ================================== -->
                                    <div class="room-card-full-body">


                                        <!-- Rating -->
                                        <div class="d-flex justify-content-between align-items-center mb-1">

                                            <div class="room-card-stars">

                                                <i class="fa-solid fa-star text-warning"></i>
                                                <i class="fa-solid fa-star text-warning"></i>
                                                <i class="fa-solid fa-star text-warning"></i>
                                                <i class="fa-solid fa-star text-warning"></i>
                                                <i class="fa-solid fa-star text-warning"></i>

                                                <span class="rating-num ms-1">
                                                    (<%# Eval("Rating") %>)
                                                </span>

                                            </div>


                                            <span class="badge-verified">

                                                <i class="bi bi-shield-check text-success me-1"></i>

                                                Verified

                                            </span>

                                        </div>


                                        <!-- Room Name -->
                                        <h3 class="room-card-full-title">

                                            <%# Eval("RoomName") %>

                                        </h3>


                                        <!-- Short Description -->
                                        <p class="room-card-full-desc">

                                            <%# Eval("ShortDescription") %>

                                        </p>


                                        <!-- ==================================
                                         ROOM SPECIFICATIONS
                                         ================================== -->
                                        <div class="room-specs-grid">


                                            <!-- Guests -->
                                            <span class="room-spec-pill">

                                                <i class="bi bi-people-fill"></i>

                                                <%# Eval("MaxGuests") %>
                                                    Guests

                                            </span>


                                            <!-- Area -->
                                            <span class="room-spec-pill">

                                                <i class="bi bi-aspect-ratio-fill"></i>

                                                <%# Eval("RoomArea") %>

                                            </span>


                                            <!-- View -->
                                            <span class="room-spec-pill">

                                                <i class="bi bi-building"></i>

                                                <%# Eval("ViewType") %>

                                            </span>


                                        </div>


                                        <!-- ==================================
                                         DYNAMIC AMENITIES
                                         ================================== -->
                                        <div class="room-amenities-list">

                                            <%# FormatAmenities(Eval("KeyAmenities")) %>

                                        </div>


                                        <!-- ==================================
                                         VIEW DETAILS
                                         ================================== -->
                                        <div class="room-card-full-footer justify-content-end">


                                            <a href='RoomDetails.aspx?RoomId=<%# Eval("RoomId") %>'
                                                class="btn btn-room-book text-decoration-none">

                                                <span>
                                                    View Details
                                                </span>

                                                <i class="fa-solid fa-arrow-right ms-2 fs-7"></i>

                                            </a>


                                        </div>


                                    </div>

                                </div>

                            </div>


                        </ItemTemplate>

                    </asp:Repeater>
                    <!-- ======================================
                     REPEATER END
                     ====================================== -->


                </div>

            </div>

        </section>


    </asp:Content>