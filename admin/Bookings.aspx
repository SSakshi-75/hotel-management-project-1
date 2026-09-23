<%@ Page Title="Reservations & Guest Stay Lifecycle | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Bookings.aspx.cs" Inherits="Admin_Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Reservations & Guest Stay Lifecycle Management">
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
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 16px 20px;
            transition: all 0.25s ease;
        }

        .lifecycle-step-card:hover {
            border-color: #B88E68;
            box-shadow: 0 4px 15px rgba(184, 142, 104, 0.12);
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

        .booking-kpi-card {
            background: #ffffff;
            border: 1px solid #eef0f3;
            border-radius: 14px;
            padding: 18px;
            transition: all 0.2s ease;
        }
        .booking-kpi-card:hover {
            box-shadow: 0 6px 20px rgba(0,0,0,0.05);
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

    <!-- Page Header & Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Reservations &amp; Guest Stay Lifecycle</h2>
            <p class="text-muted small mb-0">Live reservation ledger connected directly to SQL Server. Manage check-in, check-out, and auto-sync room availability.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="Availability.aspx" class="btn btn-outline-dark btn-sm rounded-pill px-3">
                <i class="bi bi-calendar3 me-1"></i> Room Availability
            </a>
            <a href="../BookNow.aspx" target="_blank" class="btn btn-dark btn-sm rounded-pill px-3">
                <i class="bi bi-box-arrow-up-right me-1"></i> Customer Booking Portal
            </a>
        </div>
    </div>

    <!-- Interactive Guest Stay Lifecycle Progress Map -->
    <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
        <h6 class="fw-bold text-dark mb-3 d-flex align-items-center gap-2" style="font-size: 0.95rem;">
            <i class="bi bi-diagram-3-fill text-gold"></i> End-to-End Guest Booking &amp; Stay Lifecycle Flow
        </h6>

        <div class="row g-2 align-items-center text-center">
            <!-- Step 1 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">1</div>
                    <div class="fw-bold text-dark small">Search Dates</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Customer Portal</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 2 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">2</div>
                    <div class="fw-bold text-dark small">Select Suite</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Capacity &amp; Rate</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 3 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">3</div>
                    <div class="fw-bold text-dark small">Reservation</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Double-Check Lock</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 4 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2 border-primary" style="background: #f0f7ff;">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-primary">4</div>
                    <div class="fw-bold text-primary small">Check-In</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Occupied</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 5 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2 border-purple" style="background: #faf5ff;">
                    <div class="lifecycle-step-number mx-auto mb-1" style="background: #6b21a8;">5</div>
                    <div class="fw-bold text-purple small" style="color: #6b21a8;">Check-Out</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Cleaning</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 6 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2 border-success" style="background: #f0fdf4;">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-success">6</div>
                    <div class="fw-bold text-success small">Completed</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &rarr; Available</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Booking Ledger KPI Row -->
    <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl">
            <div class="booking-kpi-card">
                <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Total Reservations</span>
                <h4 class="fw-bold text-dark mb-0">
                    <asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label>
                </h4>
            </div>
        </div>
        <div class="col-sm-6 col-xl">
            <div class="booking-kpi-card">
                <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Confirmed (Upcoming)</span>
                <h4 class="fw-bold text-success mb-0">
                    <asp:Label ID="lblConfirmedBookings" runat="server" Text="0"></asp:Label>
                </h4>
            </div>
        </div>
        <div class="col-sm-6 col-xl">
            <div class="booking-kpi-card">
                <span class="text-muted small text-uppercase fw-semibold d-block mb-1">In-House Guests</span>
                <h4 class="fw-bold text-primary mb-0">
                    <asp:Label ID="lblInHouseGuests" runat="server" Text="0"></asp:Label>
                </h4>
            </div>
        </div>
        <div class="col-sm-6 col-xl">
            <div class="booking-kpi-card">
                <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Completed Stays</span>
                <h4 class="fw-bold text-purple mb-0" style="color: #6b21a8;">
                    <asp:Label ID="lblCompletedBookings" runat="server" Text="0"></asp:Label>
                </h4>
            </div>
        </div>
        <div class="col-sm-6 col-xl">
            <div class="booking-kpi-card">
                <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Total Revenue</span>
                <h4 class="fw-bold text-dark mb-0">
                    <asp:Label ID="lblTotalRevenue" runat="server" Text="₹ 0"></asp:Label>
                </h4>
            </div>
        </div>
    </div>

    <!-- Filter & Search Controls -->
    <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-white border-end-0 text-muted"><i class="bi bi-search"></i></span>
                    <asp:TextBox ID="txtBookingSearch" runat="server" CssClass="form-control border-start-0" placeholder="Search by Guest Name, Email, Phone, Reference #, Suite..."></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3">
                <asp:DropDownList ID="ddlBookingStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="" Text="All Statuses"></asp:ListItem>
                    <asp:ListItem Value="Confirmed" Text="Confirmed"></asp:ListItem>
                    <asp:ListItem Value="Checked-In" Text="Checked-In (In-House)"></asp:ListItem>
                    <asp:ListItem Value="Completed" Text="Completed"></asp:ListItem>
                    <asp:ListItem Value="Cancelled" Text="Cancelled"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-4 d-flex gap-2">
                <asp:Button ID="btnSearch" runat="server" Text="Filter Bookings" CssClass="btn btn-dark btn-sm px-3 fw-semibold" OnClick="btnSearch_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary btn-sm px-3" OnClick="btnReset_Click" />
                <span class="text-muted small ms-auto align-self-center">
                    <asp:Label ID="lblRecordCount" runat="server" Text=""></asp:Label>
                </span>
            </div>
        </div>
    </div>

    <!-- Active Bookings & Stays Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <h6 class="fw-bold text-dark mb-0">
                <i class="bi bi-journal-check me-2 text-gold"></i> Live Guest Stays &amp; Reservations Ledger
            </h6>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="bookingsTable">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Reference #</th>
                        <th>Guest Details</th>
                        <th>Room Reserved</th>
                        <th>Stay Schedule</th>
                        <th>Total Folio</th>
                        <th>Status</th>
                        <th class="text-end pe-4" style="min-width: 170px;">Stay Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
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
                                <td>
                                    <div class="small fw-semibold text-dark">
                                        <%# string.Format("{0:dd MMM}", Eval("CheckInDate")) %> &rarr; <%# string.Format("{0:dd MMM yyyy}", Eval("CheckOutDate")) %>
                                    </div>
                                    <div class="text-muted" style="font-size: 0.72rem;">
                                        <%# Eval("NightsCount") %> Night(s) Stay
                                    </div>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark">&#8377; <%# string.Format("{0:N0}", Eval("TotalAmount")) %></span>
                                    <div class="badge bg-success-subtle text-success border px-2 py-0.5 small" style="font-size: 0.65rem;">SECURED</div>
                                </td>
                                <td>
                                    <%# GetStatusBadgeHtml(Eval("BookingStatus")) %>
                                </td>
                                <td class="text-end pe-4">
                                    <div class="d-inline-flex gap-1 align-items-center">
                                        <!-- Check-In Button (For Confirmed / Pending) -->
                                        <asp:LinkButton ID="btnCheckIn" runat="server" 
                                            CommandName="CheckIn" 
                                            CommandArgument='<%# Eval("BookingId") %>'
                                            Visible='<%# Eval("BookingStatus").ToString() == "Confirmed" || Eval("BookingStatus").ToString() == "Pending" %>'
                                            CssClass="btn btn-sm btn-primary px-3 rounded-pill fw-bold"
                                            ToolTip="Check-in guest & set room to Occupied">
                                            <i class="bi bi-box-arrow-in-right me-1"></i> Check-In
                                        </asp:LinkButton>

                                        <!-- Check-Out Button (For Checked-In) -->
                                        <asp:LinkButton ID="btnCheckOut" runat="server" 
                                            CommandName="CheckOut" 
                                            CommandArgument='<%# Eval("BookingId") %>'
                                            Visible='<%# Eval("BookingStatus").ToString() == "Checked-In" %>'
                                            CssClass="btn btn-sm text-white px-3 rounded-pill fw-bold" 
                                            style="background: #6b21a8;"
                                            ToolTip="Check-out guest & send room to Cleaning">
                                            <i class="bi bi-box-arrow-right me-1"></i> Check-Out
                                        </asp:LinkButton>

                                        <!-- Cancel Button (For Confirmed / Pending) -->
                                        <asp:LinkButton ID="btnCancel" runat="server" 
                                            CommandName="CancelBooking" 
                                            CommandArgument='<%# Eval("BookingId") %>'
                                            Visible='<%# Eval("BookingStatus").ToString() == "Confirmed" || Eval("BookingStatus").ToString() == "Pending" %>'
                                            CssClass="btn btn-sm btn-outline-danger px-2 rounded-pill"
                                            OnClientClick="return confirm('Are you sure you want to cancel this reservation and free the dates?');"
                                            ToolTip="Cancel reservation">
                                            <i class="bi bi-x-lg"></i>
                                        </asp:LinkButton>

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
                    <i class="bi bi-calendar3 fs-1 opacity-50 d-block mb-2 text-gold"></i>
                    <h6 class="fw-bold text-dark mb-1">No Reservations Found</h6>
                    <p class="small text-muted mb-0">No booking records match the specified search or filter criteria.</p>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
