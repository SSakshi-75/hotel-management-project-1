<%@ Page Title="Location & Contact Cards | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ContactDetails.aspx.cs" Inherits="Admin_ContactDetails" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Manage Hotel Location and Contact Information Cards for Public Website">
        <style>
            /* Card preview styles matching public website */
            .preview-contact-summary-card {
                background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%);
                border-radius: 18px !important;
                padding: 24px 22px;
                display: flex;
                align-items: center;
                gap: 18px;
                transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
                border: 1.5px solid rgba(154, 114, 78, 0.22);
                box-shadow: 0 6px 20px rgba(68, 35, 5, 0.05);
            }

            .preview-contact-summary-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 12px 30px rgba(68, 35, 5, 0.10);
                background: #ffffff;
                border-color: #9A724E;
            }

            .preview-contact-summary-icon {
                width: 52px;
                height: 52px;
                min-width: 52px;
                border-radius: 14px;
                background: linear-gradient(135deg, #442305 0%, #9A724E 100%);
                color: #ffffff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.35rem;
                box-shadow: 0 8px 18px rgba(68, 35, 5, 0.25);
                border: 1px solid rgba(244, 226, 216, 0.4);
            }

            .preview-contact-summary-text-box {
                flex: 1;
                min-width: 0;
            }

            .preview-contact-summary-title {
                font-family: "Cormorant Upright", "Playfair Display", Georgia, serif;
                font-size: 1.35rem;
                font-weight: 700;
                color: #442305;
                margin-bottom: 4px;
            }

            .preview-contact-summary-txt {
                font-family: "Plus Jakarta Sans", sans-serif;
                font-size: 0.88rem;
                color: #5C4A3E;
                font-weight: 500;
                line-height: 1.55;
                margin: 0;
                overflow-wrap: anywhere;
                word-break: normal;
            }

            .form-section-header {
                border-bottom: 2px solid #f1ece4;
                padding-bottom: 10px;
                margin-bottom: 20px;
            }

            .form-section-title {
                font-size: 1.05rem;
                font-weight: 700;
                color: #442305;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .live-preview-badge {
                font-size: 0.75rem;
                letter-spacing: 0.5px;
                background: rgba(40, 167, 69, 0.12);
                color: #198754;
                border: 1px solid rgba(40, 167, 69, 0.25);
                padding: 4px 10px;
                border-radius: 20px;
                font-weight: 600;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Page Header & Action Bar -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <div class="d-flex align-items-center gap-2 mb-1">
                    <span
                        class="badge bg-warning bg-opacity-25 text-warning-emphasis px-2 py-1 small rounded-pill fw-semibold">Contact
                        Card Config</span>
                    <span class="text-muted small">&bull; Admin Panel</span>
                </div>
                <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Location
                    &amp; Contact Information</h2>
                <p class="text-muted small mb-0">Fill or update the Location and Phone &amp; Email details displayed on
                    the public website contact cards.</p>
            </div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <a href="../Contact.aspx" target="_blank"
                    class="btn btn-outline-dark rounded-3 px-3 py-2 btn-sm fw-semibold">
                    <i class="bi bi-box-arrow-up-right me-1"></i> Preview Live Website
                </a>
                <a href="Enquiries.aspx" class="btn btn-outline-secondary rounded-3 px-3 py-2 btn-sm fw-semibold">
                    <i class="bi bi-inbox me-1"></i> View Messages
                </a>
            </div>
        </div>

        <!-- Alert / Status Notification -->
        <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false"
            CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
            <div class="d-flex align-items-center gap-3">
                <i id="msgIcon" runat="server" class="bi bi-check-circle-fill fs-4 text-success"></i>
                <div>
                    <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
                </div>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </asp:Panel>

        <div class="row g-4">

            <!-- Left Column: Admin Entry Form -->
            <div class="col-12 col-xl-7">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">

                    <!-- Section 1: Location Card Details -->
                    <div class="form-section-header">
                        <div class="form-section-title">
                            <i class="bi bi-geo-alt-fill text-gold fs-5"></i>
                            <span>Card 1: Location Details</span>
                        </div>
                        <span class="text-muted extra-small">This text appears directly in the first card
                            (Location)</span>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold text-dark small">
                            Hotel Location Address <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtLocationAddress" runat="server" TextMode="MultiLine" Rows="3"
                            CssClass="form-control shadow-none rounded-3"
                            placeholder="e.g. Diplomatic Enclave, Chanakyapuri, New Delhi 110021, India"
                            oninput="updateLivePreview()"></asp:TextBox>
                        <div class="d-flex justify-content-between align-items-center mt-1">
                            <span class="text-muted extra-small">Full address with city, state, postal code &amp;
                                country.</span>
                            <button type="button" class="btn btn-link p-0 text-decoration-none extra-small text-muted"
                                onclick="setDefaultLocation()">
                                <i class="bi bi-arrow-counterclockwise"></i> Reset to Default
                            </button>
                        </div>
                    </div>

                    <!-- Section 2: Phone & Email Card Details -->
                    <div class="form-section-header">
                        <div class="form-section-title">
                            <i class="bi bi-telephone-fill text-gold fs-5"></i>
                            <span>Card 2: Phone &amp; Email Details</span>
                        </div>
                        <span class="text-muted extra-small">This information appears in the second card (Phone &amp;
                            Email)</span>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-dark small">
                                Primary Phone Number <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted border-end-0 rounded-start-3">
                                    <i class="bi bi-telephone"></i>
                                </span>
                                <asp:TextBox ID="txtPhoneNumber" runat="server"
                                    CssClass="form-control shadow-none border-start-0 rounded-end-3"
                                    placeholder="+91 11 2410 8888" oninput="updateLivePreview()"></asp:TextBox>
                            </div>
                            <span class="text-muted extra-small mt-1 d-block">Shown on line 1 of the Phone &amp; Email
                                card.</span>
                        </div>

                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-dark small">
                                Official Contact Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted border-end-0 rounded-start-3">
                                    <i class="bi bi-envelope"></i>
                                </span>
                                <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email"
                                    CssClass="form-control shadow-none border-start-0 rounded-end-3"
                                    placeholder="connect@example.com" oninput="updateLivePreview()"></asp:TextBox>
                            </div>
                            <span class="text-muted extra-small mt-1 d-block">Shown on line 2 of the Phone &amp; Email
                                card.</span>
                        </div>
                    </div>

                    <!-- Section 3: Extra Settings (Optional Google Maps Link) -->
                    <div class="form-section-header">
                        <div class="form-section-title">
                            <i class="bi bi-map-fill text-gold fs-5"></i>
                            <span>Optional: Google Map &amp; Form Title</span>
                        </div>
                        <span class="text-muted extra-small">Additional settings for the Contact page</span>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-dark small">Contact Form Heading</label>
                            <asp:TextBox ID="txtFormHeading" runat="server"
                                CssClass="form-control shadow-none rounded-3" placeholder="Send a Message">
                            </asp:TextBox>
                            <span class="text-muted extra-small mt-1 d-block">Heading above guest enquiry form.</span>
                        </div>

                        <div class="col-12 col-md-6">
                            <label class="form-label fw-semibold text-dark small">Hotel Brand Name</label>
                            <asp:TextBox ID="txtHotelName" runat="server" CssClass="form-control shadow-none rounded-3"
                                placeholder="Hotel Management Executive Portal"></asp:TextBox>
                            <span class="text-muted extra-small mt-1 d-block">Official name of the property.</span>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold text-dark small">Google Maps Embed URL (iframe
                                src)</label>
                            <asp:TextBox ID="txtGoogleMapUrl" runat="server" TextMode="MultiLine" Rows="2"
                                CssClass="form-control shadow-none rounded-3 font-monospace small"
                                placeholder="https://www.google.com/maps/embed?pb=..."></asp:TextBox>
                            <span class="text-muted extra-small mt-1 d-block">Embedded interactive Google Map URL shown
                                below the contact cards.</span>
                        </div>
                    </div>

                    <!-- Submit Button Bar -->
                    <div class="pt-3 border-top d-flex align-items-center justify-content-between flex-wrap gap-2">
                        <span class="text-muted small">
                            <i class="bi bi-clock-history me-1 text-gold"></i> Last saved: <asp:Label ID="lblLastSaved"
                                runat="server" Text="Not updated yet" CssClass="fw-semibold text-dark"></asp:Label>
                        </span>
                        <asp:Button ID="btnSaveContactDetails" runat="server" Text="Save Contact Details"
                            CssClass="btn-hotel-primary border-0"
                            OnClick="btnSaveContactDetails_Click" />
                    </div>

                </div>
            </div>

            <!-- Right Column: Live Visual Preview -->
            <div class="col-12 col-xl-5">
                <div class="card border-0 shadow-sm rounded-4 p-4 bg-white sticky-top" style="top: 90px; z-index: 10;">

                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-eye text-gold me-2"></i> Live Visual Preview
                        </h5>
                        <span class="live-preview-badge">
                            <i class="bi bi-broadcast me-1"></i> Live Real-Time
                        </span>
                    </div>
                    <p class="text-muted small mb-4">This is exactly how these two cards appear to visitors on the
                        public Contact page.</p>

                    <!-- Container styled like the public site section -->
                    <div class="p-3 rounded-4 mb-4"
                        style="background-color: #faf9f6; border: 1px dashed rgba(154, 114, 78, 0.35);">

                        <!-- Preview Card 1: Location -->
                        <div class="mb-3">
                            <div class="preview-contact-summary-card">
                                <div class="preview-contact-summary-icon">
                                    <i class="bi bi-geo-alt"></i>
                                </div>
                                <div class="preview-contact-summary-text-box">
                                    <h3 class="preview-contact-summary-title">Location</h3>
                                    <p class="preview-contact-summary-txt" id="livePreviewLocation"></p>
                                </div>
                            </div>
                        </div>

                        <!-- Preview Card 2: Phone & Email -->
                        <div>
                            <div class="preview-contact-summary-card">
                                <div class="preview-contact-summary-icon">
                                    <i class="bi bi-telephone"></i>
                                </div>
                                <div class="preview-contact-summary-text-box">
                                    <h3 class="preview-contact-summary-title">Phone &amp; Email</h3>
                                    <p class="preview-contact-summary-txt">
                                        <span id="livePreviewPhone"></span><br />
                                        <span id="livePreviewEmail"></span>
                                    </p>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Info Highlights Box -->
                    <div class="p-3 rounded-3 bg-light border">
                        <div class="d-flex align-items-start gap-2">
                            <i class="bi bi-info-circle-fill text-primary fs-5 mt-1"></i>
                            <div class="small text-muted">
                                <strong class="text-dark d-block mb-1">Instant Synchronisation:</strong>
                                Clicking <strong>Save &amp; Update Cards</strong> writes directly to the
                                <code>HotelSettings</code> database, updating both the public <code>Contact.aspx</code>
                                page and the system instantly without needing server restarts.
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <!-- Client-side Real-time Preview Script -->
        <script>
            function updateLivePreview() {
                var txtLoc = document.getElementById('<%= txtLocationAddress.ClientID %>');
                var txtPh = document.getElementById('<%= txtPhoneNumber.ClientID %>');
                var txtEm = document.getElementById('<%= txtContactEmail.ClientID %>');

                var prevLoc = document.getElementById('livePreviewLocation');
                var prevPh = document.getElementById('livePreviewPhone');
                var prevEm = document.getElementById('livePreviewEmail');

                if (txtLoc && prevLoc) {
                    var locVal = txtLoc.value.trim();
                    prevLoc.innerText = locVal;
                }

                if (txtPh && prevPh) {
                    var phVal = txtPh.value.trim();
                    prevPh.innerText = phVal;
                }

                if (txtEm && prevEm) {
                    var emVal = txtEm.value.trim();
                    prevEm.innerText = emVal;
                }
            }

            function setDefaultLocation() {
                var txtLoc = document.getElementById('<%= txtLocationAddress.ClientID %>');
                if (txtLoc) {
                    txtLoc.value = "Diplomatic Enclave, Chanakyapuri, New Delhi 110021, India";
                    updateLivePreview();
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                updateLivePreview();
            });
        </script>
    </asp:Content>