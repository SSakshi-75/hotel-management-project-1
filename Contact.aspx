<%@ Page Title="Contact Us | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. LUXURY HERO BANNER SECTION WITH IMAGE & BREADCRUMB
         ========================================== -->
    <section class="contact-compact-hero text-white">

        <div class="container py-4 position-relative z-2"
             data-aos="fade-down"
             data-aos-duration="1000">

            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">

                <div>

                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-headset me-1 text-warning"></i>
                        24/7 Concierge &amp; Support
                    </span>

                    <h1 class="display-4 font-serif fw-bold text-white mb-0">
                        Contact
                    </h1>

                </div>

                <div class="mt-3 mt-md-0">

                    <nav aria-label="breadcrumb">

                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">

                            <li class="breadcrumb-item">
                                <a href="index.aspx"
                                   class="text-white text-decoration-none">
                                    Home
                                </a>
                            </li>

                            <li class="breadcrumb-item active text-gold fw-bold"
                                aria-current="page">
                                Contact
                            </li>

                        </ol>

                    </nav>

                </div>

            </div>

        </div>

    </section>


    <!-- ==========================================
         2. FULL-WIDTH INTERACTIVE GOOGLE MAP
         ========================================== -->
    <section class="p-0 border-bottom"
             data-aos="fade-in"
             data-aos-duration="1000">

        <div class="contact-full-map-wrapper">

            <iframe 
                id="iframeMap"
                runat="server"
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d14013.25622534575!2d77.1852!3d28.5910!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x390d1d7fa74ab6d3%3A0xbbfd1efef7e504c5!2sChanakyapuri%2C%20New%20Delhi%2C%20Delhi%20110021!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                title="Hotel Location Map">
            </iframe>

        </div>

    </section>


    <!-- ==========================================
         3. CONTACT INFO SUMMARY CARDS & SEND MESSAGE FORM
         ========================================== -->
    <section class="py-5" style="background-color: #faf9f6;">

        <div class="container py-4 px-3 px-lg-5">


            <!-- ==========================================
                 ROW 1: LOCATION + PHONE/EMAIL CARDS
                 ========================================== -->
            <div class="row g-4 mb-5 justify-content-center">


                <!-- ==========================================
                     CARD 1: LOCATION
                     ========================================== -->
                <asp:Repeater ID="rptLocation" runat="server">

                    <ItemTemplate>

                        <div class="col-md-6 col-lg-5"
                             data-aos="fade-up"
                             data-aos-duration="800"
                             data-aos-delay="100">

                            <div class="contact-summary-card">

                                <div class="contact-summary-icon">
                                    <i class="bi bi-geo-alt"></i>
                                </div>

                                <div class="contact-summary-text-box">

                                    <h3 class="contact-summary-title">
                                        Location
                                    </h3>

                                    <p class="contact-summary-txt">
                                        <%# Eval("LocationAddress") %>
                                    </p>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>


                <!-- ==========================================
                     CARD 2: PHONE & EMAIL
                     ========================================== -->
                <asp:Repeater ID="rptPhoneEmail" runat="server">

                    <ItemTemplate>

                        <div class="col-md-6 col-lg-5"
                             data-aos="fade-up"
                             data-aos-duration="800"
                             data-aos-delay="200">

                            <div class="contact-summary-card">

                                <div class="contact-summary-icon">
                                    <i class="bi bi-telephone"></i>
                                </div>

                                <div class="contact-summary-text-box">

                                    <h3 class="contact-summary-title">
                                        Phone &amp; Email
                                    </h3>

                                    <p class="contact-summary-txt">
                                        <%# Eval("PhoneNumber") %>
                                        <%# (!string.IsNullOrEmpty(Eval("PhoneNumber") as string) && !string.IsNullOrEmpty(Eval("ContactEmail") as string)) ? "<br />" : "" %>
                                        <%# Eval("ContactEmail") %>
                                    </p>

                                </div>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>


            </div>


            <!-- ==========================================
                 ROW 2: SEND A MESSAGE FORM
                 ========================================== -->
            <div class="contact-form-wrapper"
                 data-aos="fade-up"
                 data-aos-duration="1000"
                 data-aos-delay="300">


                <!-- FORM HEADING -->
                <h2 class="contact-form-title">

                    <asp:Literal ID="litFormHeading"
                                 runat="server">
                        Send a Message
                    </asp:Literal>

                </h2>


                <div class="contact-form-line"></div>


                <!-- ==========================================
                     ALERT MESSAGE PANEL
                     ========================================== -->
                <asp:Panel ID="pnlContactMsg"
                           runat="server"
                           Visible="false"
                           CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4 position-relative overflow-hidden"
                           role="alert">

                    <div class="d-flex align-items-center gap-3">

                        <i id="msgIconContact"
                           runat="server"
                           class="bi bi-check-circle-fill fs-4 text-success">
                        </i>

                        <div>

                            <asp:Label ID="lblContactMsg"
                                       runat="server"
                                       CssClass="fw-semibold text-dark">
                            </asp:Label>

                        </div>

                    </div>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert"
                            aria-label="Close">
                    </button>

                    <div class="alert-timer-bar position-absolute bottom-0 start-0 bg-success" style="height: 3.5px; width: 100%; border-radius: 0 0 16px 16px;"></div>

                </asp:Panel>


                <!-- ==========================================
                     CONTACT FORM FIELDS
                     ========================================== -->
                <div class="row g-4">


                    <!-- FIELD 1: YOUR NAME -->
                    <div class="col-md-6">

                        <asp:TextBox
                            ID="txtContactName"
                            runat="server"
                            CssClass="form-control contact-input-field shadow-none"
                            placeholder="Your Name"
                            required="required">
                        </asp:TextBox>

                    </div>


                    <!-- FIELD 2: EMAIL -->
                    <div class="col-md-6">

                        <asp:TextBox
                            ID="txtContactEmail"
                            runat="server"
                            TextMode="Email"
                            CssClass="form-control contact-input-field shadow-none"
                            placeholder="Email Address"
                            required="required">
                        </asp:TextBox>

                    </div>


                    <!-- FIELD 3: SUBJECT -->
                    <div class="col-12">

                        <asp:TextBox
                            ID="txtContactSubject"
                            runat="server"
                            CssClass="form-control contact-input-field shadow-none"
                            placeholder="Subject">
                        </asp:TextBox>

                    </div>


                    <!-- FIELD 4: MESSAGE -->
                    <div class="col-12">

                        <asp:TextBox
                            ID="txtContactMessage"
                            runat="server"
                            TextMode="MultiLine"
                            Rows="5"
                            CssClass="form-control contact-input-field shadow-none"
                            style="height: auto !important; min-height: 140px;"
                            placeholder="Your Message"
                            required="required">
                        </asp:TextBox>

                    </div>


                    <!-- SUBMIT BUTTON -->
                    <div class="col-12 text-center pt-3">

                        <asp:Button
                            ID="btnSendMessage"
                            runat="server"
                            Text="SEND MESSAGE"
                            CssClass="btn btn-send-message px-5"
                            OnClick="btnSendMessage_Click" />

                    </div>


                </div>

            </div>

        </div>

    </section>

</asp:Content>