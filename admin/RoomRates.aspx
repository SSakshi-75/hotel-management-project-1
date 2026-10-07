<%@ Page Title="Room Rates | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="RoomRates.aspx.cs" Inherits="Admin_RoomRates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Room Rates Administration" />
    <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Action Bar matching ManageHotel & Availability -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item text-muted">Rates &amp; Availability</li>
                    <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Room Rates</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-1 manage-hotel-title">Room Rates Management</h2>
            <p class="text-muted small mb-0">Manage rate plans, occupancy pricing, seasonal tariffs, and room-only vs breakfast packages.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="Availability.aspx" class="btn-hotel-preview-site">
                <i class="bi bi-calendar3"></i> Room Availability
            </a>
            <a href="AddRoom.aspx" class="btn-hotel-add-room">
                <i class="bi bi-plus-lg"></i> Add Room Rate
            </a>
        </div>
    </div>

    <!-- Luxury KPI Strip matching ManageHotel & Availability -->
    <div class="row g-3 mb-4">
        <!-- Total Rate Plans -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Rate Plans</span>
                        <div class="kpi-value mt-1" id="kpiTotalPlans" runat="server">0</div>
                        <span class="text-muted small">Configured Tariffs</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-tag-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Active Plans -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Active Tariffs</span>
                        <div class="kpi-value mt-1 text-success" id="kpiActivePlans" runat="server">0 Active</div>
                        <span class="text-muted small">Live on Guest Portal</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-broadcast"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Starting Rate -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Starting Tariff</span>
                        <div class="kpi-value mt-1 text-primary" id="kpiMinRate" runat="server">&#8377;0</div>
                        <span class="text-muted small">Base Room Rate / Night</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-currency-rupee"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Premium Rate -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Highest Premium Rate</span>
                        <div class="kpi-value mt-1 text-purple" id="kpiMaxRate" runat="server">&#8377;0</div>
                        <span class="text-muted small">Executive / Penthouse Rate</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-purple">
                        <i class="bi bi-stars"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Master Room Rates Card matching ManageHotel design -->
    <div class="manage-hotel-card">

        <!-- Header: Royal Brown / Gold Gradient Bar -->
        <div class="manage-hotel-header">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-currency-rupee text-warning fs-5"></i>
                <h4 class="mb-0">Room Tariffs &amp; Pricing Matrix</h4>
            </div>
            <div>
                <span class="header-count-pill" id="lblTariffPill" runat="server">
                    <i class="bi bi-shield-check me-1"></i> Live Real-Time Tariffs
                </span>
            </div>
        </div>

        <!-- Search & Filter Toolbar -->
        <div class="manage-hotel-toolbar">
            <div class="row g-3 align-items-center">
                <div class="col-12 col-md-5">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-search"></i></span>
                        <input type="text" id="ratesSearchInput" class="form-control border-start-0 bg-light" placeholder="Search room or rate plan..." onkeyup="filterRatesTable()">
                    </div>
                </div>
                <div class="col-6 col-md-4">
                    <select class="form-select bg-light" id="planFilterSelect" onchange="filterRatesTable()">
                        <option value="">All Rate Plans &amp; Categories</option>
                        <option value="Deluxe">Deluxe</option>
                        <option value="Heritage Suite">Heritage Suite</option>
                        <option value="Penthouse">Penthouse</option>
                        <option value="Family">Family</option>
                    </select>
                </div>
                <div class="col-6 col-md-3 text-end">
                    <span class="text-muted small fw-semibold">Active Tariffs: <strong class="text-dark"><asp:Literal ID="litActiveTariffs" runat="server" Text="0 Plans"></asp:Literal></strong></span>
                </div>
            </div>
        </div>

        <!-- Rates Table with explicit gridlines & matching typography -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover hotel-rooms-table align-middle" id="ratesTable">
                <thead>
                    <tr>
                        <th class="ps-3">Room &amp; Suite Details</th>
                        <th class="text-center">Category</th>
                        <th class="text-center">Base Tariff / Night</th>
                        <th class="text-center">Status</th>
                        <th class="text-end pe-3">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptRoomRates" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="ps-3">
                                    <div class="room-name-heading">
                                        <%# Eval("RoomName") %>
                                    </div>
                                    <div class="room-specs-list">
                                        <span class="room-spec-item" title="Room ID">
                                            <i class="bi bi-hash"></i> Room #<%# Eval("RoomID") %>
                                        </span>
                                    </div>
                                </td>
                                <td class="text-center">
                                    <span class='<%# GetCategoryBadgeClass(Eval("RoomCategory")) %>'>
                                        <%# Eval("RoomCategory") %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="hotel-tariff-amount">
                                        &#8377; <%# Convert.ToDecimal(Eval("PricePerNight")).ToString("N0") %>
                                    </span>
                                    <span class="hotel-tariff-period">
                                        per room / night
                                    </span>
                                </td>
                                <td class="text-center">
                                    <%# GetStatusBadge(Eval("IsActive")) %>
                                </td>
                                <td class="text-end pe-3">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href='EditRoom.aspx?id=<%# Eval("RoomID") %>' class="btn btn-sm rounded-pill px-3 shadow-sm d-flex align-items-center gap-1" style="background: #fdfaf7; color: #442305; border: 1px solid #e8d7c5; font-weight: 600; font-size: 0.82rem;" title="Edit Rate &amp; Room">
                                            <i class="bi bi-pencil-square" style="color: #B88E68;"></i> Edit
                                        </a>
                                        <a href='<%# ResolveUrl("~/RoomDetails.aspx?RoomId=" + Eval("RoomID")) %>' target="_blank" class="btn btn-sm rounded-pill px-3 shadow-sm d-flex align-items-center gap-1" style="background: #ffffff; color: #64748b; border: 1px solid #e2e8f0; font-weight: 600; font-size: 0.82rem;" title="View Live Page">
                                            <i class="bi bi-eye" style="color: #64748b;"></i> View
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <% if (rptRoomRates.Items.Count == 0) { %>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-5">
                            <i class="bi bi-tag fs-1 opacity-50 d-block mb-2 text-warning"></i>
                            <h6 class="fw-bold text-dark mb-1">No Room Rates Configured</h6>
                            <p class="small text-muted mb-0">Click &ldquo;Add Room Rate&rdquo; to set up tariffs.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="js/roomrates.js"></script>
</asp:Content>
