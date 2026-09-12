<%@ Page Title="Special Offers & Packages | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Offers.aspx.cs" Inherits="Offers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION (OFFERS & PROMOTIONS)
         ========================================== -->
    <section class="room-compact-hero text-white text-center">
        <div class="container py-2 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                <i class="bi bi-gift-fill me-1 text-warning"></i> Exclusive Stays &amp; Privileges
            </span>
            <h1 class="display-4 font-serif fw-bold text-white mb-2">Special Offers &amp; Packages</h1>
            <p class="text-champagne-gold fs-5 mb-0 font-serif">
                Handcrafted Getaways, Culinary Inclusions &amp; Celebratory Experiences
            </p>
        </div>
    </section>

    <!-- ==========================================
         2. BREADCRUMB & INTRO
         ========================================== -->
    <div class="container px-4 px-lg-5 pt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb page-title-breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="index.aspx"><i class="bi bi-house-door-fill me-1"></i> Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Special Offers</li>
            </ol>
        </nav>
    </div>

    <!-- ==========================================
         3. CATEGORY FILTER TABS
         ========================================== -->
    <section class="py-4">
        <div class="container px-4 px-lg-5">
            <div class="offer-filter-wrapper" data-aos="fade-up" data-aos-duration="800">
                <button type="button" class="offer-filter-btn active" onclick="filterOffers('all', this)">
                    <i class="bi bi-grid-fill me-1"></i> All Offers
                </button>
                <button type="button" class="offer-filter-btn" onclick="filterOffers('stay', this)">
                    <i class="bi bi-building me-1"></i> Stay
                </button>
                <button type="button" class="offer-filter-btn" onclick="filterOffers('dining', this)">
                    <i class="bi bi-cup-hot-fill me-1"></i> Dining
                </button>
                <button type="button" class="offer-filter-btn" onclick="filterOffers('family', this)">
                    <i class="bi bi-people-fill me-1"></i> Family
                </button>
                <button type="button" class="offer-filter-btn" onclick="filterOffers('weekend', this)">
                    <i class="bi bi-calendar-heart me-1"></i> Weekend
                </button>
            </div>
        </div>
    </section>

    <!-- ==========================================
         4. OFFERS GRID SECTION
         ========================================== -->
    <section class="pb-5">
        <div class="container px-4 px-lg-5">
            <div class="row g-4 justify-content-center" id="offersGridContainer">

                <!-- Offer Card 1: Breakfast Included (Category: stay) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="stay" data-aos="fade-up" data-aos-delay="100">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/amenity-restaurant.jpg" loading="lazy" alt="Breakfast Inclusive Offer">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-star-fill text-warning"></i> Best Value
                            </span>
                            <span class="offer-card-validity-pill">Daily Inclusions</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Stay &amp; Dining</span>
                                <h3 class="offer-card-title">Breakfast Inclusive Offer</h3>
                                <p class="offer-card-desc">
                                    Start every morning with an opulent chef's breakfast spread, artisanal bakery treats, live egg stations, and premium coffees.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> Breakfast for 2 Guests Daily</li>
                                    <li><i class="bi bi-check-circle-fill"></i> High-Speed Wi-Fi &amp; Parking</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Complimentary Welcome Drink</li>
                                    <li><i class="bi bi-check-circle-fill"></i> 24/7 Concierge Service</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Starting From</span>
                                    <span class="offer-price-val" data-inr-price="4999">&#8377;4,999 <span class="period">/ night</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=breakfast-included" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offer Card 2: Weekend Getaway (Category: weekend) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="weekend" data-aos="fade-up" data-aos-delay="200">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/amenity-pool.jpg" loading="lazy" alt="Weekend Royal Getaway">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-calendar-heart text-warning"></i> Weekend Special
                            </span>
                            <span class="offer-card-validity-pill">Fri, Sat &amp; Sun</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Weekend Leisure</span>
                                <h3 class="offer-card-title">Weekend Royal Getaway</h3>
                                <p class="offer-card-desc">
                                    Recharge in tranquil bliss with pool cabana access, authentic afternoon high tea service, and special savings on spa treatments.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> Royal Afternoon High Tea</li>
                                    <li><i class="bi bi-check-circle-fill"></i> 20% Savings on Jiva Luxury Spa</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Heated Swimming Pool Cabana</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Guaranteed 2:00 PM Late Checkout</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Starting From</span>
                                    <span class="offer-price-val" data-inr-price="5499">&#8377;5,499 <span class="period">/ night</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=weekend-getaway" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offer Card 3: Long Stay Offer (Category: stay) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="stay" data-aos="fade-up" data-aos-delay="300">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/room-featured-presidential.jpg" loading="lazy" alt="Long Stay Offer">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-percent text-warning"></i> Extended Stay
                            </span>
                            <span class="offer-card-validity-pill">Min 3 Nights</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Extended Stay</span>
                                <h3 class="offer-card-title">Long Stay Offer (Save 20%)</h3>
                                <p class="offer-card-desc">
                                    Enjoy greater value the longer you stay. Book 3 nights or more and receive a 20% discount plus private airport chauffeur transfer.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> 20% Flat Discount on Entire Stay</li>
                                    <li><i class="bi bi-check-circle-fill"></i> One-Way Airport Chauffeur Pickup</li>
                                    <li><i class="bi bi-check-circle-fill"></i> 4 Pcs Laundry Cleaned Daily</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Executive Club Lounge Access</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Special Discount</span>
                                    <span class="offer-price-val" style="color: #B88E68;">20% OFF <span class="period">/ stay</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=long-stay" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offer Card 4: Imperial Dine & Stay (Category: dining) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="dining" data-aos="fade-up" data-aos-delay="150">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/item1.jpg" loading="lazy" alt="Imperial Dine & Stay Package">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-cup-straw text-warning"></i> Gourmet Package
                            </span>
                            <span class="offer-card-validity-pill">Dinner &amp; Breakfast</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Dining &amp; Culinary</span>
                                <h3 class="offer-card-title">Imperial Dine &amp; Stay Package</h3>
                                <p class="offer-card-desc">
                                    An extraordinary culinary escape with a 4-course candlelight dinner at The Imperial Spice and fine sommelier wine.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> 4-Course Chef Candlelight Dinner</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Complimentary Bottle of Wine</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Lavish Buffet Breakfast for 2</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Priority Restaurant Seating</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Starting From</span>
                                    <span class="offer-price-val" data-inr-price="6999">&#8377;6,999 <span class="period">/ night</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=dine-and-stay" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offer Card 5: Royal Family Vacation (Category: family) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="family" data-aos="fade-up" data-aos-delay="250">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/room-mini-family.jpg" loading="lazy" alt="Royal Family Vacation Suite">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-heart-fill text-warning"></i> Family Fun
                            </span>
                            <span class="offer-card-validity-pill">Kids Stay Free</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Family Vacation</span>
                                <h3 class="offer-card-title">Royal Family Vacation Package</h3>
                                <p class="offer-card-desc">
                                    Spacious interconnecting luxury suites with kids eat free benefits, board games, and an educational Delhi heritage monument tour.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> Kids Under 12 Stay &amp; Dine Free</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Complimentary Extra Rollaway Bed</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Heritage Monument Sightseeing Pass</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Kids Surprise Welcome Goodie Bag</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Starting From</span>
                                    <span class="offer-price-val" data-inr-price="8499">&#8377;8,499 <span class="period">/ night</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=family-holiday" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Offer Card 6: Romantic Celebration (Category: stay weekend) -->
                <div class="col-lg-4 col-md-6 col-12 offer-item-col" data-category="stay weekend" data-aos="fade-up" data-aos-delay="350">
                    <div class="special-offer-card">
                        <div class="offer-card-img-wrap">
                            <img src="images/room-luxury-penthouse.jpg" loading="lazy" alt="Romantic Celebration Escape">
                            <span class="offer-card-overlay-badge">
                                <i class="bi bi-stars text-warning"></i> Romantic Haven
                            </span>
                            <span class="offer-card-validity-pill">Honeymoon &amp; Anniv</span>
                        </div>
                        <div class="offer-card-body">
                            <div>
                                <span class="offer-card-category">Celebrations &amp; Romance</span>
                                <h3 class="offer-card-title">Romantic Celebration Escape</h3>
                                <p class="offer-card-desc">
                                    Celebrate anniversaries and romance with rose petal suite decor, chilled champagne, couple aromatherapy spa, and balcony dinner.
                                </p>
                                <ul class="offer-inclusions-list">
                                    <li><i class="bi bi-check-circle-fill"></i> 60-Min Couple Aromatherapy Spa</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Chilled Sparkling Wine &amp; Cake</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Private Candlelight Balcony Dinner</li>
                                    <li><i class="bi bi-check-circle-fill"></i> Floating Champagne Breakfast</li>
                                </ul>
                            </div>
                            <div class="offer-card-footer">
                                <div class="offer-price-box">
                                    <span class="offer-price-label">Starting From</span>
                                    <span class="offer-price-val" data-inr-price="12999">&#8377;12,999 <span class="period">/ night</span></span>
                                </div>
                                <a href="OfferDetails.aspx?id=romantic-escape" class="btn-offer-view">
                                    <span>View Offer Details</span>
                                    <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ==========================================
         5. DIRECT RESERVATION TRUST BANNER
         ========================================== -->
    <section class="py-5 bg-white border-top border-bottom">
        <div class="container px-4 px-lg-5">
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="p-3">
                        <i class="bi bi-shield-check fs-1" style="color: #B88E68;"></i>
                        <h4 class="font-serif fw-bold mt-2 mb-1" style="color: #442305;">Best Rate Guarantee</h4>
                        <p class="small text-muted mb-0">Always receive the lowest verified rates when booking directly on our official website.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3">
                        <i class="bi bi-lightning-charge-fill fs-1" style="color: #B88E68;"></i>
                        <h4 class="font-serif fw-bold mt-2 mb-1" style="color: #442305;">Instant Confirmation</h4>
                        <p class="small text-muted mb-0">Immediate digital confirmation voucher with zero hidden convenience fees or markups.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3">
                        <i class="bi bi-arrow-repeat fs-1" style="color: #B88E68;"></i>
                        <h4 class="font-serif fw-bold mt-2 mb-1" style="color: #442305;">Flexible Cancellation</h4>
                        <p class="small text-muted mb-0">Enjoy stress-free travel plans with free cancellation up to 48 hours prior to arrival.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         FILTER JAVASCRIPT LOGIC
         ========================================== -->
    <script>
        function filterOffers(category, btn) {
            // Update active state on buttons
            var buttons = document.querySelectorAll('.offer-filter-btn');
            buttons.forEach(function (b) {
                b.classList.remove('active');
            });
            if (btn) {
                btn.classList.add('active');
            }

            // Filter cards
            var cards = document.querySelectorAll('.offer-item-col');
            cards.forEach(function (card) {
                var cardCat = card.getAttribute('data-category') || '';
                if (category === 'all' || cardCat.indexOf(category) !== -1) {
                    card.style.display = 'block';
                    card.classList.add('animate__animated', 'animate__fadeIn');
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>

</asp:Content>
