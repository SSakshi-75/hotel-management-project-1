<%@ Page Title="Terms & Conditions | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Terms.aspx.cs" Inherits="Terms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
    <section class="terms-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-file-earmark-text me-1 text-warning"></i> Legal &amp; Policies
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Terms &amp; Conditions</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Terms &amp; Conditions</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. TERMS CONTENT CONTAINER
         ========================================== -->
    <section class="py-5" style="background-color: #faf9f6;">
        <div class="container py-4 px-3 px-lg-5">
            
            <div class="row justify-content-center">
                <div class="col-lg-10" data-aos="fade-up" data-aos-duration="1000">
                    
                    <div class="privacy-card-wrapper p-4 p-md-5 bg-white rounded-4 shadow-sm" style="border: 1.5px solid rgba(154, 114, 78, 0.2); font-family: 'Plus Jakarta Sans', sans-serif;">
                        
                        <!-- Header Title Block -->
                        <div class="text-center mb-5">
                            <h2 class="font-serif fw-bold mb-2" style="font-family: 'Cormorant Upright', serif; color: #442305; font-size: 2.4rem;">
                                Hotel Terms &amp; Conditions
                            </h2>
                            <p class="small mb-0" style="color: #9A724E; font-weight: 600;">Last Updated: September 2026 | Hotel Management, Chanakyapuri, New Delhi</p>
                            <div class="welcome-decor-line mt-3">
                                <div class="line"></div>
                                <div class="diamond"><i class="fa-solid fa-gavel"></i></div>
                                <div class="line right"></div>
                            </div>
                        </div>

                        <!-- Section 1: Introduction -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-info-circle-fill me-2" style="color: #9A724E;"></i> 1. Introduction &amp; Agreement
                            </h3>
                            <p class="privacy-text" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                Welcome to <strong style="color: #442305;">Hotel Management</strong>. By making a reservation or utilizing our services, you agree to comply with the terms and conditions outlined below. These terms are designed to ensure a safe, luxurious, and uninterrupted experience for all our guests.
                            </p>
                        </div>

                        <!-- Section 2: Reservation & Payment Policy -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-credit-card-fill me-2" style="color: #9A724E;"></i> 2. Reservation &amp; Payment Policy
                            </h3>
                            <p class="privacy-text mb-3" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                To secure your luxury accommodation, the following payment policies apply:
                            </p>
                            <ul class="privacy-list list-unstyled ps-2" style="color: #5C4A3E; line-height: 2; font-size: 0.93rem;">
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Booking Guarantee:</strong> All reservations require a valid credit card at the time of booking.</li>
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Advance Payment:</strong> A deposit equivalent to the first night's stay may be charged 48 hours prior to arrival.</li>
                                <li class="mb-2"><i class="bi bi-check2-circle me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Taxes &amp; Fees:</strong> All rates are subject to applicable government taxes (GST) and luxury service charges unless otherwise stated.</li>
                            </ul>
                        </div>

                        <!-- Section 3: Check-In & Check-Out -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-clock-fill me-2" style="color: #9A724E;"></i> 3. Check-In &amp; Check-Out Procedures
                            </h3>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.2);">
                                        <h5 class="fw-bold mb-2" style="color: #442305; font-family: 'Cormorant Upright', serif; font-size: 1.25rem;"><i class="bi bi-box-arrow-in-right me-2" style="color: #9A724E;"></i> Standard Check-In</h5>
                                        <p class="small mb-0" style="color: #5C4A3E; line-height: 1.6;">From 2:00 PM onwards. A valid government-issued photo ID (Passport for international guests) must be presented.</p>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="p-3 rounded-3 h-100" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.2);">
                                        <h5 class="fw-bold mb-2" style="color: #442305; font-family: 'Cormorant Upright', serif; font-size: 1.25rem;"><i class="bi bi-box-arrow-left me-2" style="color: #9A724E;"></i> Standard Check-Out</h5>
                                        <p class="small mb-0" style="color: #5C4A3E; line-height: 1.6;">Until 11:00 AM. Late check-out requests are subject to availability and may incur additional charges.</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Section 4: Cancellation Policy -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-x-circle-fill me-2" style="color: #9A724E;"></i> 4. Cancellation &amp; No-Show Policy
                            </h3>
                            <p class="privacy-text" style="color: #5C4A3E; line-height: 1.85; font-size: 0.95rem;">
                                We understand that travel plans may change. Cancellations must be made at least 48 hours prior to the scheduled arrival date to avoid a one-night penalty charge. In the event of a "no-show," the total price of the reservation will be charged to the credit card on file. Non-refundable rates are subject to immediate charge and cannot be modified.
                            </p>
                        </div>

                        <!-- Section 5: Guest Code of Conduct -->
                        <div class="privacy-section mb-5">
                            <h3 class="privacy-subtitle mb-3 d-flex align-items-center" style="font-family: 'Cormorant Upright', serif; color: #442305; font-weight: 700; font-size: 1.6rem;">
                                <i class="bi bi-people-fill me-2" style="color: #9A724E;"></i> 5. Guest Code of Conduct &amp; Damages
                            </h3>
                            <ul class="privacy-list list-unstyled ps-2" style="color: #5C4A3E; line-height: 2; font-size: 0.93rem;">
                                <li class="mb-2"><i class="bi bi-exclamation-diamond-fill me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Smoke-Free Environment:</strong> Smoking is strictly prohibited indoors. A deep-cleaning fee will be applied for violations.</li>
                                <li class="mb-2"><i class="bi bi-exclamation-diamond-fill me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Property Damage:</strong> Guests are liable for any damages to the hotel property or missing items from the room.</li>
                                <li class="mb-2"><i class="bi bi-exclamation-diamond-fill me-2" style="color: #9A724E;"></i> <strong style="color: #442305;">Quiet Hours:</strong> We request guests to maintain appropriate noise levels between 10:00 PM and 7:00 AM to respect others' tranquility.</li>
                            </ul>
                        </div>

                        <!-- Section 6: Contact Support -->
                        <div class="privacy-contact-box p-4 rounded-4 text-center mt-5" style="background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%); border: 1.5px solid rgba(154, 114, 78, 0.25);">
                            <h4 class="font-serif fw-bold mb-2" style="font-family: 'Cormorant Upright', serif; color: #442305; font-size: 1.8rem;">
                                Need Clarification on Our Terms?
                            </h4>
                            <p class="small mb-3" style="color: #5C4A3E;">Our Front Desk and Concierge teams are here to help you 24/7.</p>
                            <div class="d-flex flex-wrap justify-content-center gap-4 fw-medium small" style="color: #442305;">
                                <span><i class="bi bi-telephone-fill me-1" style="color: #9A724E;"></i> +91 11 3933 1234</span>
                                <span><i class="bi bi-envelope-fill me-1" style="color: #9A724E;"></i> info@hotelmanagement.com</span>
                            </div>
                            <div class="mt-4">
                                <a href="Contact.aspx" class="btn btn-navbar-theme px-4 py-2 rounded-pill fw-bold text-uppercase shadow-sm">
                                    <i class="bi bi-chat-left-text-fill me-2"></i> Contact Us
                                </a>
                            </div>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </section>

</asp:Content>
