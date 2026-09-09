<%@ Page Title="About Us | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="About.aspx.cs" Inherits="About" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
         ABOUT HERO BANNER
         ========================================== -->
        <section class="about-hero-section text-white text-center">
            <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
                <span class="about-intro-badge mb-3 d-inline-block">
                    <i class="bi bi-shield-check me-1 text-warning"></i> 25+ Years Of Hotel Excellence
                </span>
                <h1 class="display-3 font-serif fw-bold text-white mb-3">About Our Heritage</h1>
                <p class="text-champagne-gold fs-5 mb-0 font-serif">Discover Our Story, Values &amp; Royal Hospitality
                    Philosophy</p>
            </div>
        </section>

        <!-- ==========================================
         KEY STATISTICS COUNTER STRIP
         ========================================== -->
        <div class="container px-4 px-lg-5 about-counter-section">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-3 col-md-6 col-6" data-aos="fade-up" data-aos-delay="100">
                    <div class="about-counter-card">
                        <div class="about-counter-icon">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                        <div class="about-counter-num">25+</div>
                        <div class="about-counter-txt">Years Of Legacy</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6" data-aos="fade-up" data-aos-delay="200">
                    <div class="about-counter-card">
                        <div class="about-counter-icon">
                            <i class="bi bi-door-open-fill"></i>
                        </div>
                        <div class="about-counter-num">180+</div>
                        <div class="about-counter-txt">Luxury Suites &amp; Villas</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6" data-aos="fade-up" data-aos-delay="300">
                    <div class="about-counter-card">
                        <div class="about-counter-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div class="about-counter-num">50K+</div>
                        <div class="about-counter-txt">Global Guests Hosted</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-6" data-aos="fade-up" data-aos-delay="400">
                    <div class="about-counter-card">
                        <div class="about-counter-icon">
                            <i class="bi bi-trophy-fill"></i>
                        </div>
                        <div class="about-counter-num">18+</div>
                        <div class="about-counter-txt">International Awards</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==========================================
         HOTEL TIMELINE & OUR STORY SECTION
         ========================================== -->
        <section id="about-story" class="py-5 bg-white">
            <div class="container-fluid px-4 px-lg-5 py-4">
                <div class="row g-5 align-items-center">

                    <!-- Left Column: Hotel Journey Timeline -->
                    <div class="col-lg-6" data-aos="fade-right" data-aos-duration="1000">
                        <div class="pe-lg-3">
                            <span class="welcome-subtitle-anim mb-2">
                                <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                                Our Journey &amp; Milestones
                            </span>
                            <h2 class="welcome-title-anim mb-4" style="text-align: left;">
                                Building A Benchmark In <span class="welcome-title-gold">Luxury Hospitality</span>
                            </h2>

                            <!-- Timeline List -->
                            <div class="about-timeline-wrap">
                                <div class="about-timeline-item">
                                    <div class="about-timeline-dot"></div>
                                    <div class="about-timeline-year">1998</div>
                                    <h4 class="about-timeline-title">Foundation In Diplomatic Enclave</h4>
                                    <p class="about-timeline-desc">Opened as a premier boutique hotel in New Delhi,
                                        setting new standards in personalized concierge service.</p>
                                </div>

                                <div class="about-timeline-item">
                                    <div class="about-timeline-dot"></div>
                                    <div class="about-timeline-year">2008</div>
                                    <h4 class="about-timeline-title">Presidential Suite &amp; Convention Expansion</h4>
                                    <p class="about-timeline-desc">Added 80 grand executive suites, fine dining halls,
                                        and state-of-the-art international banquet facilities.</p>
                                </div>

                                <div class="about-timeline-item">
                                    <div class="about-timeline-dot"></div>
                                    <div class="about-timeline-year">2018</div>
                                    <h4 class="about-timeline-title">Voted Best 5-Star Heritage Resort</h4>
                                    <p class="about-timeline-desc">Awarded the World Luxury Hotel Award for excellence
                                        in guest satisfaction, royal spa retreats, and dining.</p>
                                </div>

                                <div class="about-timeline-item">
                                    <div class="about-timeline-dot"></div>
                                    <div class="about-timeline-year">2026</div>
                                    <h4 class="about-timeline-title">Eco-Luxury &amp; Smart Suite Redesign</h4>
                                    <p class="about-timeline-desc">Integrated sustainable green energy technologies,
                                        touchless room automation, and heated infinity pools.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column: Founder's Message & Leadership Box -->
                    <div class="col-lg-6" data-aos="fade-left" data-aos-duration="1000">
                        <div class="bg-light p-4 p-md-5 rounded-4 border border-secondary border-opacity-25 shadow-sm">
                            <span
                                class="badge bg-gold-subtle text-warning-dark rounded-pill px-3 py-2 text-uppercase fw-semibold letter-spacing-1 small mb-3">
                                CEO &amp; Leadership Vision
                            </span>
                            <h3 class="font-serif fw-bold text-dark mb-3 fs-2">"True luxury is found in warmth, detail
                                &amp; serene comfort."</h3>
                            <p class="welcome-desc-text mb-4">
                                At Hotel Management, every room is crafted as a sanctuary of peace. Our mission goes
                                beyond offering a luxurious stay—we curate memories that stay with our guests forever
                                through bespoke Indian hospitality, world-class cuisine, and serene living spaces.
                            </p>

                            <div class="row g-3 mb-4">
                                <div class="col-sm-6">
                                    <div class="p-3 bg-white rounded-3 border">
                                        <h5 class="font-serif fw-bold text-dark mb-1">
                                            <i class="bi bi-shield-check text-warning me-2"></i>100% Direct Booking
                                        </h5>
                                        <p class="small text-muted mb-0">Best rate guarantee &amp; free airport
                                            transfer.</p>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="p-3 bg-white rounded-3 border">
                                        <h5 class="font-serif fw-bold text-dark mb-1">
                                            <i class="bi bi-clock-history text-warning me-2"></i>24/7 Butler Support
                                        </h5>
                                        <p class="small text-muted mb-0">Round-the-clock personal concierge service.</p>
                                    </div>
                                </div>
                            </div>

                            <!-- CEO Signature -->
                            <div class="d-flex align-items-center gap-3 pt-3 border-top">
                                <img src="images/testimonial-user1.jpg" alt="Rahul Singh"
                                    class="rounded-circle shadow-sm"
                                    style="width: 60px; height: 60px; object-fit: cover; border: 2px solid #9A724E;">
                                <div>
                                    <h4 class="font-serif fw-bold text-dark mb-0 fs-5">Rahul Singh</h4>
                                    <p class="small mb-0 fw-semibold text-uppercase letter-spacing-1"
                                        style="color: #9A724E;">Founder &amp; Chief Executive Officer</p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- ==========================================
         MISSION, VISION & CORE VALUES
         ========================================== -->
        <section id="about-mission" class="py-5" style="background: linear-gradient(180deg, #fdfbf7 0%, #ffffff 100%);">
            <div class="container-fluid px-4 px-lg-5 py-4">

                <div class="text-center mb-5" data-aos="fade-down">
                    <span class="welcome-subtitle-anim">
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        Our Hotel Principles
                    </span>
                    <h2 class="welcome-title-anim mb-2">
                        Mission, Vision &amp; <span class="welcome-title-gold">Hospitality Values</span>
                    </h2>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Mission Card -->
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="about-mission-card">
                            <div class="about-mission-header">
                                <div class="about-mission-icon">
                                    <i class="bi bi-compass-fill"></i>
                                </div>
                                <h3 class="about-mission-title">Our Mission</h3>
                            </div>
                            <p class="welcome-desc-text mb-0">
                                To provide an authentic blend of royal Indian warmth and 5-star international luxury,
                                ensuring every executive guest, couple, and family experiences absolute peace and
                                luxury.
                            </p>
                        </div>
                    </div>

                    <!-- Vision Card -->
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="about-mission-card">
                            <div class="about-mission-header">
                                <div class="about-mission-icon">
                                    <i class="bi bi-eye-fill"></i>
                                </div>
                                <h3 class="about-mission-title">Our Vision</h3>
                            </div>
                            <p class="welcome-desc-text mb-0">
                                To remain Asia's premier sanctuary of serenity, recognized globally for award-winning
                                culinary mastery, royal spa wellness, and sustainable eco-luxury hospitality.
                            </p>
                        </div>
                    </div>

                    <!-- Philosophy Card -->
                    <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="about-mission-card">
                            <div class="about-mission-header">
                                <div class="about-mission-icon">
                                    <i class="bi bi-gem"></i>
                                </div>
                                <h3 class="about-mission-title">Core Philosophy</h3>
                            </div>
                            <p class="welcome-desc-text mb-0">
                                Uncompromising perfection in detail—from handcrafted Egyptian cotton linens to 24/7
                                dedicated butler assistance and organic farm-to-table gourmet dining.
                            </p>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- ==========================================
         AWARDS & CERTIFICATIONS RECOGNITION SHOWCASE
         ========================================== -->
        <section id="about-awards" class="py-5 bg-white">
            <div class="container-fluid px-4 px-lg-5 py-4">

                <div class="text-center mb-5" data-aos="fade-down">
                    <span class="welcome-subtitle-anim">
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        Global Recognition
                    </span>
                    <h2 class="welcome-title-anim mb-2">
                        Awards &amp; <span class="welcome-title-gold">Accreditations</span>
                    </h2>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="award-badge-card">
                            <i class="bi bi-trophy-fill award-icon"></i>
                            <h4 class="award-title">World Luxury Hotel Award</h4>
                            <div class="award-org">2025 Global Winner</div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="award-badge-card">
                            <i class="bi bi-star-fill award-icon"></i>
                            <h4 class="award-title">5-Star Diamond Award</h4>
                            <div class="award-org">International Hospitality Inst.</div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="award-badge-card">
                            <i class="bi bi-award-fill award-icon"></i>
                            <h4 class="award-title">Excellence In Culinary Arts</h4>
                            <div class="award-org">Michelin Guide Recognition 2024</div>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="award-badge-card">
                            <i class="bi bi-patch-check-fill award-icon"></i>
                            <h4 class="award-title">Travelers' Choice Best of Best</h4>
                            <div class="award-org">TripAdvisor 2026 Winner</div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- ==========================================
         EXECUTIVE HOTEL MANAGEMENT BOARD
         ========================================== -->
        <section id="about-team" class="py-5" style="background: linear-gradient(180deg, #ffffff 0%, #fdfbf7 100%);">
            <div class="container-fluid px-4 px-lg-5 py-4">

                <div class="text-center mb-5" data-aos="fade-down">
                    <span class="welcome-subtitle-anim">
                        <i class="fa-solid fa-sparkles text-champagne-gold" style="font-size: 0.8rem;"></i>
                        Meet Our Team
                    </span>
                    <h2 class="welcome-title-anim mb-2">
                        Hotel Operations <span class="welcome-title-gold">Leadership</span>
                    </h2>
                    <div class="welcome-decor-line">
                        <div class="line"></div>
                        <div class="diamond"><i class="fa-solid fa-gem"></i></div>
                        <div class="line right"></div>
                    </div>
                </div>

                <div class="row g-4">
                    <!-- Member 1 -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="team-profile-card">
                            <div class="team-profile-img-wrap">
                                <img src="images/testimonial-user1.jpg" alt="Robert Johnson">
                            </div>
                            <div class="team-profile-body">
                                <h3 class="team-profile-name">Rahul Singh</h3>
                                <p class="team-profile-role">Chief Executive Officer</p>
                                <div class="team-social-bar">
                                    <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                                    <a href="#" title="Twitter"><i class="bi bi-twitter-x"></i></a>
                                    <a href="#" title="Email"><i class="bi bi-envelope-fill"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Member 2 -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="team-profile-card">
                            <div class="team-profile-img-wrap">
                                <img src="images/testimonial-user2.jpg" alt="Priya Singhania">
                            </div>
                            <div class="team-profile-body">
                                <h3 class="team-profile-name">Priya Singhania</h3>
                                <p class="team-profile-role">General Manager</p>
                                <div class="team-social-bar">
                                    <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                                    <a href="#" title="Instagram"><i class="bi bi-instagram"></i></a>
                                    <a href="#" title="Email"><i class="bi bi-envelope-fill"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Member 3 -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="team-profile-card">
                            <div class="team-profile-img-wrap">
                                <img src="images/testimonial-user3.jpg" alt="Michael Davis">
                            </div>
                            <div class="team-profile-body">
                                <h3 class="team-profile-name">Rajesh Sharma</h3>
                                <p class="team-profile-role">Executive Master Chef</p>
                                <div class="team-social-bar">
                                    <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                                    <a href="#" title="Facebook"><i class="bi bi-facebook"></i></a>
                                    <a href="#" title="Email"><i class="bi bi-envelope-fill"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Member 4: Ananya Verma (Director of Guest Experience) -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="team-profile-card">
                            <div class="team-profile-img-wrap">
                                <img src="images/testimonial-user4.jpg" alt="Ananya Verma">
                            </div>
                            <div class="team-profile-body">
                                <h3 class="team-profile-name">Ananya Verma</h3>
                                <p class="team-profile-role">Director of Guest Experience</p>
                                <div class="team-social-bar">
                                    <a href="#" title="LinkedIn"><i class="bi bi-linkedin"></i></a>
                                    <a href="#" title="Instagram"><i class="bi bi-instagram"></i></a>
                                    <a href="#" title="Email"><i class="bi bi-envelope-fill"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

    </asp:Content>