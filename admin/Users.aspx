<%@ Page Title="Registered Customers & Logins | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Admin_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Registered Guests and User Logins Directory">
    <style>
        /* ==========================================
           LUXURY HOTEL MANAGEMENT THEME STYLES
           Theme: Royal Brown (#442305), Warm Gold (#B88E68), Canvas (#f8fafc)
           ========================================== */
        .users-page-title {
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
            flex-wrap: wrap;
            gap: 12px;
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

        .search-control-hotel {
            background-color: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            padding: 6px 16px;
            font-size: 0.85rem;
            color: #ffffff !important;
            transition: all 0.25s ease;
            outline: none;
            width: 220px;
        }

        .search-control-hotel::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .search-control-hotel:focus {
            background-color: #ffffff;
            color: #0f172a !important;
            border-color: #B88E68;
            box-shadow: 0 0 0 3px rgba(184, 142, 104, 0.25);
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

        .kpi-icon-green {
            background: rgba(16, 185, 129, 0.15);
            color: #047857;
        }

        .kpi-icon-blue {
            background: rgba(59, 130, 246, 0.15);
            color: #1d4ed8;
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
                <span class="badge bg-warning bg-opacity-25 text-warning-emphasis px-2 py-1 small rounded-pill fw-semibold font-monospace">Guest Management</span>
                <span class="text-muted small">&bull; Admin Portal</span>
            </div>
            <h2 class="fw-bold mb-1 users-page-title">Registered Guests &amp; User Accounts</h2>
            <p class="text-muted small mb-0">Comprehensive live customer profiles and guest authentication sessions from SQL Server database.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="Dashboard.aspx" class="btn-hotel-secondary">
                <i class="bi bi-speedometer2"></i> Executive Dashboard
            </a>
            <a href="../Register.aspx" target="_blank" class="btn-hotel-secondary">
                <i class="bi bi-box-arrow-up-right"></i> Guest Register Portal
            </a>
        </div>
    </div>

    <!-- Luxury KPI Strip -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Registered Guests</span>
                        <div class="kpi-value mt-1" id="lblTotalGuests" runat="server">0</div>
                        <span class="text-muted small">Total User Accounts in DB</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-people-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Guest Logins Recorded</span>
                        <div class="kpi-value mt-1 text-success" id="lblTotalLogins" runat="server">0</div>
                        <span class="text-muted small">Active Guest Sessions</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-box-arrow-in-right"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-4">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Database Security</span>
                        <div class="kpi-value mt-1" style="color: #1d4ed8; font-size: 1.45rem;">Verified</div>
                        <span class="text-muted small">SQL Server Live Sync Active</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-shield-check"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ==========================================
         1. REGISTERED GUESTS (ASP.NET DATABASE GRIDVIEW)
         ========================================== -->
    <div id="databaseGuestsPanel" class="hotel-admin-card">
        <div class="hotel-admin-card-header">
            <div class="d-flex align-items-center gap-3">
                <h4 class="hotel-admin-card-title">
                    <i class="bi bi-people-fill text-warning"></i> Registered Guests Directory
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                    <i class="bi bi-database text-gold me-1"></i> Users Table
                </span>
            </div>
            <div>
                <input type="text" id="userSearchInput" class="search-control-hotel"
                    placeholder="Search guests..." onkeyup="filterRegisteredGuests()" />
            </div>
        </div>

        <div class="p-0">
            <div class="table-responsive">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                    CssClass="table hotel-table table-hover align-middle mb-0" GridLines="None"
                    EmptyDataText="No registered guests found in database.">
                    <Columns>
                        <asp:TemplateField HeaderText="User ID">
                            <ItemTemplate>
                                <span class="badge bg-light text-dark border font-monospace small">#<%# Eval("UserId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Guest Full Name">
                            <ItemTemplate>
                                <div class="guest-name-text">
                                    <i class="bi bi-person-circle text-gold me-1"></i>
                                    <%# Eval("FirstName") + " " + Eval("LastName") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email Address">
                            <ItemTemplate>
                                <a href='mailto:<%# Eval("Email") %>' class="guest-email-link">
                                    <i class="bi bi-envelope me-1"></i><%# Eval("Email") %>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact Phone">
                            <ItemTemplate>
                                <span class="text-dark small">
                                    <i class="bi bi-telephone text-muted me-1"></i><%# Eval("Phone") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Registered Date">
                            <ItemTemplate>
                                <span class="small text-muted">
                                    <i class="bi bi-calendar3 text-muted me-1"></i><%# Convert.ToDateTime(Eval("CreatedAt")).ToString("dd-MMM-yyyy hh:mm tt") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- ==========================================
         2. USER LOGINS DIRECTORY (DATABASE: LOGIN TABLE)
         ========================================== -->
    <div id="databaseLoginsPanel" class="hotel-admin-card">
        <div class="hotel-admin-card-header">
            <div class="d-flex align-items-center gap-3">
                <h4 class="hotel-admin-card-title">
                    <i class="bi bi-box-arrow-in-right text-warning"></i> User Logins &amp; Authentication Sessions
                </h4>
                <span class="badge bg-white text-dark px-3 py-1.5 rounded-pill font-monospace small">
                    <i class="bi bi-shield-lock text-success me-1"></i> [Login] Table (Role: Guest)
                </span>
            </div>
            <div>
                <input type="text" id="loginSearchInput" class="search-control-hotel"
                    placeholder="Search user logins..." onkeyup="filterLoginDirectory()" />
            </div>
        </div>

        <div class="p-0">
            <div class="table-responsive">
                <asp:GridView ID="gvLogins" runat="server" AutoGenerateColumns="False"
                    CssClass="table hotel-table table-hover align-middle mb-0" GridLines="None"
                    EmptyDataText="No user login records found in database.">
                    <Columns>
                        <asp:TemplateField HeaderText="Login ID">
                            <ItemTemplate>
                                <span class="badge bg-light text-dark border font-monospace small">#<%# Eval("LoginId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="User ID">
                            <ItemTemplate>
                                <span class="badge bg-light text-secondary border font-monospace small">UID-<%# Eval("UserId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Guest Username">
                            <ItemTemplate>
                                <div class="guest-name-text">
                                    <i class="bi bi-person-badge text-gold me-1"></i>
                                    <%# Eval("UserName") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Registered Email">
                            <ItemTemplate>
                                <a href='mailto:<%# Eval("Email") %>' class="guest-email-link">
                                    <i class="bi bi-envelope me-1"></i><%# Eval("Email") %>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Session Timestamp">
                            <ItemTemplate>
                                <span class="small text-muted">
                                    <i class="bi bi-clock-history text-muted me-1"></i><%# Convert.ToDateTime(Eval("LoginTime")).ToString("dd-MMM-yyyy hh:mm:ss tt") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Session Status">
                            <ItemTemplate>
                                <span class="badge bg-success-subtle text-success border border-success-subtle py-1.5 px-2.5 rounded-pill">
                                    <i class="bi bi-check-circle me-1"></i><%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        function filterRegisteredGuests() {
            var input = document.getElementById('userSearchInput');
            var table = document.querySelector('[id$="gvUsers"]');
            if (!input || !table) return;

            var query = input.value.trim().toLowerCase();
            var rows = table.querySelectorAll('tr');

            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.querySelector('th')) continue;
                var text = row.textContent.toLowerCase();
                row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
            }
        }

        function filterLoginDirectory() {
            var input = document.getElementById('loginSearchInput');
            var table = document.querySelector('[id$="gvLogins"]');
            if (!input || !table) return;

            var query = input.value.trim().toLowerCase();
            var rows = table.querySelectorAll('tr');

            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                if (row.querySelector('th')) continue;
                var text = row.textContent.toLowerCase();
                row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
            }
        }
    </script>
</asp:Content>
