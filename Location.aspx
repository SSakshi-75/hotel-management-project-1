<%@ Page Title="Hotel Location & Map | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Location.aspx.cs" Inherits="Location" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
    <section class="location-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-geo-alt-fill me-1 text-warning"></i> Prime Diplomatic Location
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Our Location</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Location</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. LOCATION & MAP SECTION (MATCHING WEBSITE THEME)
         ========================================== -->
    <section class="py-5 bg-light">
        <div class="container py-4 px-3 px-lg-5">
            <div class="row g-5 align-items-center">

                <!-- Left Column: Details & Information Grid -->
                <div class="col-lg-6">
                    
                    <!-- Prime Location Badge -->
                    <div class="mb-3" data-aos="fade-down" data-aos-duration="800">
                        <span class="location-prime-badge rounded-pill">
                            <i class="bi bi-geo-alt-fill"></i> Prime Location
                        </span>
                    </div>

                    <!-- Main Heading with Animation & Website Gold Accent -->
                    <h2 class="display-4 location-heading-title mb-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="150" style="font-family: 'Cormorant Upright', 'Playfair Display', serif; color: #442305; font-weight: 700;">
                        Luxury Downtown <span style="color: #9A724E;">Experience</span>
                    </h2>

                    <!-- Description Matching Website Standard Body Text Color -->
                    <p class="mb-4 pe-lg-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="250" style="color: #475569; font-family: 'Plus Jakarta Sans', sans-serif; font-size: 0.98rem; line-height: 1.8;">
                        Nestled in the prestigious diplomatic enclave of Chanakyapuri, New Delhi, our luxury hotel offers a serene sanctuary with effortless access to international embassies, cultural landmarks, high-end shopping, and major transport hubs.
                    </p>

                    <!-- 2x2 Grid of Location Information Cards -->
                    <div class="row g-3 mb-4">
                        
                        <!-- Card 1: Address -->
                        <div class="col-sm-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                            <div class="location-info-card">
                                <div class="location-icon-box">
                                    <i class="bi bi-building"></i>
                                </div>
                                <div>
                                    <h4 class="location-info-title">Address</h4>
                                    <p class="location-info-txt">
                                        Chanakyapuri, Diplomatic Enclave,<br>
                                        New Delhi, Delhi 110021, India
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Card 2: Airport Access -->
                        <div class="col-sm-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                            <div class="location-info-card">
                                <div class="location-icon-box">
                                    <i class="bi bi-airplane-fill"></i>
                                </div>
                                <div>
                                    <h4 class="location-info-title">Airport Access</h4>
                                    <p class="location-info-txt">
                                        IGI Airport (DEL) - 20 min<br>
                                        New Delhi Railway - 15 min
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Card 3: Contact -->
                        <div class="col-sm-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="500">
                            <div class="location-info-card">
                                <div class="location-icon-box">
                                    <i class="bi bi-telephone-fill"></i>
                                </div>
                                <div>
                                    <h4 class="location-info-title">Contact</h4>
                                    <p class="location-info-txt">
                                        +91 11 3933 1234<br>
                                        <span class="text-break d-inline-block">info@hotelmanagement.com</span>
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- Card 4: Check-in -->
                        <div class="col-sm-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="600">
                            <div class="location-info-card">
                                <div class="location-icon-box">
                                    <i class="bi bi-clock-fill"></i>
                                </div>
                                <div>
                                    <h4 class="location-info-title">Check-in</h4>
                                    <p class="location-info-txt">
                                        3:00 PM - 11:00 PM<br>
                                        Check-out: 11:00 AM
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex flex-wrap align-items-center gap-3 pt-2" data-aos="fade-up" data-aos-duration="800" data-aos-delay="700">
                        <a href="#googleMapContainer" class="btn btn-location-map rounded-pill">View on Map</a>
                        <a href="Booking.aspx" class="btn btn-location-book rounded-pill">Book Now</a>
                    </div>

                </div>

                <!-- Right Column: Interactive Map with Floating Badge -->
                <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000" id="googleMapContainer">
                    <div class="map-card-wrapper">
                        
                        <!-- Floating Hotel Badge over Map -->
                        <div class="map-floating-hotel-badge shadow">
                            <i class="bi bi-building"></i> Hotel Management Luxury Resort
                        </div>

                        <!-- Google Maps Iframe -->
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin" 
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade" 
                            title="Hotel Location Map">
                        </iframe>

                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ==========================================
         3. GETTING HERE IS EASY SECTION (MATCHING NEW SCREENSHOT)
         ========================================== -->
    <section class="py-5 bg-white border-top">
        <div class="container py-4 px-3 px-lg-5">
            
            <!-- Centered Header -->
            <div class="text-center mb-5" data-aos="fade-up" data-aos-duration="1000">
                <h2 class="display-4 font-serif fw-bold mb-2" style="color: #442305;">
                    Getting Here is Easy
                </h2>
                <p class="fs-6 mb-0 font-serif" style="color: #9A724E; font-family: 'Cormorant Upright', 'Playfair Display', serif; font-size: 1.15rem; font-weight: 600; letter-spacing: 0.5px;">
                    Multiple Convenient Transportation Options To Reach Our Hotel
                </p>
            </div>

            <!-- 2x2 Grid of Transport Cards -->
            <div class="row g-4">

                <!-- Card 1: By Car -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                    <div class="transport-card">
                        <div class="transport-header">
                            <div class="transport-icon-box">
                                <i class="fa-solid fa-car"></i>
                            </div>
                            <div>
                                <h3 class="transport-title">By Car</h3>
                                <span class="transport-subtag">Most Convenient</span>
                            </div>
                        </div>
                        <p class="transport-desc">
                            Complimentary valet service available. Premium parking garage with direct hotel access and EV charging stations.
                        </p>
                        <div class="transport-tags">
                            <span class="transport-tag-pill">Valet Service</span>
                            <span class="transport-tag-pill">EV Charging</span>
                        </div>
                    </div>
                </div>

                <!-- Card 2: By Metro -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                    <div class="transport-card">
                        <div class="transport-header">
                            <div class="transport-icon-box">
                                <i class="fa-solid fa-train"></i>
                            </div>
                            <div>
                                <h3 class="transport-title">By Metro</h3>
                                <span class="transport-subtag">5 min walk</span>
                            </div>
                        </div>
                        <p class="transport-desc">
                            Lok Kalyan Marg Metro Station (Yellow Line) directly connects to all major lines, New Delhi Railway Station &amp; Airport Express.
                        </p>
                        <div class="transport-tags">
                            <span class="transport-tag-pill">Yellow Line</span>
                            <span class="transport-tag-pill">Express Link</span>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Airport Shuttle -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                    <div class="transport-card">
                        <div class="transport-header">
                            <div class="transport-icon-box">
                                <i class="fa-solid fa-plane"></i>
                            </div>
                            <div>
                                <h3 class="transport-title">Airport Shuttle</h3>
                                <span class="transport-subtag">Every 30 min</span>
                            </div>
                        </div>
                        <p class="transport-desc">
                            Luxury shuttle service to both major airport terminals. Premium comfort with WiFi, refreshments, and luggage assistance included.
                        </p>
                        <div class="transport-tags">
                            <span class="transport-tag-pill">WiFi</span>
                            <span class="transport-tag-pill">Refreshments</span>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Ride Share -->
                <div class="col-lg-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                    <div class="transport-card">
                        <div class="transport-header">
                            <div class="transport-icon-box">
                                <i class="fa-solid fa-taxi"></i>
                            </div>
                            <div>
                                <h3 class="transport-title">Ride Share</h3>
                                <span class="transport-subtag">24/7 Available</span>
                            </div>
                        </div>
                        <p class="transport-desc">
                            Dedicated pickup zones for all ride-sharing services. Professional concierge assistance for booking and special requests.
                        </p>
                        <div class="transport-tags">
                            <span class="transport-tag-pill">Concierge Help</span>
                            <span class="transport-tag-pill">Express Pickup</span>
                        </div>
                    </div>
                </div>

            </div>

    </section>

    <!-- ==========================================
         4. EXPLORE THE NEIGHBORHOOD SECTION (MATCHING SCREENSHOT)
         ========================================== -->
    <section class="py-5 bg-light border-top">
        <div class="container py-4 px-3 px-lg-5">
            
            <!-- Centered Header -->
            <div class="text-center mb-5" data-aos="fade-up" data-aos-duration="1000">
                <h2 class="display-4 font-serif fw-bold mb-2" style="color: #442305;">
                    Explore the Neighborhood
                </h2>
                <p class="fs-6 mb-0 font-serif" style="color: #9A724E; font-family: 'Cormorant Upright', 'Playfair Display', serif; font-size: 1.15rem; font-weight: 600; letter-spacing: 0.5px;">
                    World-class attractions and entertainment right at your doorstep
                </p>
            </div>

            <!-- 6 Grid Items (3 Columns x 2 Rows) -->
            <div class="row g-4">

                <!-- Card 1: India Gate -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 2.5 km</span>
                            <img src="images/neighborhood-indiagate.jpg" loading="lazy" alt="India Gate" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">India Gate</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 7 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                Historic war memorial and grand ceremonial boulevard surrounded by lush lawns and fountains.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Rashtrapati Bhavan -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 1.8 km</span>
                            <img src="images/neighborhood-rashtrapati.jpg" loading="lazy" alt="Rashtrapati Bhavan" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">Rashtrapati Bhavan</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 5 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                The official residence of the President of India featuring famous gardens and colonial architecture.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 3: Lodhi Garden -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 3.2 km</span>
                            <img src="images/neighborhood-lodhigarden.jpg" loading="lazy" alt="Lodhi Garden" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">Lodhi Garden</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 8 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                Serene 90-acre city park containing 15th-century Sayyid and Lodi tombs surrounded by pristine greenery.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Humayun's Tomb -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 5.0 km</span>
                            <img src="images/neighborhood-humayuntomb.jpg" loading="lazy" alt="Humayun's Tomb" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">Humayun's Tomb</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 12 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                UNESCO World Heritage site and magnificent precursor to the Taj Mahal with Persian garden design.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 5: National Rail Museum -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="500">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 1.0 km</span>
                            <img src="images/neighborhood-railmuseum.jpg" loading="lazy" alt="National Rail Museum" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">National Rail Museum</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 3 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                Located right in Chanakyapuri, showcasing 160+ years of Indian railways with vintage royal carriages.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 6: Khan Market -->
                <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-duration="800" data-aos-delay="600">
                    <div class="neighborhood-card">
                        <div class="neighborhood-img-wrap">
                            <span class="neighborhood-dist-pill"><i class="bi bi-geo-alt-fill"></i> 3.5 km</span>
                            <img src="images/neighborhood-khanmarket.jpg" loading="lazy" alt="Khan Market" class="neighborhood-img">
                        </div>
                        <div class="neighborhood-body">
                            <h3 class="neighborhood-title">Khan Market</h3>
                            <div class="neighborhood-time-tag">
                                <i class="bi bi-clock"></i> 10 minute drive
                            </div>
                            <p class="neighborhood-desc">
                                Exclusive high-end shopping district featuring luxury boutiques, artisan cafes, and gourmet restaurants.
                            </p>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </section>

</asp:Content>
