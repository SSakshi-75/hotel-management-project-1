<%@ Page Title="Room Details | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="RoomDetails.aspx.cs" Inherits="RoomDetails" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <!-- Repeater Start -->
        <asp:Repeater ID="rptRoomDetails" runat="server">
            <ItemTemplate>

                <!-- Page Title -->
                <section class="page-title text-center" data-aos="fade-down" data-aos-duration="1000">
                    <div class="container relative-z">
                        <div class="page-title-badge mb-3 d-inline-flex align-items-center gap-2" data-aos="zoom-in"
                            data-aos-delay="100">
                            <i class="bi bi-stars text-gold"></i>
                            <span>
                                <%# GetHeaderBadge(Eval("HeaderBadge"), Eval("RoomCategory")) %>
                            </span>
                            <i class="bi bi-stars text-gold"></i>
                        </div>

                        <h1 class="page-title-heading" id="bannerRoomTitle" data-aos="fade-up" data-aos-delay="200">
                            <%# GetHeaderTitle(Eval("HeaderTitle"), Eval("RoomName")) %>
                        </h1>

                        <div class="page-title-divider" data-aos="fade-up" data-aos-delay="300">
                            <span class="divider-line"></span>
                            <span class="divider-diamond">◆</span>
                            <span class="divider-line"></span>
                        </div>

                        <p class="page-title-subtitle" id="bannerRoomSubtitle" data-aos="fade-up" data-aos-delay="350">
                            <%# GetHeaderSubtitle(Eval("HeaderSubtitle"), Eval("ShortDescription")) %>
                        </p>

                        <nav aria-label="breadcrumb" class="mt-4" data-aos="fade-up" data-aos-delay="400">
                            <ol class="breadcrumb page-title-breadcrumb justify-content-center mb-0">
                                <li class="breadcrumb-item"><a href="index.aspx"><i
                                            class="bi bi-house-door-fill me-1"></i> Home</a></li>
                                <li class="breadcrumb-item"><a href="Room.aspx">Rooms &amp; Suites</a></li>
                                <li class="breadcrumb-item active" id="breadcrumbRoomName" aria-current="page">
                                    <%# Eval("RoomName") %>
                                </li>
                            </ol>
                        </nav>
                    </div>
                </section>
                <!-- End Page Title -->

                <!-- Room Details Section -->
                <section id="room-details" class="room-details-section">
                    <div class="container">

                        <!-- 1. Room Header with Image and Basic Info -->
                        <div class="row align-items-center mb-5" data-aos="fade-up" data-aos-duration="1000">
                            <div class="col-lg-7" data-aos="fade-right" data-aos-delay="200">
                                <div class="room-header-image">
                                    <img id="headerMainImg" src='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>'
                                        loading="lazy" alt='<%# Eval("RoomName") %>' class="img-fluid rounded">
                                    <div class="room-badge">
                                        <span class="text-white" id="headerCategoryBadge">
                                            <%# GetCategoryBadge(Eval("CategoryBadge"), Eval("RoomCategory")) %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-5" data-aos="fade-left" data-aos-delay="300">
                                <div class="room-header-content">
                                    <div class="room-rating mb-3" data-aos="fade-up" data-aos-delay="350">
                                        <span class="rating-score">
                                            <%# GetRatingScore(Eval("Rating")) %>
                                        </span>
                                        <div class="stars">
                                            <%# GetStarIconsHtml(Eval("Rating")) %>
                                        </div>
                                        <span class="reviews-count">(Verified Guest Reviews)</span>
                                    </div>
                                    <h1 class="room-title" id="roomTitle" data-aos="fade-up" data-aos-delay="400">
                                        <%# Eval("RoomName") %>
                                    </h1>
                                    <p class="room-tagline" id="roomTagline" data-aos="fade-up" data-aos-delay="450">
                                        <%# Eval("ShortDescription") %>
                                    </p>

                                    <div class="room-capacity mb-4" data-aos="fade-up" data-aos-delay="500">
                                        <div class="capacity-item">
                                            <i class="bi bi-people-fill"></i>
                                            <span>Up to <%# Eval("MaxGuests") %> guests</span>
                                        </div>
                                        <div class="capacity-item">
                                            <i class="bi bi-aspect-ratio-fill"></i>
                                            <span>
                                                <%# Eval("RoomArea") %>
                                            </span>
                                        </div>
                                        <div class="capacity-item">
                                            <i class="bi bi-building"></i>
                                            <span>
                                                <%# Eval("ViewType") %>
                                            </span>
                                        </div>
                                    </div>

                                    <div class="room-price" data-aos="fade-up" data-aos-delay="550">
                                        <span class="price-amount" id="roomPrice">&#8377; <%#
                                                Eval("PricePerNight", "{0:N0}" ) %></span>
                                        <span class="price-period">per night</span>
                                    </div>

                                    <div data-aos="fade-up" data-aos-delay="600">
                                        <a href='BookNow.aspx?RoomId=<%# Eval("RoomId") %>&room=<%# HttpUtility.UrlEncode(Convert.ToString(Eval("RoomName"))) %>&price=<%# Eval("PricePerNight") %>'
                                            class="btn btn-book-now">
                                            <i class="bi bi-calendar-check me-2"></i> Book Now
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 2. Room Gallery -->
                        <div class="room-gallery mb-5" data-aos="fade-up" data-aos-delay="200">
                            <h3 class="section-subtitle mb-4">Room Gallery</h3>
                            <div class="gallery-grid">
                                <div class="gallery-main" data-aos="zoom-in" data-aos-delay="300">
                                    <img id="galleryMainPhoto" src='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>'
                                        loading="lazy" alt='<%# Eval("RoomName") %>' class="img-fluid"
                                        onclick="swapGallery(this)">
                                </div>
                                <div class="gallery-thumbnails">
                                    <%# GetGalleryThumbnails(Container.DataItem) %>
                                </div>
                            </div>
                        </div>

                        <!-- 3. Room Description & Guest Review -->
                        <div class="row mb-5">
                            <div class='<%# GetOverviewColClass(Eval("ReviewQuote")) %>' data-aos="fade-up"
                                data-aos-delay="200">
                                <div class="room-description">
                                    <h3 class="section-subtitle mb-4">Room Overview</h3>
                                    <%# FormatOverview(Eval("FullOverview"), Eval("ShortDescription")) %>
                                </div>
                            </div>
                            <%# GetReviewSectionHtml(Eval("ReviewQuote"), Eval("ReviewAuthor")) %>
                        </div>

                        <!-- 4. Amenities and Features -->
                        <div class="room-amenities mb-5" data-aos="fade-up" data-aos-delay="200">
                            <h3 class="section-subtitle mb-4">Room Amenities</h3>
                            <div class="row g-4">
                                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="250">
                                    <div class="amenity-category">
                                        <h5>Sleeping</h5>
                                        <ul>
                                            <li><i class="bi bi-check2"></i> King emperor bed</li>
                                            <li><i class="bi bi-check2"></i> Egyptian cotton linens</li>
                                            <li><i class="bi bi-check2"></i> Memory foam pillows</li>
                                            <li><i class="bi bi-check2"></i> Soundproof blackout drapes</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                                    <div class="amenity-category">
                                        <h5>Technology</h5>
                                        <ul>
                                            <li><i class="bi bi-check2"></i> High-speed Wi-Fi</li>
                                            <li><i class="bi bi-check2"></i> 55" 4K Smart OLED TV</li>
                                            <li><i class="bi bi-check2"></i> Bluetooth soundbar</li>
                                            <li><i class="bi bi-check2"></i> USB-C charging hub</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="350">
                                    <div class="amenity-category">
                                        <h5>Comfort</h5>
                                        <ul>
                                            <li><i class="bi bi-check2"></i> Touch climate control</li>
                                            <li><i class="bi bi-check2"></i> Gourmet mini bar</li>
                                            <li><i class="bi bi-check2"></i> Coffee machine</li>
                                            <li><i class="bi bi-check2"></i> Electronic safe box</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                                    <div class="amenity-category">
                                        <h5>Bathroom</h5>
                                        <ul>
                                            <li><i class="bi bi-check2"></i> Italian marble bath</li>
                                            <li><i class="bi bi-check2"></i> Rain glass shower</li>
                                            <li><i class="bi bi-check2"></i> Luxury toiletries</li>
                                            <li><i class="bi bi-check2"></i> Plush bathrobes &amp; slippers</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                            <!-- 5. Tabbed Information -->
                            <div class="room-tabs mb-5" data-aos="fade-up" data-aos-delay="200">
                                <ul class="nav nav-tabs" id="room-detailsRoomTabs" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="room-details-policies-tab"
                                            data-bs-toggle="tab" data-bs-target="#room-details-policies" type="button"
                                            role="tab" aria-selected="true">Policies</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="room-details-location-tab" data-bs-toggle="tab"
                                            data-bs-target="#room-details-location" type="button" role="tab"
                                            aria-selected="false">Location</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link" id="room-details-services-tab" data-bs-toggle="tab"
                                            data-bs-target="#room-details-services" type="button" role="tab"
                                            aria-selected="false">Services</button>
                                    </li>
                                </ul>
                                <div class="tab-content" id="room-detailsRoomTabsContent">
                                    <div class="tab-pane fade show active" id="room-details-policies" role="tabpanel"
                                        aria-labelledby="room-details-policies-tab">
                                        <div class="tab-content-wrapper">
                                            <div class="row g-4">
                                                <div class="col-md-4">
                                                    <h6>Check-in / Check-out</h6>
                                                    <p>Check-in: 02:00 PM<br>Check-out: 11:00 AM</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <h6>Cancellation</h6>
                                                    <p>Free cancellation up to 24 hours before check-in date</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <h6>Policies</h6>
                                                    <p>Non-smoking luxury floor | Pet-free accommodations</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="room-details-location" role="tabpanel"
                                        aria-labelledby="room-details-location-tab">
                                        <div class="tab-content-wrapper">
                                            <div class="row g-4">
                                                <div class="col-md-6">
                                                    <h6>Nearby Attractions</h6>
                                                    <ul>
                                                        <li>Diplomatic Enclave - 2 minutes walk</li>
                                                        <li>Historic India Gate - 1.5 miles</li>
                                                        <li>Connaught Place Shopping - 2.0 miles</li>
                                                        <li>International Airport - 20 minutes drive</li>
                                                    </ul>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6>Transportation</h6>
                                                    <ul>
                                                        <li>24/7 Airport transfer available</li>
                                                        <li>Valet parking - Complimentary</li>
                                                        <li>Metro station nearby</li>
                                                        <li>Luxury car rental desk in lobby</li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="room-details-services" role="tabpanel"
                                        aria-labelledby="room-details-services-tab">
                                        <div class="tab-content-wrapper">
                                            <div class="row g-4">
                                                <div class="col-md-4">
                                                    <h6>Concierge</h6>
                                                    <p>24/7 royal concierge service for reservations &amp; tours</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <h6>Room Service</h6>
                                                    <p>24/7 in-room fine dining service</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <h6>Housekeeping</h6>
                                                    <p>Twice-daily housekeeping and luxury turndown service</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 6. Optional Add-ons -->
                            <div class="room-addons mb-5" data-aos="fade-up" data-aos-delay="200">
                                <h3 class="section-subtitle mb-4">Enhance Your Stay</h3>
                                <div class="row g-4">
                                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="250">
                                        <div class="addon-card">
                                            <div class="addon-icon">
                                                <i class="bi bi-cup-hot"></i>
                                            </div>
                                            <h5>Royal Breakfast Package</h5>
                                            <p>Start your morning with our signature gourmet breakfast buffet featuring
                                                fresh
                                                artisan dishes.</p>
                                            <div class="addon-price">+&#8377; 1,200 per person</div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                                        <div class="addon-card">
                                            <div class="addon-icon">
                                                <i class="bi bi-flower1"></i>
                                            </div>
                                            <h5>Luxury Spa Access</h5>
                                            <p>Enjoy unlimited access to our heated hydrotherapy pool and organic sauna
                                                facilities.
                                            </p>
                                            <div class="addon-price">+&#8377; 2,500 per day</div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="350">
                                        <div class="addon-card">
                                            <div class="addon-icon">
                                                <i class="bi bi-car-front-fill"></i>
                                            </div>
                                            <h5>VIP Airport Transfer</h5>
                                            <p>Private luxury sedan transfer to and from the airport with personal
                                                concierge.</p>
                                            <div class="addon-price">+&#8377; 1,500 round trip</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                    </div>
                </section>

            </ItemTemplate>
        </asp:Repeater>
        <!-- Repeater End -->

        <!-- Quick Inquiry Modal -->
        <div class="modal fade" id="inquiryModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <div class="modal-header text-white py-3 px-4"
                        style="background: linear-gradient(135deg, #442305 0%, #9A724E 100%);">
                        <h5 class="modal-title font-serif fw-bold text-white"><i
                                class="bi bi-door-open-fill text-warning me-2"></i> Reserve Room Inquiry</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 bg-white font-sans">
                        <div class="inquiry-form">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-uppercase text-muted">Full Name *</label>
                                <input type="text" class="form-control rounded-3 p-2.5 shadow-none" required
                                    placeholder="e.g. Vikramaditya Singh">
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-uppercase text-muted">Mobile Number
                                    *</label>
                                <input type="tel" class="form-control rounded-3 p-2.5 shadow-none" required
                                    placeholder="+91 98765 43210">
                            </div>
                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="form-label small fw-bold text-uppercase text-muted">Check-In *</label>
                                    <input type="date" class="form-control rounded-3 p-2 shadow-none" required>
                                </div>
                                <div class="col-6">
                                    <label class="form-label small fw-bold text-uppercase text-muted">Check-Out
                                        *</label>
                                    <input type="date" class="form-control rounded-3 p-2 shadow-none" required>
                                </div>
                            </div>
                            <button type="button" class="btn btn-book-now w-100 py-3 rounded-pill"
                                onclick="handleInquirySubmit(event)">Submit Booking
                                Inquiry</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- External Room Details JS Script -->
        <script src="js/room-details.js"></script>

    </asp:Content>