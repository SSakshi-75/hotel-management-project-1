<%@ Page Title="Room Details | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="RoomDetails.aspx.cs" Inherits="RoomDetails" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Page Title -->
    <section class="page-title text-center" data-aos="fade-down" data-aos-duration="1000">
        <div class="container relative-z">
            <div class="page-title-badge mb-3 d-inline-flex align-items-center gap-2" data-aos="zoom-in" data-aos-delay="100">
                <i class="bi bi-stars text-gold"></i>
                <span>Royal Accommodation</span>
                <i class="bi bi-stars text-gold"></i>
            </div>
            
            <h1 class="page-title-heading" id="bannerRoomTitle" data-aos="fade-up" data-aos-delay="200">
                Executive Business Suite
            </h1>
            
            <div class="page-title-divider" data-aos="fade-up" data-aos-delay="300">
                <span class="divider-line"></span>
                <span class="divider-diamond">◆</span>
                <span class="divider-line"></span>
            </div>

            <p class="page-title-subtitle" id="bannerRoomSubtitle" data-aos="fade-up" data-aos-delay="350">
                Experience royal luxury, panoramic views, and world-class butler service tailored for your stay.
            </p>

            <nav aria-label="breadcrumb" class="mt-4" data-aos="fade-up" data-aos-delay="400">
                <ol class="breadcrumb page-title-breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="Default.aspx"><i class="bi bi-house-door-fill me-1"></i> Home</a></li>
                    <li class="breadcrumb-item"><a href="Room.aspx">Rooms &amp; Suites</a></li>
                    <li class="breadcrumb-item active" id="breadcrumbRoomName" aria-current="page">Executive Business Suite</li>
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
                            <img id="headerMainImg" src="images/room-mini-business.jpg" loading="lazy" alt="Deluxe Suite"
                                class="img-fluid rounded">
                            <div class="room-badge">
                                <span class="text-white" id="headerCategoryBadge">Premium Suite</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5" data-aos="fade-left" data-aos-delay="300">
                        <div class="room-header-content">
                            <div class="room-rating mb-3" data-aos="fade-up" data-aos-delay="350">
                                <span class="rating-score">4.9</span>
                                <div class="stars">
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                    <i class="bi bi-star-fill"></i>
                                </div>
                                <span class="reviews-count">(128 verified reviews)</span>
                            </div>
                            <h1 class="room-title" id="roomTitle" data-aos="fade-up" data-aos-delay="400">Executive
                                Business Suite</h1>
                            <p class="room-tagline" id="roomTagline" data-aos="fade-up" data-aos-delay="450">Experience
                                royal luxury with breathtaking city vistas and premium handcrafted amenities</p>

                            <div class="room-capacity mb-4" data-aos="fade-up" data-aos-delay="500">
                                <div class="capacity-item">
                                    <i class="bi bi-people-fill"></i>
                                    <span>Up to 2 guests</span>
                                </div>
                                <div class="capacity-item">
                                    <i class="bi bi-aspect-ratio-fill"></i>
                                    <span>55 m² / 592 sq ft</span>
                                </div>
                                <div class="capacity-item">
                                    <i class="bi bi-badge-hd-fill"></i>
                                    <span>King Emperor Bed</span>
                                </div>
                            </div>

                            <div class="room-price" data-aos="fade-up" data-aos-delay="550">
                                <span class="price-amount" id="roomPrice">&#8377; 8,500</span>
                                <span class="price-period">per night</span>
                            </div>

                            <div data-aos="fade-up" data-aos-delay="600">
                                <a href="Booking.aspx" class="btn btn-book-now">
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
                            <img id="galleryMainPhoto" src="images/room-mini-business.jpg" loading="lazy" alt="Suite Interior"
                                class="img-fluid" onclick="swapGallery(this)">
                        </div>
                        <div class="gallery-thumbnails">
                            <img src="images/room-classic-double.jpg" loading="lazy" alt="Bedroom View" class="img-fluid"
                                data-aos="fade-up" data-aos-delay="350" onclick="swapGallery(this)">
                            <img src="images/room-superior-king.jpg" loading="lazy" alt="Living Area" class="img-fluid"
                                data-aos="fade-up" data-aos-delay="400" onclick="swapGallery(this)">
                            <img src="images/room-luxury-penthouse.jpg" loading="lazy" alt="City View" class="img-fluid"
                                data-aos="fade-up" data-aos-delay="450" onclick="swapGallery(this)">
                            <img src="images/room-mini-garden.jpg" loading="lazy" alt="Bathroom" class="img-fluid" data-aos="fade-up"
                                data-aos-delay="500" onclick="swapGallery(this)">
                        </div>
                    </div>
                </div>

                <!-- 3. Room Description -->
                <div class="row mb-5">
                    <div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">
                        <div class="room-description">
                            <h3 class="section-subtitle mb-4">Room Overview</h3>
                            <p>Indulge in the ultimate luxury experience with our handcrafted Suite. This spacious
                                retreat features floor-to-ceiling soundproof windows showcasing panoramic skyline
                                vistas, creating a serene atmosphere perfect for business leaders or leisure travelers.
                                The elegantly appointed living space seamlessly blends modern ergonomic comfort with
                                royal heritage charm, featuring premium teakwood furnishings and thoughtful design
                                elements.</p>
                            <p>The suite includes a dedicated executive workstation with high-speed Wi-Fi, a private sun
                                balcony where you can enjoy morning espresso, and an Italian marble bathroom with
                                rainfall shower. The bedroom features a plush emperor-size bed with 400-thread-count
                                Egyptian cotton linens, ensuring a restful night's sleep.</p>
                        </div>
                    </div>
                    <div class="col-lg-4" data-aos="fade-left" data-aos-delay="300">
                        <div class="highlight-box">
                            <div class="highlight-icon">
                                <i class="bi bi-star-fill"></i>
                            </div>
                            <h4>Premium Experience</h4>
                            <p>"The most beautiful suite we've ever stayed in. The skyline view is absolutely
                                breathtaking and the attention to detail is remarkable."</p>
                            <div class="quote-author">
                                <span>- Vikramaditya S., Verified Guest</span>
                            </div>
                        </div>
                    </div>
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
                            <button class="nav-link active" id="room-details-policies-tab" data-bs-toggle="tab"
                                data-bs-target="#room-details-policies" type="button" role="tab"
                                aria-selected="true">Policies</button>
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
                                <p>Start your morning with our signature gourmet breakfast buffet featuring fresh
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
                                <p>Enjoy unlimited access to our heated hydrotherapy pool and organic sauna facilities.
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
                                <p>Private luxury sedan transfer to and from the airport with personal concierge.</p>
                                <div class="addon-price">+&#8377; 1,500 round trip</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 7. Booking CTA Section -->
                <div id="booking-cta" class="booking-cta" data-aos="fade-up" data-aos-delay="200">
                    <div class="booking-card">
                        <div class="row align-items-center">
                            <div class="col-lg-7 mb-4 mb-lg-0">
                                <h4>Ready to book your stay?</h4>
                                <p>Experience luxury and comfort in our handcrafted suite. Reserve now and create
                                    unforgettable memories.</p>
                            </div>
                            <div class="col-lg-5 text-center text-lg-end">
                                <div class="price-display">
                                    <span class="price" id="ctaPrice">&#8377; 8,500</span>
                                    <span class="period">per night</span>
                                </div>
                                <button type="button" class="btn btn-book-now px-5 py-3 shadow"
                                    onclick="openReserveModal()">
                                    <i class="bi bi-check-circle-fill me-2"></i> Check Availability
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

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
                        <form onsubmit="handleInquirySubmit(event)">
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
                            <button type="submit" class="btn btn-book-now w-100 py-3 rounded-pill">Submit Booking
                                Inquiry</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- External Room Details JS Script -->
        <script src="js/room-details.js"></script>

    </asp:Content>