<%@ Page Title="Contact Us | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. LUXURY HERO BANNER SECTION WITH IMAGE & BREADCRUMB
         ========================================== -->
    <section class="contact-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-headset me-1 text-warning"></i> 24/7 Concierge &amp; Support
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Contact</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Contact</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. FULL-WIDTH INTERACTIVE GOOGLE MAP (MATCHING SCREENSHOT 1)
         ========================================== -->
    <section class="p-0 border-bottom" data-aos="fade-in" data-aos-duration="1000">
        <div class="contact-full-map-wrapper">
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade" 
                title="Hotel Location Map">
            </iframe>
        </div>
    </section>

    <!-- ==========================================
         3. CONTACT INFO SUMMARY CARDS & SEND MESSAGE FORM (MATCHING SCREENSHOT 2)
         ========================================== -->
    <section class="py-5" style="background-color: #faf9f6;">
        <div class="container py-4 px-3 px-lg-5">
            
            <!-- Row 1: 2 Info Cards (Location & Phone/Email) -->
            <div class="row g-4 mb-5 justify-content-center">
                
                <!-- Card 1: Location -->
                <div class="col-md-6 col-lg-5" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                    <div class="contact-summary-card">
                        <div class="contact-summary-icon">
                            <i class="bi bi-geo-alt"></i>
                        </div>
                        <div class="contact-summary-text-box">
                            <h3 class="contact-summary-title">Location</h3>
                            <p class="contact-summary-txt">
                                Diplomatic Enclave, Chanakyapuri, New Delhi 110021, India
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Phone & Email -->
                <div class="col-md-6 col-lg-5" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                    <div class="contact-summary-card">
                        <div class="contact-summary-icon">
                            <i class="bi bi-telephone"></i>
                        </div>
                        <div class="contact-summary-text-box">
                            <h3 class="contact-summary-title">Phone &amp; Email</h3>
                            <p class="contact-summary-txt">
                                +91 11 2410 8888<br>
                                connect@example.com
                            </p>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Row 2: "Send a Message" Form Card (Matching Screenshot 2) -->
            <div class="contact-form-wrapper" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                
                <h2 class="contact-form-title">Send a Message</h2>
                <div class="contact-form-line"></div>

                <div class="row g-4">
                    
                    <!-- Field 1: Your Name -->
                    <div class="col-md-6">
                        <input type="text" class="form-control contact-input-field shadow-none" id="contactName" placeholder="Your Name" required>
                    </div>

                    <!-- Field 2: Email Address -->
                    <div class="col-md-6">
                        <input type="email" class="form-control contact-input-field shadow-none" id="contactEmail" placeholder="Email Address" required>
                    </div>

                    <!-- Field 3: Subject -->
                    <div class="col-12">
                        <input type="text" class="form-control contact-input-field shadow-none" id="contactSubject" placeholder="Subject">
                    </div>

                    <!-- Field 4: Your Message -->
                    <div class="col-12">
                        <textarea class="form-control contact-input-field shadow-none" id="contactMessage" rows="5" style="height: auto !important; min-height: 140px;" placeholder="Your Message" required></textarea>
                    </div>

                    <!-- Submit Button -->
                    <div class="col-12 text-center pt-3">
                        <button type="button" class="btn btn-send-message px-5" onclick="alert('Thank you for contacting us! Our concierge team will get back to you shortly.');">
                            SEND MESSAGE
                        </button>
                    </div>

                </div>

            </div>

        </div>
    </section>

</asp:Content>

