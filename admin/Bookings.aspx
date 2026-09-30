<%@ Page Title="Reservations & Guest Stay Lifecycle | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Bookings.aspx.cs" Inherits="Admin_Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Reservations & Guest Stay Lifecycle Management" />
    <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0" />
    <style>
        .badge-status-confirmed {
            background-color: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .badge-status-checkedin {
            background-color: #dbeafe;
            color: #1e40af;
            border: 1px solid #bfdbfe;
        }
        .badge-status-completed {
            background-color: #f3e8ff;
            color: #6b21a8;
            border: 1px solid #e9d5ff;
        }
        .badge-status-cancelled {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .lifecycle-step-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 14px;
            padding: 14px 16px;
            transition: all 0.25s ease;
        }

        .lifecycle-step-card:hover {
            border-color: #B88E68;
            box-shadow: 0 4px 15px rgba(184, 142, 104, 0.15);
            transform: translateY(-2px);
        }

        .lifecycle-step-number {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #442305;
            color: #ffffff;
            font-weight: 700;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-lifecycle-action {
            font-size: 0.78rem;
            padding: 5px 12px;
            font-weight: 600;
            letter-spacing: 0.2px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Status Alert Notification -->
    <asp:Panel ID="pnlAlert" runat="server" Visible="false">
        <i class="bi bi-info-circle-fill fs-5 me-2"></i>
        <div>
            <asp:Label ID="lblAlertText" runat="server"></asp:Label>
        </div>
        <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Page Header & Action Bar matching ManageHotel & Availability -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold mb-1 manage-hotel-title">Reservations &amp; Guest Stay Lifecycle</h2>
            <p class="text-muted small mb-0">Live reservation ledger connected directly to SQL Server. Manage check-in, check-out, and auto-sync room availability.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="Availability.aspx" class="btn-hotel-preview-site">
                <i class="bi bi-calendar3"></i> Room Availability
            </a>
            <a href="../BookNow.aspx" target="_blank" class="btn-hotel-add-room">
                <i class="bi bi-box-arrow-up-right"></i> Customer Booking Portal
            </a>
        </div>
    </div>

    <!-- Interactive Guest Stay Lifecycle Progress Map matching ManageHotel theme -->
    <div class="manage-hotel-card p-4 mb-4">
        <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-3">
            <h6 class="fw-bold mb-0 d-flex align-items-center gap-2" style="font-family: 'Playfair Display', Georgia, serif; color: #442305; font-size: 1.05rem;">
                <i class="bi bi-diagram-3-fill" style="color: #B88E68;"></i> End-to-End Guest Booking &amp; Stay Lifecycle Flow
            </h6>
            <span class="badge" style="background: #fdf6ee; color: #85480d; border: 1px solid #fed7aa; font-size: 0.75rem; font-weight: 600;">
                <i class="bi bi-arrow-repeat me-1"></i> Automated Lifecycle Stages
            </span>
        </div>

        <div class="row g-2 align-items-center text-center">
            <!-- Step 1 -->
            <div class="col-md">
                <div class="lifecycle-step-card">
                    <div class="lifecycle-step-number mx-auto mb-1">1</div>
                    <div class="fw-bold text-dark small">Search Dates</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Customer Portal</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5" style="color: #B88E68;"></i></div>

            <!-- Step 2 -->
            <div class="col-md">
                <div class="lifecycle-step-card">
                    <div class="lifecycle-step-number mx-auto mb-1">2</div>
                    <div class="fw-bold text-dark small">Select Suite</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Capacity &amp; Rate</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5" style="color: #B88E68;"></i></div>

            <!-- Step 3 -->
            <div class="col-md">
                <div class="lifecycle-step-card">
                    <div class="lifecycle-step-number mx-auto mb-1">3</div>
                    <div class="fw-bold text-dark small">Reservation</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Double-Check Lock</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5" style="color: #B88E68;"></i></div>

            <!-- Step 4 -->
            <div class="col-md">
                <div class="lifecycle-step-card border-primary" style="background: #f0f7ff;">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-primary">4</div>
                    <div class="fw-bold text-primary small">Check-In</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Occupied</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5" style="color: #B88E68;"></i></div>

            <!-- Step 5 -->
            <div class="col-md">
                <div class="lifecycle-step-card" style="background: #faf5ff; border-color: #d8b4fe;">
                    <div class="lifecycle-step-number mx-auto mb-1" style="background: #6b21a8;">5</div>
                    <div class="fw-bold small" style="color: #6b21a8;">Check-Out</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Cleaning</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5" style="color: #B88E68;"></i></div>

            <!-- Step 6 -->
            <div class="col-md">
                <div class="lifecycle-step-card border-success" style="background: #f0fdf4;">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-success">6</div>
                    <div class="fw-bold text-success small">Completed</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Available</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Booking Ledger KPI Row matching ManageHotel luxury KPI cards -->
    <div class="row g-3 mb-4">
        <!-- Total Reservations -->
        <div class="col-sm-6 col-xl">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Reservations</span>
                        <div class="kpi-value mt-1">
                            <asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">All Time Bookings</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-journal-text"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmed (Upcoming) -->
        <div class="col-sm-6 col-xl">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Confirmed (Upcoming)</span>
                        <div class="kpi-value mt-1 text-success">
                            <asp:Label ID="lblConfirmedBookings" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Awaiting Check-In</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-check-circle-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- In-House Guests -->
        <div class="col-sm-6 col-xl">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">In-House Guests</span>
                        <div class="kpi-value mt-1 text-primary">
                            <asp:Label ID="lblInHouseGuests" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Currently Checked-In</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-person-badge-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Completed Stays -->
        <div class="col-sm-6 col-xl">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Completed Stays</span>
                        <div class="kpi-value mt-1" style="color: #6b21a8;">
                            <asp:Label ID="lblCompletedBookings" runat="server" Text="0"></asp:Label>
                        </div>
                        <span class="text-muted small">Checked-Out / Closed</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-purple">
                        <i class="bi bi-door-closed-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Total Revenue -->
        <div class="col-sm-6 col-xl">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Revenue</span>
                        <div class="kpi-value mt-1 text-dark">
                            <asp:Label ID="lblTotalRevenue" runat="server" Text="₹ 0"></asp:Label>
                        </div>
                        <span class="text-muted small">Secured Ledger Gross</span>
                    </div>
                    <div class="kpi-icon-wrap" style="background: #ecfdf5; color: #047857; border: 1px solid #a7f3d0;">
                        <i class="bi bi-currency-rupee"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Master Bookings Card matching ManageHotel design -->
    <div class="manage-hotel-card">

        <!-- Header: Royal Brown / Gold Gradient Bar -->
        <div class="manage-hotel-header">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-journal-check text-warning fs-5"></i>
                <h4 class="mb-0">Live Guest Stays &amp; Reservations Ledger</h4>
            </div>
            <div>
                <span class="header-count-pill">
                    <i class="bi bi-shield-check me-1"></i>
                    <asp:Label ID="lblRecordCount" runat="server" Text="0 Reservation(s) Found"></asp:Label>
                </span>
            </div>
        </div>

        <!-- Filter & Search Toolbar matching ManageHotel -->
        <div class="manage-hotel-toolbar">
            <div class="row align-items-center g-3">
                <div class="col-12 col-md-5">
                    <div class="search-wrap-luxury">
                        <i class="bi bi-search search-icon-luxury"></i>
                        <asp:TextBox ID="txtBookingSearch" runat="server" CssClass="form-control form-control-luxury-search w-100" placeholder="Search by Guest Name, Email, Phone, Reference #, Suite..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-12 col-md-3">
                    <asp:DropDownList ID="ddlBookingStatus" runat="server" CssClass="form-select form-control-luxury-search" style="padding-left: 14px;">
                        <asp:ListItem Value="" Text="All Statuses"></asp:ListItem>
                        <asp:ListItem Value="Confirmed" Text="Confirmed"></asp:ListItem>
                        <asp:ListItem Value="Checked-In" Text="Checked-In (In-House)"></asp:ListItem>
                        <asp:ListItem Value="Completed" Text="Completed"></asp:ListItem>
                        <asp:ListItem Value="Cancelled" Text="Cancelled"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-12 col-md-4 d-flex align-items-center gap-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Filter Bookings" CssClass="btn-hotel-add-room" style="padding: 9px 20px; font-size: 0.85rem;" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="filter-pill-btn" style="padding: 9px 18px; font-size: 0.85rem;" OnClick="btnReset_Click" />
                </div>
            </div>
        </div>

        <!-- Active Bookings & Stays Table with explicit gridlines matching hotel-rooms-table -->
        <div class="table-responsive">
            <table class="table table-bordered table-hover hotel-rooms-table align-middle mb-0" id="bookingsTable">
                <thead>
                    <tr>
                        <th class="ps-4">Reference #</th>
                        <th>Guest Details</th>
                        <th>Room Reserved</th>
                        <th class="text-center">Stay Schedule</th>
                        <th class="text-center">Total Folio</th>
                        <th class="text-center">Status</th>
                        <th class="text-end pe-4" style="min-width: 170px;">Stay Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptBookings" runat="server" OnItemCommand="rptBookings_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td class="ps-4">
                                    <span class="fw-bold text-dark font-monospace"><%# Eval("BookingReference") %></span>
                                    <div class="text-muted" style="font-size: 0.72rem;"><%# string.Format("{0:dd MMM yyyy}", Eval("BookingDate")) %></div>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark"><%# Eval("GuestName") %></div>
                                    <div class="text-muted small"><%# Eval("GuestEmail") %> &bull; <%# Eval("GuestPhone") %></div>
                                </td>
                                <td>
                                    <span class="fw-semibold text-dark"><%# Eval("RoomName") %></span>
                                    <div class="text-muted small">Suite #<%# Eval("RoomId") %> &bull; <%# Eval("Adults") %> Adult(s)</div>
                                </td>
                                <td class="text-center">
                                    <div class="small fw-semibold text-dark">
                                        <%# string.Format("{0:dd MMM}", Eval("CheckInDate")) %> &rarr; <%# string.Format("{0:dd MMM yyyy}", Eval("CheckOutDate")) %>
                                    </div>
                                    <div class="text-muted" style="font-size: 0.72rem;">
                                        <%# Eval("NightsCount") %> Night(s) Stay
                                    </div>
                                </td>
                                <td class="text-center">
                                    <span class="fw-bold text-dark">&#8377; <%# string.Format("{0:N0}", Eval("TotalAmount")) %></span>
                                    <div><span class="badge bg-success-subtle text-success border px-2 py-0.5 small" style="font-size: 0.65rem;">SECURED</span></div>
                                </td>
                                <td class="text-center">
                                    <%# GetStatusBadgeHtml(Eval("BookingStatus")) %>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex gap-1 align-items-center">
                                        <!-- Check-In Button (For Confirmed / Pending) -->
                                        <%# (Eval("BookingStatus").ToString() == "Confirmed" || Eval("BookingStatus").ToString() == "Pending") 
                                            ? "<a href='Bookings.aspx?action=checkin&id=" + Eval("BookingId") + "' class='btn btn-sm btn-primary px-3 rounded-pill fw-bold btn-lifecycle-action' title='Actual Check-In: Check-in guest & set room to Occupied'><i class='bi bi-box-arrow-in-right me-1'></i> Actual Check-In</a>" 
                                            : "" %>

                                        <!-- Check-Out Button (For Checked-In) -->
                                        <%# (Eval("BookingStatus").ToString() == "Checked-In") 
                                            ? "<a href='Bookings.aspx?action=checkout&id=" + Eval("BookingId") + "' class='btn btn-sm text-white px-3 rounded-pill fw-bold btn-lifecycle-action' style='background: #6b21a8;' title='Check-out guest & send room to Cleaning'><i class='bi bi-box-arrow-right me-1'></i> Check-Out</a>" 
                                            : "" %>

                                        <!-- Cancel Button (For Confirmed / Pending) -->
                                        <%# (Eval("BookingStatus").ToString() == "Confirmed" || Eval("BookingStatus").ToString() == "Pending") 
                                            ? "<a href='Bookings.aspx?action=cancel&id=" + Eval("BookingId") + "' class='btn btn-sm btn-outline-danger px-2 rounded-pill' onclick=\"return confirm('Are you sure you want to cancel this reservation?');\" title='Cancel reservation'><i class='bi bi-x-lg'></i></a>" 
                                            : "" %>

                                        <!-- Completed Badge -->
                                        <%# Eval("BookingStatus").ToString() == "Completed" ? "<span class=\"text-muted small fw-semibold\"><i class=\"bi bi-check-circle-fill text-success me-1\"></i> Stay Finished</span>" : "" %>

                                        <!-- Cancelled Badge -->
                                        <%# Eval("BookingStatus").ToString() == "Cancelled" ? "<span class=\"text-muted small\"><i class=\"bi bi-x-circle text-danger me-1\"></i> Cancelled</span>" : "" %>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <!-- Empty State when no records exist -->
            <asp:Panel ID="pnlNoBookings" runat="server" Visible="false">
                <div class="text-center text-muted py-5">
                    <i class="bi bi-calendar3 fs-1 opacity-50 d-block mb-2 text-warning"></i>
                    <h6 class="fw-bold text-dark mb-1">No Reservations Found</h6>
                    <p class="small text-muted mb-0">No booking records match the specified search or filter criteria.</p>
                </div>
            </asp:Panel>
        </div>

        <!-- Card Bottom Bar matching ManageHotel & Availability -->
        <div class="p-3 bg-light border-top d-flex justify-content-between align-items-center small text-muted">
            <span>Guest Stay Lifecycle Ledger &bull; Real-time SQL Server sync</span>
            <a href="Availability.aspx" class="text-decoration-none fw-semibold" style="color: var(--hotel-brown);">View Room Availability &rarr;</a>
        </div>
    </div>
</asp:Content>
