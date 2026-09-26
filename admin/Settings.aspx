<%@ Page Title="Settings & Contact Config | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Admin_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management System Configuration & Contact Form Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">System Settings & Contact Configuration</h2>
            <p class="text-muted small mb-0">Configure general hotel details, contact card information, Google Map embed, and contact form settings for the public website.</p>
        </div>
        <div>
            <a href="../Contact.aspx" target="_blank" class="btn btn-outline-dark rounded-3 px-3 py-2 btn-sm fw-semibold">
                <i class="bi bi-globe2 me-1"></i> Preview Contact Page <i class="bi bi-box-arrow-up-right small ms-1"></i>
            </a>
        </div>
    </div>

    <!-- Alert / Status Message Panel -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false" CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i id="msgIcon" runat="server" class="bi bi-check-circle-fill fs-4 text-success"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <div class="row g-4">
        <!-- Left: Hotel & Contact Settings Form -->
        <div class="col-12 col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-building-gear text-gold me-2"></i> Hotel & Contact Card Details</h5>
                
                <div class="row g-3">
                    <!-- Hotel Name -->
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Hotel Name</label>
                        <asp:TextBox ID="txtHotelName" runat="server" CssClass="form-control shadow-none" placeholder="e.g. Grand Hotel & Suites"></asp:TextBox>
                    </div>

                    <!-- Default Currency -->
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Default Currency</label>
                        <asp:TextBox ID="txtCurrency" runat="server" CssClass="form-control shadow-none" placeholder="e.g. INR (₹)"></asp:TextBox>
                    </div>

                    <!-- Contact Card: Phone Number -->
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark"><i class="bi bi-telephone text-primary me-1"></i> Phone Number</label>
                        <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control shadow-none" placeholder="e.g. +91 11 2410 8888"></asp:TextBox>
                        <span class="text-muted extra-small">Displayed in Phone & Email Card on Contact page</span>
                    </div>

                    <!-- Contact Card: Contact Email -->
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark"><i class="bi bi-envelope text-primary me-1"></i> Contact Email</label>
                        <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email" CssClass="form-control shadow-none" placeholder="e.g. connect@example.com"></asp:TextBox>
                        <span class="text-muted extra-small">Displayed in Phone & Email Card on Contact page</span>
                    </div>

                    <!-- Contact Card: Location Address -->
                    <div class="col-12">
                        <label class="form-label small fw-semibold text-dark"><i class="bi bi-geo-alt text-primary me-1"></i> Location Address</label>
                        <asp:TextBox ID="txtLocationAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control shadow-none" placeholder="e.g. Diplomatic Enclave, Chanakyapuri, New Delhi 110021, India"></asp:TextBox>
                        <span class="text-muted extra-small">Displayed in Location Card on Contact page</span>
                    </div>

                    <!-- Form Heading Title -->
                    <div class="col-12">
                        <label class="form-label small fw-semibold text-dark"><i class="bi bi-card-heading text-primary me-1"></i> Contact Form Title</label>
                        <asp:TextBox ID="txtFormHeading" runat="server" CssClass="form-control shadow-none" placeholder="e.g. Send a Message"></asp:TextBox>
                        <span class="text-muted extra-small">Title shown above the enquiry form on Contact page</span>
                    </div>

                    <!-- Google Maps Embed URL -->
                    <div class="col-12">
                        <label class="form-label small fw-semibold text-dark"><i class="bi bi-map text-primary me-1"></i> Google Map Embed iframe URL (src)</label>
                        <asp:TextBox ID="txtMapUrl" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control shadow-none" placeholder="https://www.google.com/maps/embed?pb=..."></asp:TextBox>
                        <span class="text-muted extra-small">Enter the complete iframe src link from Google Maps Embed.</span>
                    </div>
                </div>

                <div class="mt-4 text-end">
                    <asp:Button ID="btnSaveSettings" runat="server" Text="Save Configuration" CssClass="btn btn-admin-primary px-4 py-2" OnClick="btnSaveSettings_Click" />
                </div>
            </div>
        </div>

        <!-- Right: Preview & Admin Profile Card -->
        <div class="col-12 col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white text-center mb-4">
                <div class="mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center text-white fw-bold fs-3" style="width: 80px; height: 80px; background-color: #442305;">
                    AS
                </div>
                <h5 class="fw-bold text-dark mb-0">Admin</h5>
                <p class="text-muted small">Super Administrator</p>
                <span class="badge bg-success-subtle text-success mx-auto mb-3 px-3 py-2 border">🟢 Active Session</span>
                <hr>
                <div class="text-start small text-muted">
                    <div class="mb-2"><strong>Role:</strong> Master Hotel Administrator</div>
                    <div class="mb-2"><strong>Last Updated:</strong> <asp:Label ID="lblLastUpdated" runat="server" Text="Just Now"></asp:Label></div>
                    <div><strong>Status:</strong> Live Sync Active</div>
                </div>
            </div>

            <!-- Quick Link to Enquiries Inbox -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <div class="d-flex align-items-center gap-3">
                    <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-3 fs-3">
                        <i class="bi bi-inbox-fill"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Contact Messages</h6>
                        <p class="text-muted extra-small mb-2">View messages submitted by guests via the contact form.</p>
                        <a href="Enquiries.aspx" class="btn btn-sm btn-outline-primary rounded-pill px-3">
                            Open Enquiries Inbox <i class="bi bi-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

