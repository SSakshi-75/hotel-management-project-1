<%@ Page Title="Enquiries & Contact Cards | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Enquiries.aspx.cs" Inherits="Admin_Enquiries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Contact Enquiries and Location & Contact Information Administration">
    <style>
        /* ==========================================
           LUXURY HOTEL MANAGEMENT THEME STYLES
           Theme: Royal Brown (#442305), Warm Gold (#B88E68), Canvas (#f8fafc)
           ========================================== */
        .enquiry-page-title {
            font-family: 'Playfair Display', Georgia, serif;
            font-weight: 700;
            color: #442305;
            letter-spacing: -0.01em;
        }

        /* Executive Form & Content Cards */
        .hotel-admin-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
            overflow: hidden;
            margin-bottom: 24px;
        }

        .hotel-admin-card-header {
            background: linear-gradient(135deg, #442305 0%, #6a390a 100%);
            color: #ffffff;
            padding: 18px 26px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .hotel-admin-card-title {
            font-family: 'Playfair Display', Georgia, serif;
            font-weight: 700;
            font-size: 1.15rem;
            color: #ffffff;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .hotel-admin-card-body {
            padding: 26px;
            background: #ffffff;
        }

        /* Form Labels & Controls matching Hotel Management Admin */
        .form-label-hotel {
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 0.8rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #442305;
            margin-bottom: 7px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-control-hotel {
            border: 1.5px solid #cbd5e1;
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 0.92rem;
            color: #0f172a;
            font-weight: 500;
            background-color: #ffffff;
            transition: all 0.25s ease;
            font-family: 'Plus Jakarta Sans', sans-serif;
            width: 100%;
        }

        .form-control-hotel:focus {
            border-color: #B88E68;
            box-shadow: 0 0 0 4px rgba(184, 142, 104, 0.15);
            outline: none;
        }

        .input-group-hotel-addon {
            background-color: #fdfaf7;
            color: #9A724E;
            border: 1.5px solid #cbd5e1;
            border-right: none;
            border-radius: 10px 0 0 10px;
            padding: 0 14px;
            display: flex;
            align-items: center;
            font-size: 1.05rem;
        }

        .form-control-hotel-grouped {
            border-radius: 0 10px 10px 0 !important;
            border-left: none !important;
        }

        /* Buttons matching Hotel Management Theme */
        .btn-hotel-primary {
            background: linear-gradient(135deg, #442305 0%, #6a390a 100%);
            color: #ffffff !important;
            font-weight: 600;
            font-size: 0.92rem;
            padding: 10px 24px;
            border-radius: 10px;
            border: 1px solid rgba(184, 142, 104, 0.4);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.25s ease;
            box-shadow: 0 4px 14px rgba(68, 35, 5, 0.18);
            cursor: pointer;
        }

        .btn-hotel-primary:hover {
            background: linear-gradient(135deg, #5a300a 0%, #85480d 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(68, 35, 5, 0.28);
            color: #ffffff !important;
            border-color: #B88E68;
        }

        .btn-hotel-secondary {
            background: #ffffff;
            color: #442305 !important;
            font-weight: 600;
            font-size: 0.92rem;
            padding: 9px 18px;
            border-radius: 10px;
            border: 1.5px solid #B88E68;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            transition: all 0.25s ease;
            cursor: pointer;
        }

        .btn-hotel-secondary:hover {
            background: #fdfaf7;
            border-color: #9A724E;
            transform: translateY(-2px);
            color: #5a300a !important;
        }

        /* KPI Cards */
        .hotel-kpi-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 22px;
            transition: all 0.25s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            position: relative;
            overflow: hidden;
            height: 100%;
        }

        .hotel-kpi-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: #B88E68;
        }

        .hotel-kpi-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
            border-color: #cbd5e1;
        }

        .kpi-label {
            font-size: 0.78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748b;
        }

        .kpi-value {
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 1.85rem;
            font-weight: 700;
            color: #442305;
            line-height: 1.2;
        }

        .kpi-icon-wrap {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
        }

        .kpi-icon-gold {
            background: rgba(184, 142, 104, 0.15);
            color: #9A724E;
        }

        .kpi-icon-warning {
            background: rgba(245, 158, 11, 0.15);
            color: #b45309;
        }

        .kpi-icon-green {
            background: rgba(16, 185, 129, 0.15);
            color: #047857;
        }

        /* Exact public contact cards preview styling */
        .preview-contact-summary-card {
            background: linear-gradient(135deg, #FBF8F5 0%, #F5EBE1 100%);
            border-radius: 18px !important;
            padding: 20px 18px;
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1);
            border: 1.5px solid rgba(154, 114, 78, 0.22);
            box-shadow: 0 4px 15px rgba(68, 35, 5, 0.05);
        }
        .preview-contact-summary-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(68, 35, 5, 0.10);
            background: #ffffff;
            border-color: #9A724E;
        }
        .preview-contact-summary-icon {
            width: 48px;
            height: 48px;
            min-width: 48px;
            border-radius: 14px;
            background: linear-gradient(135deg, #442305 0%, #9A724E 100%);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            box-shadow: 0 6px 14px rgba(68, 35, 5, 0.25);
            border: 1px solid rgba(244, 226, 216, 0.4);
        }
        .preview-contact-summary-text-box {
            flex: 1;
            min-width: 0;
        }
        .preview-contact-summary-title {
            font-family: "Cormorant Upright", "Playfair Display", Georgia, serif;
            font-size: 1.25rem;
            font-weight: 700;
            color: #442305;
            margin-bottom: 3px;
        }
        .preview-contact-summary-txt {
            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 0.85rem;
            color: #5C4A3E;
            font-weight: 500;
            line-height: 1.5;
            margin: 0;
            overflow-wrap: anywhere;
            word-break: normal;
        }

        /* Table Styling */
        .hotel-table thead th {
            background: #fdfaf7 !important;
            color: #442305 !important;
            font-size: 0.78rem !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 0.5px !important;
            border-bottom: 2px solid #e8decb !important;
            padding: 14px 16px !important;
        }

        .hotel-table tbody td {
            padding: 14px 16px !important;
            border-bottom: 1px solid #f1f5f9 !important;
            vertical-align: middle;
        }

        .hotel-table tbody tr:hover {
            background-color: #fdfbf7 !important;
        }

        .guest-name-text {
            color: #442305;
            font-weight: 700;
            font-size: 0.95rem;
        }

        .guest-email-link {
            color: #B88E68;
            font-weight: 500;
            font-size: 0.85rem;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .guest-email-link:hover {
            color: #442305;
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    <!-- Page Header & Action Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <div class="d-flex align-items-center gap-2 mb-1">
                <span class="badge bg-warning bg-opacity-25 text-warning-emphasis px-2 py-1 small rounded-pill fw-semibold font-monospace">Public Website Contact</span>
                <span class="text-muted small">&bull; Admin Portal</span>
            </div>
            <h2 class="fw-bold mb-1 enquiry-page-title">Contact Messages &amp; Website Cards</h2>
            <p class="text-muted small mb-0">Fill hotel Location, Phone &amp; Email cards, and manage guest enquiries.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="../Contact.aspx" target="_blank" class="btn-hotel-secondary">
                <i class="bi bi-box-arrow-up-right"></i> Preview Live Website
            </a>
            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="btn-hotel-secondary" OnClick="btnRefresh_Click">
                <i class="bi bi-arrow-clockwise"></i> Refresh Inbox
            </asp:LinkButton>
        </div>
    </div>

    <!-- Alert / Status Panel -->
    <asp:Panel ID="pnlEnquiryMsg" runat="server" Visible="false" CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-info-circle-fill fs-4 text-warning"></i>
            <div>
                <asp:Label ID="lblEnquiryMsg" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- ==========================================
         FORM: LOCATION & PHONE/EMAIL CARDS FILL
         Theme matching Hotel Management Admin
         ========================================== -->
    <div class="hotel-admin-card">
        <div class="hotel-admin-card-header">
            <h4 class="hotel-admin-card-title">
                <i class="bi bi-geo-alt-fill text-warning"></i> Add Hotel Contact Cards (Location &amp; Phone/Email)
            </h4>
            <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                <i class="bi bi-shield-check text-success me-1"></i> Live Database Sync
            </span>
        </div>

        <div class="hotel-admin-card-body">
            <p class="text-muted small mb-4">
                Fill Location and Phone &amp; Email details below to add or update the cards on the public Contact Us page.
            </p>

            <div class="row g-4 align-items-start">
                <!-- Left Side: Form Controls -->
                <div class="col-12 col-xl-7">
                    
                    <!-- Field 1: Location Address -->
                    <div class="mb-3">
                        <label class="form-label-hotel">
                            <i class="bi bi-geo-alt text-danger"></i> Card 1: Location Address <span class="text-danger">*</span>
                        </label>
                        <asp:TextBox ID="txtCardLocation" runat="server" TextMode="MultiLine" Rows="2" 
                            CssClass="form-control-hotel" 
                            placeholder="Enter hotel location address (e.g. Diplomatic Enclave, Chanakyapuri, New Delhi...)"
                            oninput="updateCardLivePreview()"></asp:TextBox>
                        <span class="text-muted extra-small mt-1 d-block">Hotel address shown on the Location card.</span>
                    </div>

                    <div class="row g-3 mb-3">
                        <!-- Field 2: Phone Number -->
                        <div class="col-12 col-md-6">
                            <label class="form-label-hotel">
                                <i class="bi bi-telephone text-primary"></i> Card 2: Phone Number <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-hotel-addon">
                                    <i class="bi bi-telephone"></i>
                                </span>
                                <asp:TextBox ID="txtCardPhone" runat="server" 
                                    CssClass="form-control-hotel form-control-hotel-grouped" 
                                    placeholder="+91 11 2410 8888"
                                    oninput="updateCardLivePreview()"></asp:TextBox>
                            </div>
                            <span class="text-muted extra-small mt-1 d-block">Shown on Line 1 of Phone &amp; Email card.</span>
                        </div>

                        <!-- Field 3: Email Address -->
                        <div class="col-12 col-md-6">
                            <label class="form-label-hotel">
                                <i class="bi bi-envelope text-warning"></i> Card 2: Contact Email <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-hotel-addon">
                                    <i class="bi bi-envelope"></i>
                                </span>
                                <asp:TextBox ID="txtCardEmail" runat="server" TextMode="Email" 
                                    CssClass="form-control-hotel form-control-hotel-grouped" 
                                    placeholder="contact@hotelmanagement.com"
                                    oninput="updateCardLivePreview()"></asp:TextBox>
                            </div>
                            <span class="text-muted extra-small mt-1 d-block">Shown on Line 2 of Phone &amp; Email card.</span>
                        </div>
                    </div>

                    <div class="d-flex flex-wrap align-items-center justify-content-between pt-2 gap-2">
                        <span class="text-muted extra-small">
                            <i class="bi bi-clock-history me-1 text-gold"></i> <asp:Label ID="lblCardsLastUpdated" runat="server" Text="Ready to add new details"></asp:Label>
                        </span>
                        <asp:Button ID="btnSaveContactCards" runat="server" 
                            Text="Save Contact Cards" 
                            CssClass="btn-hotel-primary" 
                            OnClick="btnSaveContactCards_Click" />
                    </div>
                </div>

                <!-- Right Side: Exact Visual Card Preview -->
                <div class="col-12 col-xl-5">
                    <div class="p-3 rounded-4" style="background-color: #faf9f6; border: 1.5px dashed rgba(154, 114, 78, 0.35);">
                        <div class="d-flex align-items-center justify-content-between mb-3 pb-2 border-bottom">
                            <span class="small fw-bold" style="color: #442305; font-family: 'Playfair Display', Georgia, serif;">
                                <i class="bi bi-eye text-gold me-1"></i> Real-Time Live Preview
                            </span>
                            <span class="badge bg-white text-dark border border-warning-subtle small font-monospace">Website Output</span>
                        </div>

                        <!-- Card 1: Location Preview -->
                        <div class="mb-3">
                            <div class="preview-contact-summary-card">
                                <div class="preview-contact-summary-icon">
                                    <i class="bi bi-geo-alt"></i>
                                </div>
                                <div class="preview-contact-summary-text-box">
                                    <h3 class="preview-contact-summary-title">Location</h3>
                                    <p class="preview-contact-summary-txt" id="cardPreviewLocation"></p>
                                </div>
                            </div>
                        </div>

                        <!-- Card 2: Phone & Email Preview -->
                        <div>
                            <div class="preview-contact-summary-card">
                                <div class="preview-contact-summary-icon">
                                    <i class="bi bi-telephone"></i>
                                </div>
                                <div class="preview-contact-summary-text-box">
                                    <h3 class="preview-contact-summary-title">Phone &amp; Email</h3>
                                    <p class="preview-contact-summary-txt">
                                        <span id="cardPreviewPhone"></span><br />
                                        <span id="cardPreviewEmail"></span>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- KPI Strip matching Hotel Management Admin Dashboard -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Messages</span>
                        <div class="kpi-value mt-1" id="lblTotalCount" runat="server">0</div>
                        <span class="text-muted small">All Guest Inquiries</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-inbox-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Unread Messages</span>
                        <div class="kpi-value mt-1 text-warning" id="lblUnreadCount" runat="server">0</div>
                        <span class="text-muted small">Awaiting Review</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-warning">
                        <i class="bi bi-envelope-exclamation-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Received Today</span>
                        <div class="kpi-value mt-1 text-success" id="lblTodayCount" runat="server">0</div>
                        <span class="text-muted small">New Messages Today</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-calendar-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Enquiries Repeater / Grid -->
    <div class="hotel-admin-card">
        <div class="hotel-admin-card-header">
            <h4 class="hotel-admin-card-title">
                <i class="bi bi-envelope-paper-fill text-warning"></i> Guest Messages Inbox
            </h4>
            <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                <i class="bi bi-envelope text-gold me-1"></i> Live Guest Inquiries
            </span>
        </div>

        <div class="p-0">
            <asp:Repeater ID="rptEnquiries" runat="server" OnItemCommand="rptEnquiries_ItemCommand">
                <HeaderTemplate>
                    <div class="table-responsive">
                        <table class="table hotel-table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>#ID</th>
                                    <th>Guest Info</th>
                                    <th>Subject</th>
                                    <th>Message</th>
                                    <th>Submitted Date</th>
                                    <th>Status</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="fw-bold text-muted small">#<%# Eval("EnquiryID") %></td>
                        <td>
                            <div class="guest-name-text"><%# Eval("GuestName") %></div>
                            <a href='mailto:<%# Eval("EmailAddress") %>' class="guest-email-link"><i class="bi bi-envelope me-1"></i><%# Eval("EmailAddress") %></a>
                        </td>
                        <td class="fw-semibold" style="color: #334155;"><%# Eval("Subject") %></td>
                        <td style="max-width: 320px;">
                            <span class="small text-dark text-break"><%# Eval("Message") %></span>
                        </td>
                        <td class="small text-muted"><%# Convert.ToDateTime(Eval("SubmittedAt")).ToString("dd MMM yyyy, hh:mm tt") %></td>
                        <td>
                            <asp:LinkButton ID="btnToggleBadge" runat="server" CommandName="ToggleStatus" CommandArgument='<%# Eval("EnquiryID") %>' CssClass="text-decoration-none" Title="Click to toggle Read / Unread status">
                                <span class='<%# Eval("Status").ToString() == "Unread" ? "badge bg-warning-subtle text-warning-emphasis border border-warning-subtle py-1.5 px-2.5 rounded-pill" : "badge bg-success-subtle text-success border border-success-subtle py-1.5 px-2.5 rounded-pill" %>' style="cursor: pointer;">
                                    <i class='<%# Eval("Status").ToString() == "Unread" ? "bi bi-envelope me-1" : "bi bi-check2-all me-1" %>'></i>
                                    <%# Eval("Status") %>
                                </span>
                            </asp:LinkButton>
                        </td>
                        <td class="text-end">
                            <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="ToggleStatus" CommandArgument='<%# Eval("EnquiryID") %>' 
                                CssClass='<%# Eval("Status").ToString() == "Unread" ? "btn btn-sm btn-outline-success me-1 fw-semibold rounded-3" : "btn btn-sm btn-light border text-muted me-1 fw-semibold rounded-3" %>' 
                                Title='<%# Eval("Status").ToString() == "Unread" ? "Mark as Read" : "Mark as Unread" %>'>
                                <i class='<%# Eval("Status").ToString() == "Unread" ? "bi bi-check2 me-1" : "bi bi-envelope me-1" %>'></i>
                                <%# Eval("Status").ToString() == "Unread" ? "Mark Read" : "Unread" %>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("EnquiryID") %>' OnClientClick="return confirm('Are you sure you want to delete this enquiry message?');" CssClass="btn btn-sm btn-light border text-danger rounded-3" Title="Delete Message">
                                <i class="bi bi-trash"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                            </tbody>
                        </table>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <asp:Panel ID="pnlNoData" runat="server" Visible="false" CssClass="text-center py-5">
                <i class="bi bi-inbox text-muted display-4 mb-3 d-block"></i>
                <h5 class="fw-bold text-dark" style="font-family: 'Playfair Display', Georgia, serif;">No Contact Messages Found</h5>
                <p class="text-muted small mb-0">Messages submitted by guests on the Contact page will automatically appear here.</p>
            </asp:Panel>
        </div>
    </div>

    <!-- Client-side Real-time Preview Script -->
    <script>
        function updateCardLivePreview() {
            var txtLoc = document.getElementById('<%= txtCardLocation.ClientID %>');
            var txtPh = document.getElementById('<%= txtCardPhone.ClientID %>');
            var txtEm = document.getElementById('<%= txtCardEmail.ClientID %>');

            var prevLoc = document.getElementById('cardPreviewLocation');
            var prevPh = document.getElementById('cardPreviewPhone');
            var prevEm = document.getElementById('cardPreviewEmail');

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

        document.addEventListener('DOMContentLoaded', updateCardLivePreview);
    </script>
</asp:Content>
