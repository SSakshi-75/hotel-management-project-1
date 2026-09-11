<%@ Page Title="Privacy Policy | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Privacy.aspx.cs" Inherits="Privacy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
    <section class="privacy-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-shield-check me-1 text-warning"></i> Data Protection &amp; Guest Privacy
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Privacy Policy</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Privacy Policy</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. PRIVACY POLICY CONTENT CONTAINER
         ========================================== -->
    <section class="py-5" style="background-color: #faf9f6;">
        <div class="container py-4 px-3 px-lg-5">
            
            <div class="row justify-content-center">
                <div class="col-lg-10" data-aos="fade-up" data-aos-duration="1000">
                    
                    <div class="privacy-card-wrapper p-4 p-md-5 bg-white rounded-4 shadow-sm" style="border: 1.5px solid rgba(154, 114, 78, 0.2); font-family: 'Plus Jakarta Sans', sans-serif;">
                        
                        <!-- Header Title Block -->
                        <div class="text-center mb-5">
                            <h2 class="font-serif fw-bold mb-2" style="font-family: 'Cormorant Upright', serif; color: #442305; font-size: 2.4rem;">
                                Guest Data Protection &amp; Privacy Policy
                            </h2>
                            <p class="small mb-0" style="color: #9A724E; font-weight: 600;">Last Updated: September 2026 | Hotel Management, Chanakyapuri, New Delhi</p>
                            <div class="welcome-decor-line mt-3">
                                <div class="line"></div>
                                <div class="diamond"><i class="fa-solid fa-shield-halved"></i></div>
                                <div class="line right"></div>
                            </div>
                        </div>

                        <!-- Section 1: Introduction -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-info-circle-fill me-2" style="color: #9A724E;"></i> 1. Introduction &amp; Our Commitment
                            </h3>
                            <p class="privacy-text" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                At <strong style="color: #442305;">Hotel Management</strong> (Diplomatic Enclave, Chanakyapuri, New Delhi 110021), we value your trust and are deeply committed to protecting your personal privacy. This Privacy Policy outlines how we collect, use, store, and safeguard your personal information when you visit our website, book luxury accommodations, reserve dining or spa experiences, or interact with our 24/7 Concierge services.
                            </p>
                        </div>

                        <!-- Section 2: Information We Collect -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-file-earmark-person-fill me-2" style="color: #9A724E;"></i> 2. Information We Collect
                            </h3>
                            <p class="privacy-text mb-3" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                To provide world-class hospitality and seamless online reservation services, we collect necessary guest details including:
                            </p>
                            <ul class="privacy-list list-unstyled ps-2" style="color: #5C4A3E; line-height: 2; font-size: 0.93rem;">
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Contact Information:</strong> Full name, email address, phone number, and mailing address.</li>
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Reservation Details:</strong> Check-in/check-out dates, room type preferences, special requests, and guest count.</li>
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Billing Details:</strong> Payment card details processed securely via PCI-DSS compliant payment gateways.</li>
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Concierge &amp; Add-on Services:</strong> Airport shuttle schedules, dietary preferences, and spa treatment bookings.</li>
                            </ul>
                        </div>

                        <!-- Section 3: How We Use Your Information -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-gear-wide-connected me-2" style="color: #9A724E;"></i> 3. How We Use Your Information
                            </h3>
                            <p class="privacy-text mb-3" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                Your personal information is utilized strictly to deliver an exceptional guest experience:
                            </p>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.2);">
                                        <h5 class="fw-bold mb-2" style="color: #442305; font-family: 'Cormorant Upright', serif; font-size: 1.25rem;"><i class="bi bi-calendar-check me-2" style="color: #9A724E;"></i> Booking Management</h5>
                                        <p class="small mb-0" style="color: #5C4A3E; line-height: 1.6;">Confirming reservations, generating digital receipts, and processing check-in/out protocols.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.2);">
                                        <h5 class="fw-bold mb-2" style="color: #442305; font-family: 'Cormorant Upright', serif; font-size: 1.25rem;"><i class="bi bi-headset me-2" style="color: #9A724E;"></i> 24/7 Concierge Support</h5>
                                        <p class="small mb-0" style="color: #5C4A3E; line-height: 1.6;">Fulfilling personalized requests such as room dining, spa sessions, and airport transfers.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Section 4: Security & Third-Party Protection -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-lock-fill me-2" style="color: #9A724E;"></i> 4. Data Security &amp; Third-Party Policy
                            </h3>
                            <p class="privacy-text" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                We employ industry-standard 256-bit SSL encryption, secure firewall protections, and strict access controls to safeguard your data. <strong style="color: #442305;">We do not sell, rent, or trade your personal information</strong> to third-party marketing companies under any circumstances.
                            </p>
                        </div>

                        <!-- Section 5: Cookies & Analytics -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-cookie me-2" style="color: #9A724E;"></i> 5. Cookies &amp; Website Analytics
                            </h3>
                            <p class="privacy-text" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                Our website uses essential cookies to remember your booking preferences, improve page loading speed, and analyze aggregated web traffic. You can choose to disable cookies through your browser settings, though certain interactive features may be affected.
                            </p>
                        </div>

                        <!-- Section 6: Contact Us Block -->
                        <div class="privacy-contact-box p-4 rounded-4 text-center mt-5" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.25);">
                            <h4 class="font-serif fw-bold mb-2" style="font-family: 'Cormorant Upright', serif; color: #442305; font-size: 1.8rem;">
                                Have Questions About Your Privacy?
                            </h4>
                            <p class="small mb-3" style="color: #5C4A3E;">Our Concierge and Data Protection Team is available 24/7 to assist you.</p>
                            <div class="d-flex flex-wrap justify-content-center gap-4 fw-medium small" style="color: #442305;">
                                <span><i class="bi bi-geo-alt-fill me-1" style="color: #9A724E;"></i> Chanakyapuri, New Delhi 110021</span>
                                <span><i class="bi bi-telephone-fill me-1" style="color: #9A724E;"></i> +91 11 3933 1234</span>
                                <span><i class="bi bi-envelope-fill me-1" style="color: #9A724E;"></i> info@hotelmanagement.com</span>
                            </div>
                            <div class="mt-4">
                                <a href="Contact.aspx" class="btn btn-navbar-theme px-4 py-2 rounded-pill fw-bold text-uppercase shadow-sm">
                                    <i class="bi bi-headset me-2"></i> Contact Privacy Team
                                </a>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </section>

</asp:Content>
