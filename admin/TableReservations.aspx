<%@ Page Title="Table Reservations | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="TableReservations.aspx.cs" Inherits="Admin_TableReservations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Manage Table Reservations for The Royal Kitchen - Single Hotel Restaurant" />
    <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0" />
    <style>
        .res-status-pending { background: #fef3c7; color: #92400e; border: 1px solid #fde68a; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-confirmed { background: #dbeafe; color: #1e40af; border: 1px solid #bfdbfe; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-seated { background: #e0e7ff; color: #3730a3; border: 1px solid #c7d2fe; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-completed { background: #d1fae5; color: #065f46; border: 1px solid #a7f3d0; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-cancelled { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        
        .table-num-badge {
            background: #442305;
            color: #ffffff;
            font-weight: 700;
            padding: 5px 12px;
            border-radius: 8px;
            font-family: 'Playfair Display', Georgia, serif;
            letter-spacing: 0.5px;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Floating 2-Second Confirmation Toast -->
    <div id="confirmationToast" style="display:none; position:fixed; top:28px; left:50%; transform:translate(-50%, -20px); z-index:999999; background:#198754; color:#ffffff; padding:12px 28px; border-radius:50px; box-shadow:0 8px 24px rgba(0,0,0,0.22); font-size:0.95rem; font-weight:600; align-items:center; gap:10px; pointer-events:none; transition:opacity 0.3s ease, transform 0.3s ease;">
        <i class="bi bi-check-circle-fill fs-5 text-white"></i>
        <span id="confirmationToastMsg">Updated successfully</span>
    </div>

    <!-- Page Header & Action Bar matching ManageHotel & Bookings -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item text-muted">Dining &amp; Restaurant</li>
                    <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Table Reservations</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-1 manage-hotel-title">Table Reservations Dashboard</h2>
            <p class="text-muted small mb-0">Overview and status workflow of table reservations for <strong>The Royal Kitchen</strong>.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="RestaurantTables.aspx" class="btn-hotel-preview-site">
                <i class="bi bi-grid-3x3-gap"></i> Manage Tables
            </a>
            <a href="../TableReservation.aspx" target="_blank" class="btn-hotel-add-room">
                <i class="bi bi-plus-circle"></i> New Table Reservation
            </a>
        </div>
    </div>

    <!-- Alert / Toast Messages -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false"
        CssClass="alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-check-circle-fill fs-4 text-success"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Luxury KPI Strip matching ManageHotel & Bookings -->
    <div class="row g-3 mb-4">
        <!-- Total -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total</span>
                        <div class="kpi-value mt-1">
                            <asp:Label ID="lblTotalCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">All Reservations</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-journal-text"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pending -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Pending</span>
                        <div class="kpi-value mt-1 text-warning">
                            <asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Awaiting Review</span>
                    </div>
                    <div class="kpi-icon-wrap" style="background: #fffbeb; color: #b45309; border: 1px solid #fde68a;">
                        <i class="bi bi-clock-history"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmed -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Confirmed</span>
                        <div class="kpi-value mt-1 text-primary">
                            <asp:Label ID="lblConfirmedCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Awaiting Seating</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-check2-circle"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Seated -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Seated</span>
                        <div class="kpi-value mt-1" style="color: #7c3aed;">
                            <asp:Label ID="lblSeatedCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Currently Dining</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-purple">
                        <i class="bi bi-person-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Completed -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Completed</span>
                        <div class="kpi-value mt-1 text-success">
                            <asp:Label ID="lblCompletedCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Dining Finished</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cancelled -->
        <div class="col-6 col-md-4 col-xl-2">
            <div class="hotel-kpi-card h-100">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Cancelled</span>
                        <div class="kpi-value mt-1 text-danger">
                            <asp:Label ID="lblCancelledCount" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Void / Cancelled</span>
                    </div>
                    <div class="kpi-icon-wrap" style="background: #fee2e2; color: #dc2626; border: 1px solid #fecaca;">
                        <i class="bi bi-x-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Master Reservations Card matching ManageHotel & Bookings design -->
    <div class="manage-hotel-card">

        <!-- Header: Royal Brown / Gold Gradient Bar -->
        <div class="manage-hotel-header">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-cup-hot-fill text-warning fs-5"></i>
                <h4 class="mb-0">Table Reservations Ledger</h4>
            </div>
            <div>
                <span class="header-count-pill">
                    <i class="bi bi-shield-check me-1"></i>
                    All Live Bookings
                </span>
            </div>
        </div>

        <!-- Filter & Search Toolbar matching ManageHotel -->
        <div class="manage-hotel-toolbar">
            <div class="row align-items-center g-3">
                <!-- Status Filter Pills -->
                <div class="col-12 col-xl-7 d-flex flex-wrap align-items-center gap-2">
                    <button type="button" class="filter-pill-btn active" onclick="filterResStatus('All', this); return false;">All (<asp:Literal ID="litFilterAll" runat="server" Text="0" />)</button>
                    <button type="button" class="filter-pill-btn" onclick="filterResStatus('Pending', this); return false;">Pending (<asp:Literal ID="litFilterPending" runat="server" Text="0" />)</button>
                    <button type="button" class="filter-pill-btn" onclick="filterResStatus('Confirmed', this); return false;">Confirmed (<asp:Literal ID="litFilterConfirmed" runat="server" Text="0" />)</button>
                    <button type="button" class="filter-pill-btn" onclick="filterResStatus('Seated', this); return false;">Seated (<asp:Literal ID="litFilterSeated" runat="server" Text="0" />)</button>
                    <button type="button" class="filter-pill-btn" onclick="filterResStatus('Completed', this); return false;">Completed (<asp:Literal ID="litFilterCompleted" runat="server" Text="0" />)</button>
                    <button type="button" class="filter-pill-btn" onclick="filterResStatus('Cancelled', this); return false;">Cancelled (<asp:Literal ID="litFilterCancelled" runat="server" Text="0" />)</button>
                </div>

                <!-- Search Box -->
                <div class="col-12 col-xl-5">
                    <div class="search-wrap-luxury">
                        <i class="bi bi-search search-icon-luxury"></i>
                        <input type="text" id="txtSearchReservation" class="form-control form-control-luxury-search w-100"
                            placeholder="Search code, customer name, phone, table..." onkeyup="searchReservationsTable();" />
                    </div>
                </div>
            </div>
        </div>

        <!-- Data Table with explicit gridlines matching hotel-rooms-table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover hotel-rooms-table align-middle mb-0" id="tblReservations">
                <thead>
                    <tr>
                        <th class="ps-4">Booking Code</th>
                        <th>Customer Details</th>
                        <th>Date &amp; Time</th>
                        <th class="text-center">Guests</th>
                        <th class="text-center">Assigned Table</th>
                        <th class="text-center">Status</th>
                        <th class="text-end pe-4" style="min-width: 170px;">Reservation Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptReservations" runat="server" OnItemCommand="rptReservations_ItemCommand">
                        <ItemTemplate>
                            <tr data-status='<%# Eval("Status") %>'>
                                <td class="ps-4">
                                    <span class="font-monospace fw-bold" style="color: #442305;"><%# Eval("BookingCode") %></span>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark"><%# Eval("CustomerName") %></div>
                                    <small class="text-muted"><%# Eval("CustomerPhone") %><%# Eval("CustomerEmail") != DBNull.Value && !string.IsNullOrEmpty(Eval("CustomerEmail").ToString()) ? " &bull; " + Eval("CustomerEmail") : "" %></small>
                                </td>
                                <td>
                                    <div class="fw-semibold text-dark"><%# Eval("ReservationDate", "{0:dd MMM yyyy}") %></div>
                                    <small class="text-muted"><i class="bi bi-clock me-1"></i> <%# Eval("TimeSlot") %></small>
                                </td>
                                <td class="text-center">
                                    <span class="badge" style="background: #fdf6ee; color: #85480d; border: 1px solid #fed7aa; padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                                        <i class="bi bi-people-fill me-1"></i><%# Eval("GuestCount") %> Guests
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="table-num-badge">Table <%# Eval("TableNumber") %></span>
                                </td>
                                <td class="text-center">
                                    <%# GetStatusBadge(Eval("Status") != null ? Eval("Status").ToString() : "") %>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex align-items-center gap-1 justify-content-end">
                                        <asp:LinkButton ID="btnConfirm" runat="server" CssClass="btn btn-sm btn-success px-2 py-1 small rounded-2"
                                            CommandName="ConfirmRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "pending" %>' ToolTip="Confirm Reservation">
                                            Confirm
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSeat" runat="server" CssClass="btn btn-sm btn-primary px-2 py-1 small rounded-2"
                                            CommandName="SeatRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "confirmed" %>' ToolTip="Mark Seated">
                                            Mark Seated
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnComplete" runat="server" CssClass="btn btn-sm btn-success px-2 py-1 small rounded-2"
                                            CommandName="CompleteRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "seated" %>' ToolTip="Complete Dining">
                                            Complete Dining
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-sm btn-outline-danger px-2 py-1 small rounded-2"
                                            CommandName="CancelRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "pending" || Eval("Status").ToString().ToLower() == "confirmed" %>'
                                            OnClientClick="return confirm('Are you sure you want to cancel this reservation?');" ToolTip="Cancel Reservation">
                                            Cancel
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-secondary px-2 py-1 small rounded-2"
                                            CommandName="DeleteRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this reservation record?');" ToolTip="Delete Record">
                                            <i class="bi bi-trash"></i>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                    <!-- Empty State -->
                    <tr id="trNoReservations" runat="server" visible="false">
                        <td colspan="7" class="text-center py-5 text-muted">
                            <i class="bi bi-calendar-x fs-1 d-block text-secondary mb-2"></i>
                            <strong class="text-dark d-block mb-1">No Table Reservations Found</strong>
                            <span class="small text-muted">Customer table bookings will appear here once submitted.</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- JAVASCRIPT LOGIC & CONFIRMATION SCRIPT -->
    <script src="js/tablereservations.js"></script>

</asp:Content>
