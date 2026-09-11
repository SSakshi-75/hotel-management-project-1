<%@ Page Title="Amenities & Services | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Services.aspx.cs" Inherits="Services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
    <section class="amenities-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-stars me-1 text-warning"></i> 5-Star Royal Facilities
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Amenities</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Amenities</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. MAIN AMENITIES CARDS SECTION
         ========================================== -->
    <section class="py-5 bg-light">
        <div class="container py-3 px-3 px-lg-5">
            
            <!-- Row 1: Infinity Pool & Luxury Spa -->
            <div class="row g-4 mb-4">
                
                <!-- Card 1: Infinity Pool & Sun Deck -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="amenity-card">
                        <div class="amenity-card-img-wrap">
                            <img src="images/amenity-pool.jpg" loading="lazy" alt="Infinity Pool & Sun Deck" class="amenity-card-img">
                        </div>
                        <div class="amenity-card-body">
                            <h3 class="amenity-card-title">Infinity Pool &amp; Sun Deck</h3>
                            <p class="amenity-card-desc">
                                Unwind in our temperature-controlled rooftop infinity pool offering panoramic views of New Delhi skyline. Enjoy handcrafted cocktails, fresh juices, and gourmet poolside snacks served directly to your private sun lounger.
                            </p>
                            <ul class="amenity-feature-list">
                                <li class="amenity-feature-item">
                                    <i class="bi bi-clock"></i>
                                    <span>Open 6 AM - 10 PM</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-droplet"></i>
                                    <span>Heated pool year-round</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-cup-hot"></i>
                                    <span>Poolside bar service</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Luxury Spa & Wellness -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="amenity-card">
                        <div class="amenity-card-img-wrap">
                            <img src="images/amenity-spa.jpg" loading="lazy" alt="Luxury Spa & Wellness" class="amenity-card-img">
                        </div>
                        <div class="amenity-card-body">
                            <h3 class="amenity-card-title">Luxury Spa &amp; Wellness</h3>
                            <p class="amenity-card-desc">
                                Rejuvenate your mind, body, and soul with signature Ayurvedic therapies, holistic massage treatments, and soothing aroma steam baths administered by certified wellness therapists.
                            </p>
                            <ul class="amenity-feature-list">
                                <li class="amenity-feature-item">
                                    <i class="bi bi-calendar-event"></i>
                                    <span>Book treatments online</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-suit-heart"></i>
                                    <span>Couples massage rooms</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-flower1"></i>
                                    <span>Organic spa products</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Row 2: Signature Restaurant & 24/7 Fitness Center -->
            <div class="row g-4 mb-5">
                
                <!-- Card 3: Signature Restaurant -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="amenity-card">
                        <div class="amenity-card-img-wrap">
                            <img src="images/amenity-restaurant.jpg" loading="lazy" alt="Signature Restaurant" class="amenity-card-img">
                        </div>
                        <div class="amenity-card-body">
                            <h3 class="amenity-card-title">Signature Restaurant</h3>
                            <p class="amenity-card-desc">
                                Indulge in a culinary journey featuring authentic Royal Indian delicacies alongside international fine dining creations, expertly prepared by our Michelin-acclaimed executive chefs.
                            </p>
                            <ul class="amenity-feature-list">
                                <li class="amenity-feature-item">
                                    <i class="bi bi-award"></i>
                                    <span>Michelin-starred chef</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-cup-straw"></i>
                                    <span>Award-winning wine cellar</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-moon-stars"></i>
                                    <span>Open Tuesday - Sunday</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Card 4: 24/7 Fitness Center -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="amenity-card">
                        <div class="amenity-card-img-wrap">
                            <img src="images/amenity-fitness.jpg" loading="lazy" alt="24/7 Fitness Center" class="amenity-card-img">
                        </div>
                        <div class="amenity-card-body">
                            <h3 class="amenity-card-title">24/7 Fitness Center</h3>
                            <p class="amenity-card-desc">
                                Maintain your fitness routine with top-of-the-line Technogym cardio machines, free weight stations, and private yoga sessions guided by expert personal trainers.
                            </p>
                            <ul class="amenity-feature-list">
                                <li class="amenity-feature-item">
                                    <i class="bi bi-lightning-charge"></i>
                                    <span>State-of-the-art equipment</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-person"></i>
                                    <span>Personal trainers available</span>
                                </li>
                                <li class="amenity-feature-item">
                                    <i class="bi bi-shield-check"></i>
                                    <span>Complimentary towels</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>

            <!-- ==========================================
                 3. ADDITIONAL HOTEL SERVICES GRID (MATCHING IMAGE 3)
                 ========================================== -->
            <div class="additional-services-wrapper" data-aos="fade-up" data-aos-delay="200">
                <h2 class="additional-services-title">Additional Hotel Services</h2>
                
                <div class="row g-4 justify-content-center">
                    
                    <!-- Item 1: Free Wi-Fi -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-wifi"></i>
                            </div>
                            <h4 class="service-item-title">Free Wi-Fi</h4>
                            <p class="service-item-desc">High-speed internet throughout the property</p>
                        </div>
                    </div>

                    <!-- Item 2: Valet Parking -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="fa-solid fa-car"></i>
                            </div>
                            <h4 class="service-item-title">Valet Parking</h4>
                            <p class="service-item-desc">Complimentary valet service for all guests</p>
                        </div>
                    </div>

                    <!-- Item 3: Airport Shuttle -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="fa-solid fa-plane"></i>
                            </div>
                            <h4 class="service-item-title">Airport Shuttle</h4>
                            <p class="service-item-desc">Scheduled transfers to major airports</p>
                        </div>
                    </div>

                    <!-- Item 4: Concierge -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-headset"></i>
                            </div>
                            <h4 class="service-item-title">Concierge</h4>
                            <p class="service-item-desc">24/7 assistance for reservations and tours</p>
                        </div>
                    </div>

                    <!-- Item 5: Room Service -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-bell"></i>
                            </div>
                            <h4 class="service-item-title">Room Service</h4>
                            <p class="service-item-desc">Gourmet dining delivered to your room</p>
                        </div>
                    </div>

                    <!-- Item 6: Safe Deposit -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-shield-check"></i>
                            </div>
                            <h4 class="service-item-title">Safe Deposit</h4>
                            <p class="service-item-desc">Secure storage for your valuables</p>
                        </div>
                    </div>

                    <!-- Item 7: Multilingual Staff -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-translate"></i>
                            </div>
                            <h4 class="service-item-title">Multilingual Staff</h4>
                            <p class="service-item-desc">Service in English, Spanish, French, and more</p>
                        </div>
                    </div>

                    <!-- Item 8: Pet Friendly -->
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="service-grid-item">
                            <div class="service-icon-circle">
                                <i class="bi bi-heart-pulse"></i>
                            </div>
                            <h4 class="service-item-title">Pet Friendly</h4>
                            <p class="service-item-desc">Welcome amenities for your furry friends</p>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </section>

</asp:Content>
