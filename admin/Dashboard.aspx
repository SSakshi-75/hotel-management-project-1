<%@ Page Title="Admin Dashboard | Hotel Management" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management System Executive Real-time Dashboard">
        <style>
            /* Modern, luxury, subtle shadow design */
            .dash-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 25px;
            }

            .dash-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.8rem;
                font-weight: 700;
                color: #5a2e15;
                margin-bottom: 4px;
            }

            .dash-subtitle {
                font-size: 0.95rem;
                color: #6c757d;
            }

            .date-badge {
                display: flex;
                align-items: center;
                gap: 12px;
                background: #fff;
                border: 1px solid #eaeaea;
                border-radius: 8px;
                padding: 10px 16px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.02);
            }

            .date-badge i {
                font-size: 1.2rem;
                color: #5a2e15;
            }

            .date-badge-text {
                display: flex;
                flex-direction: column;
            }

            .date-badge-text small {
                font-size: 0.75rem;
                color: #6c757d;
                line-height: 1;
            }

            .date-badge-text strong {
                font-size: 0.85rem;
                color: #333;
                line-height: 1.4;
                font-weight: 600;
            }

            .kpi-box {
                background: #fff;
                border: 1px solid #eaeaea;
                border-radius: 12px;
                padding: 16px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
                height: 100%;
                position: relative;
                display: flex;
                flex-direction: column;
            }

            .kpi-icon {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.1rem;
                margin-bottom: 12px;
            }

            /* KPI colors from screenshot */
            .kpi-green {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .kpi-blue {
                background: #e3f2fd;
                color: #1565c0;
            }

            .kpi-purple {
                background: #f3e5f5;
                color: #7b1fa2;
            }

            .kpi-teal {
                background: #e0f2f1;
                color: #00695c;
            }

            .kpi-orange {
                background: #fff3e0;
                color: #ef6c00;
            }

            .kpi-red {
                background: #ffebee;
                color: #c62828;
            }

            .kpi-title {
                font-size: 0.85rem;
                font-weight: 600;
                color: #495057;
                margin-bottom: 4px;
            }

            .kpi-value {
                font-size: 1.6rem;
                font-weight: 700;
                color: #212529;
                margin-bottom: 6px;
            }

            .kpi-desc {
                font-size: 0.75rem;
                color: #6c757d;
                display: flex;
                align-items: center;
                gap: 4px;
                margin-top: auto;
            }

            .kpi-trend {
                font-size: 0.75rem;
                font-weight: 600;
            }

            .kpi-trend.up {
                color: #2e7d32;
            }

            .kpi-trend.down {
                color: #c62828;
            }

            /* Charts & Containers */
            .dash-card {
                background: #fff;
                border: 1px solid #eaeaea;
                border-radius: 12px;
                padding: 20px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
                height: 100%;
            }

            .dash-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 16px;
            }

            .dash-card-title {
                font-size: 1rem;
                font-weight: 700;
                color: #212529;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* Tables */
            .dash-table {
                width: 100%;
                font-size: 0.85rem;
            }

            .dash-table th {
                font-weight: 600;
                color: #6c757d;
                padding: 12px 8px;
                border-bottom: 1px solid #eaeaea;
            }

            .dash-table td {
                padding: 12px 8px;
                border-bottom: 1px solid #f8f9fa;
                color: #212529;
                vertical-align: middle;
            }

            .dash-table tr:last-child td {
                border-bottom: none;
            }

            .status-badge {
                padding: 4px 10px;
                border-radius: 4px;
                font-size: 0.7rem;
                font-weight: 600;
                display: inline-block;
            }

            .status-confirmed {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .status-pending {
                background: #fff3e0;
                color: #ef6c00;
            }

            .status-checkedin {
                background: #e3f2fd;
                color: #1565c0;
            }

            .status-checkedout {
                background: #f3f4f6;
                color: #4b5563;
            }

            .status-cancelled {
                background: #ffebee;
                color: #c62828;
            }

            .action-btn {
                padding: 4px 14px;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                text-align: center;
            }

            .btn-checkin {
                background: #5a2e15;
                color: #fff;
            }

            .btn-checkin:hover {
                background: #44200d;
                color: #fff;
            }

            .btn-checkout {
                background: #8d6e63;
                color: #fff;
            }

            .btn-checkout:hover {
                background: #6d534a;
                color: #fff;
            }

            .btn-view {
                border: 1px solid #dee2e6;
                color: #495057;
                background: #fff;
            }

            .btn-view:hover {
                background: #f8f9fa;
                color: #212529;
            }

            /* Quick Actions */
            .qa-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }

            .qa-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 16px;
                border-radius: 12px;
                text-decoration: none;
                gap: 8px;
                font-weight: 600;
                font-size: 0.8rem;
                transition: transform 0.2s;
                text-align: center;
            }

            .qa-item:hover {
                transform: translateY(-2px);
            }

            .qa-1 {
                background: #fff3e0;
                color: #ef6c00;
            }

            .qa-2 {
                background: #e3f2fd;
                color: #1565c0;
            }

            .qa-3 {
                background: #e8f5e9;
                color: #2e7d32;
            }

            .qa-4 {
                background: #f3e5f5;
                color: #7b1fa2;
            }

            .qa-5 {
                background: #ffebee;
                color: #c62828;
            }

            .qa-6 {
                background: #f8f9fa;
                color: #495057;
            }

            /* Activity Strip */
            .activity-strip {
                display: flex;
                gap: 30px;
                overflow-x: auto;
                padding-bottom: 8px;
                scrollbar-width: thin;
            }

            .activity-item {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                min-width: 220px;
            }

            .activity-icon {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
                flex-shrink: 0;
            }

            .activity-details h6 {
                font-size: 0.85rem;
                font-weight: 600;
                margin: 0 0 2px 0;
                color: #212529;
            }

            .activity-details p {
                font-size: 0.75rem;
                color: #6c757d;
                margin: 0 0 4px 0;
            }

            .activity-details small {
                font-size: 0.7rem;
                color: #adb5bd;
                display: block;
            }

            /* Dining Card */
            .dining-img {
                width: 100%;
                height: 90px;
                object-fit: cover;
                border-radius: 8px;
                margin-right: 12px;
            }

            .dining-stats {
                display: flex;
                justify-content: space-between;
                background: #f8f9fa;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 12px;
            }

            .dining-stat {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 0.75rem;
                font-weight: 600;
            }

            .stat-indicator {
                width: 8px;
                height: 8px;
                border-radius: 50%;
            }

            a.view-all-link {
                font-size: 0.8rem;
                color: #6c757d;
                font-weight: 600;
                text-decoration: none;
            }

            a.view-all-link:hover {
                color: #5a2e15;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <div class="dash-header">
            <div>
                <h2 class="dash-title">Good Morning, Admin!</h2>
                <p class="dash-subtitle mb-0">Here's what's happening at your hotel today.</p>
            </div>
            <div class="date-badge">
                <i class="bi bi-calendar3"></i>
                <div class="date-badge-text">
                    <small>Today</small>
                    <strong>05 Oct 2026, Monday</strong>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hfChartTotalBookings" runat="server" Value="[0,0,0,0,0,0,0]" />
        <asp:HiddenField ID="hfChartConfirmedBookings" runat="server" Value="[0,0,0,0,0,0,0]" />
        <asp:HiddenField ID="hfChartLabels" runat="server" Value="['','','','','','','']" />
        <asp:HiddenField ID="hfDonutData" runat="server" Value="[0,0,0,0,0]" />
        <asp:HiddenField ID="hfDonutTotal" runat="server" Value="0" />

        <!-- ROW 1: KPIs -->
        <div class="row g-3 mb-4">
            <!-- Revenue -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-green"><i class="bi bi-currency-rupee"></i></div>
                    <div class="kpi-title">Today's Revenue</div>
                    <div class="kpi-value">&#8377;<asp:Literal ID="lblTodayRevenue" runat="server" Text="0">
                        </asp:Literal>
                    </div>
                    <div class="kpi-desc">
                        <span class="text-muted">Today's Transactions</span>
                    </div>
                </div>
            </div>
            <!-- Bookings -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-blue"><i class="bi bi-calendar2-check"></i></div>
                    <div class="kpi-title">Today's Bookings</div>
                    <div class="kpi-value">
                        <asp:Literal ID="lblTodayBookingsTotal" runat="server" Text="0"></asp:Literal>
                    </div>
                    <div class="kpi-desc">
                        <asp:Literal ID="lblTodayBookingsConfirmed" runat="server" Text="0"></asp:Literal> Confirmed |
                        <asp:Literal ID="lblTodayBookingsPending" runat="server" Text="0"></asp:Literal> Pending
                    </div>
                </div>
            </div>
            <!-- Occupancy Rate -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-purple"><i class="bi bi-percent"></i></div>
                    <div class="kpi-title">Occupancy Rate</div>
                    <div class="kpi-value d-flex justify-content-between align-items-center">
                        <asp:Literal ID="lblOccupancyRate" runat="server" Text="0"></asp:Literal>%
                        <i class="bi bi-pie-chart-fill text-muted fs-5 opacity-50"></i>
                    </div>
                    <div class="kpi-desc">
                        <asp:Literal ID="lblOccupiedRooms" runat="server" Text="0"></asp:Literal> / <asp:Literal
                            ID="lblTotalRooms" runat="server" Text="0"></asp:Literal> Rooms
                    </div>
                </div>
            </div>
            <!-- Available Rooms -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-teal"><i class="bi bi-door-open"></i></div>
                    <div class="kpi-title">Available Rooms</div>
                    <div class="kpi-value">
                        <asp:Literal ID="lblAvailableRooms" runat="server" Text="0"></asp:Literal>
                    </div>
                    <div class="kpi-desc"><span class="text-success fw-semibold">Ready</span> to sell</div>
                </div>
            </div>
            <!-- Check-ins -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-orange"><i class="bi bi-person-down"></i></div>
                    <div class="kpi-title">Check-ins Today</div>
                    <div class="kpi-value">
                        <asp:Literal ID="lblCheckinsToday" runat="server" Text="0"></asp:Literal>
                    </div>
                    <div class="kpi-desc"><span class="text-warning fw-semibold">
                            <asp:Literal ID="lblCheckinsPending" runat="server" Text="0"></asp:Literal> Pending
                        </span></div>
                </div>
            </div>
            <!-- Check-outs -->
            <div class="col-12 col-sm-6 col-md-4 col-lg-2">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-red"><i class="bi bi-box-arrow-right"></i></div>
                    <div class="kpi-title">Check-outs Today</div>
                    <div class="kpi-value">
                        <asp:Literal ID="lblCheckoutsToday" runat="server" Text="0"></asp:Literal>
                    </div>
                    <div class="kpi-desc"><span class="text-danger fw-semibold">
                            <asp:Literal ID="lblCheckoutsPending" runat="server" Text="0"></asp:Literal> Pending
                        </span></div>
                </div>
            </div>
        </div>

        <!-- ROW 2: CHARTS -->
        <div class="row g-3 mb-4">
            <!-- Booking Overview -->
            <div class="col-12 col-lg-8">
                <div class="dash-card">
                    <div class="dash-card-header mb-1">
                        <div>
                            <h5 class="dash-card-title">Booking Overview</h5>
                            <div class="dash-subtitle mt-1">Last 7 Days</div>
                        </div>
                        <select class="form-select form-select-sm w-auto border-0 bg-light fw-semibold text-muted">
                            <option>This Week</option>
                        </select>
                    </div>
                    <!-- Legend -->
                    <div class="d-flex justify-content-center gap-4 mb-3">
                        <span class="small fw-semibold text-muted"><i class="bi bi-circle-fill text-primary"
                                style="font-size:8px; vertical-align:middle; margin-right:4px;"></i> Total
                            Bookings</span>
                        <span class="small fw-semibold text-muted"><i class="bi bi-circle-fill text-success"
                                style="font-size:8px; vertical-align:middle; margin-right:4px;"></i> Confirmed</span>
                    </div>
                    <div class="chart-container" style="position: relative; height:200px;">
                        <canvas id="bookingsOverviewChart"></canvas>
                    </div>
                </div>
            </div>
            <!-- Room Status -->
            <div class="col-12 col-lg-4">
                <div class="dash-card">
                    <h5 class="dash-card-title mb-4">Room Status</h5>
                    <div class="d-flex align-items-center justify-content-between h-100 pb-4">
                        <div style="position: relative; width: 140px; height: 140px;">
                            <canvas id="roomStatusDonutChart"></canvas>
                            <div
                                style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                                <div style="font-size:1.5rem; font-weight:700; color:#212529;">
                                    <asp:Literal ID="lblChartDonutCenter" runat="server" Text="0"></asp:Literal>
                                </div>
                                <div style="font-size:0.7rem; color:#6c757d;">Total Rooms</div>
                            </div>
                        </div>
                        <div class="d-flex flex-column gap-2" style="width: 120px;">
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted fw-semibold"><i class="bi bi-circle-fill text-success me-2"
                                        style="font-size:8px;"></i>Available</span><span class="fw-bold">
                                    <asp:Literal ID="lblRoomAvailable" runat="server" Text="0"></asp:Literal>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted fw-semibold"><i class="bi bi-circle-fill text-primary me-2"
                                        style="font-size:8px;"></i>Occupied</span><span class="fw-bold">
                                    <asp:Literal ID="lblRoomOccupied" runat="server" Text="0"></asp:Literal>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted fw-semibold"><i class="bi bi-circle-fill text-warning me-2"
                                        style="font-size:8px;"></i>Cleaning</span><span class="fw-bold">
                                    <asp:Literal ID="lblRoomCleaning" runat="server" Text="0"></asp:Literal>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted fw-semibold"><i class="bi bi-circle-fill text-danger me-2"
                                        style="font-size:8px;"></i>Maintenance</span><span class="fw-bold">
                                    <asp:Literal ID="lblRoomMaintenance" runat="server" Text="0"></asp:Literal>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center small">
                                <span class="text-muted fw-semibold"><i class="bi bi-circle-fill text-secondary me-2"
                                        style="font-size:8px;"></i>Blocked</span><span class="fw-bold">
                                    <asp:Literal ID="lblRoomBlocked" runat="server" Text="0"></asp:Literal>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ROW 3: TODAY'S ARRIVALS & DEPARTURES -->
        <div class="row g-3 mb-4">
            <!-- Arrivals -->
            <div class="col-12 col-lg-6">
                <div class="dash-card">
                    <div class="dash-card-header">
                        <h5 class="dash-card-title"><i class="bi bi-calendar2-plus text-warning fs-5"></i> Today's
                            Arrivals</h5>
                        <a href="javascript:void(0)" class="view-all-link">View All <i
                                class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive">
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>Booking #</th>
                                    <th>Guest Name</th>
                                    <th>Room</th>
                                    <th>Check-in</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptArrivals" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%# Eval("BookingReference") %>
                                            </td>
                                            <td><span class="fw-semibold">
                                                    <%# Eval("GuestName") %>
                                                </span></td>
                                            <td>
                                                <%# Eval("RoomNo") %>
                                            </td>
                                            <td>
                                                <%# Convert.ToDateTime(Eval("CheckInDate")).ToString("hh:mm tt") %>
                                            </td>
                                            <td><span
                                                    class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td><a href="Bookings.aspx" class="action-btn btn-checkin">Check-In</a></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptArrivals.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-3">No arrivals today</td>
                                    </tr>
                                    <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Departures -->
            <div class="col-12 col-lg-6">
                <div class="dash-card">
                    <div class="dash-card-header">
                        <h5 class="dash-card-title"><i class="bi bi-box-arrow-right text-warning fs-5"></i> Today's
                            Departures</h5>
                        <a href="javascript:void(0)" class="view-all-link">View All <i
                                class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive">
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>Guest Name</th>
                                    <th>Room</th>
                                    <th>Check-out</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptDepartures" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><span class="fw-semibold">
                                                    <%# Eval("GuestName") %>
                                                </span></td>
                                            <td>
                                                <%# Eval("RoomNo") %>
                                            </td>
                                            <td>
                                                <%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("hh:mm tt") %>
                                            </td>
                                            <td><span
                                                    class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td><a href="Bookings.aspx" class="action-btn btn-checkout">Check-Out</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptDepartures.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-3">No departures today</td>
                                    </tr>
                                    <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- ROW 4: RECENT, DINING, QUICK ACTIONS -->
        <div class="row g-3 mb-4">
            <!-- Recent Bookings -->
            <div class="col-12 col-lg-5">
                <div class="dash-card">
                    <div class="dash-card-header">
                        <h5 class="dash-card-title"><i class="bi bi-calendar2-range text-warning fs-5"></i> Recent
                            Bookings</h5>
                        <a href="javascript:void(0)" class="view-all-link">View All <i
                                class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive">
                        <table class="dash-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Guest Name</th>
                                    <th>Room</th>
                                    <th>Check-in</th>
                                    <th>Check-out</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptRecentBookings" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <%# Eval("BookingReference") %>
                                            </td>
                                            <td><span class="fw-semibold">
                                                    <%# Eval("GuestName") %>
                                                </span></td>
                                            <td>
                                                <%# Eval("RoomNo") %>
                                            </td>
                                            <td>
                                                <%# Convert.ToDateTime(Eval("CheckInDate")).ToString("dd MMM yyyy") %>
                                            </td>
                                            <td>
                                                <%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("dd MMM yyyy") %>
                                            </td>
                                            <td><span
                                                    class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td><a href="Bookings.aspx" class="action-btn btn-view">View</a></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptRecentBookings.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-3 d-block mb-2 opacity-50"></i>
                                            <div class="small fw-semibold text-dark mb-1">No Recent Bookings</div>
                                        </td>
                                    </tr>
                                    <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Restaurant / Dining Today -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="dash-card d-flex flex-column">
                    <div class="dash-card-header">
                        <h5 class="dash-card-title"><i class="bi bi-shop-window text-warning fs-5"></i> Restaurant /
                            Dining Today</h5>
                        <a href="javascript:void(0)" class="view-all-link">View All <i
                                class="bi bi-arrow-right"></i></a>
                    </div>

                    <div class="d-flex align-items-center mb-3">
                        <div style="flex:1;">
                            <h6 class="fw-bold mb-1">The Royal Kitchen <span
                                    class="badge bg-success-subtle text-success rounded-pill fw-semibold border border-success-subtle ms-2"
                                    style="font-size:0.65rem;">Active</span></h6>
                            <p class="text-muted small mb-0">Indian | Continental | Chinese</p>
                        </div>
                    </div>

                    <h6 class="font-weight-bold" style="font-size: 0.85rem;">Table Status</h6>
                    <div class="dining-stats">
                        <div class="dining-stat">
                            <span class="stat-indicator bg-success"></span> Available <span
                                class="fw-bold fs-6 text-success ms-1">
                                <asp:Literal ID="lblTableAvailable" runat="server" Text="0"></asp:Literal>
                            </span>
                        </div>
                        <div class="dining-stat">
                            <span class="stat-indicator bg-danger"></span> Occupied <span
                                class="fw-bold fs-6 text-danger ms-1">
                                <asp:Literal ID="lblTableOccupied" runat="server" Text="0"></asp:Literal>
                            </span>
                        </div>
                        <div class="dining-stat">
                            <span class="stat-indicator bg-warning"></span> Reserved <span
                                class="fw-bold fs-6 text-warning ms-1">
                                <asp:Literal ID="lblTableReserved" runat="server" Text="0"></asp:Literal>
                            </span>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <span class="small fw-semibold text-muted">Today's Table Reservations</span>
                        <span class="fw-bold fs-5 text-dark">
                            <asp:Literal ID="lblTodayTableRes" runat="server" Text="0"></asp:Literal>
                        </span>
                    </div>

                    <div class="d-flex gap-2 mt-auto">
                        <a href="#" class="btn flex-fill"
                            style="background:#5a2e15; color:#fff; font-size:0.85rem; font-weight:600;">Manage
                            Tables</a>
                        <a href="#" class="btn flex-fill"
                            style="border:1px solid #dee2e6; color:#495057; font-size:0.85rem; font-weight:600;">View
                            Reservations</a>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="col-12 col-md-6 col-lg-3">
                <div class="dash-card">
                    <h5 class="dash-card-title mb-4"><i class="bi bi-lightning-charge text-warning fs-5"></i> Quick
                        Actions</h5>
                    <div class="qa-grid">
                        <a href="#" class="qa-item qa-1">
                            <i class="bi bi-calendar-plus fs-4"></i>
                            + New Booking
                        </a>
                        <a href="AddRoom.aspx" class="qa-item qa-2">
                            <i class="bi bi-door-open fs-4"></i>
                            + Add Room
                        </a>
                        <a href="#" class="qa-item qa-3">
                            <i class="bi bi-box-arrow-in-right fs-4"></i>
                            Check-In
                        </a>
                        <a href="#" class="qa-item qa-4">
                            <i class="bi bi-box-arrow-right fs-4"></i>
                            + Check-Out
                        </a>
                        <a href="#" class="qa-item qa-5">
                            <i class="bi bi-cup-hot fs-4"></i>
                            Manage Tables
                        </a>
                        <a href="#" class="qa-item qa-6">
                            <i class="bi bi-bar-chart-line fs-4"></i>
                            Reports
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ROW 5: LATEST ACTIVITY STRIP -->
        <div class="dash-card">
            <div class="dash-card-header mb-2">
                <h5 class="dash-card-title"><i class="bi bi-clock-history text-muted fs-5"></i> Latest Activity</h5>
                <a href="javascript:void(0)" class="view-all-link">View All <i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="activity-strip">
                <asp:Repeater ID="rptActivity" runat="server">
                    <ItemTemplate>
                        <div class="activity-item border-end pe-4">
                            <div
                                class='activity-icon <%# Eval("ActivityType").ToString() == "Booking" ? "kpi-blue" : "kpi-green" %>'>
                                <i
                                    class='bi <%# Eval("ActivityType").ToString() == "Booking" ? "bi-calendar-check" : "bi-person-add" %>'></i>
                            </div>
                            <div class="activity-details">
                                <h6>
                                    <%# Eval("Detail") %>
                                </h6>
                                <p>
                                    <%# Eval("SubDetail") %>
                                </p>
                                <small>
                                    <%# Eval("TimeStr") %>
                                </small>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <% if (rptActivity.Items.Count==0) { %>
                    <div class="text-center w-100 py-3 text-muted">
                        <i class="bi bi-clock-history fs-4 d-block mb-1 opacity-50"></i>
                        <small>No recent activity</small>
                    </div>
                    <% } %>
            </div>
        </div>

        <!-- Scripts for Chart.js Dummy Data -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {

                // Read hidden fields
                const hfLabels = document.getElementById('<%= hfChartLabels.ClientID %>').value;
                const hfTotals = document.getElementById('<%= hfChartTotalBookings.ClientID %>').value;
                const hfConfirmed = document.getElementById('<%= hfChartConfirmedBookings.ClientID %>').value;
                const hfDonutTotal = document.getElementById('<%= hfDonutTotal.ClientID %>').value;
                const hfDonutData = document.getElementById('<%= hfDonutData.ClientID %>').value;

                let arrLabels = ['Sep 29', 'Sep 30', 'Oct 1', 'Oct 2', 'Oct 3', 'Oct 4', 'Oct 5'];
                let arrTotals = [0, 0, 0, 0, 0, 0, 0];
                let arrConfirmed = [0, 0, 0, 0, 0, 0, 0];
                let donutData = [0, 0, 0, 0, 0];

                try {
                    arrLabels = JSON.parse(hfLabels.replace(/'/g, '"'));
                    arrTotals = JSON.parse(hfTotals);
                    arrConfirmed = JSON.parse(hfConfirmed);
                    donutData = JSON.parse(hfDonutData);
                    document.getElementById('<%= lblChartDonutCenter.ClientID %>').innerText = hfDonutTotal;
                } catch (e) { console.error(e); }

                // Bookings Overview Area Chart
                const ctx1 = document.getElementById('bookingsOverviewChart').getContext('2d');
                new Chart(ctx1, {
                    type: 'line',
                    data: {
                        labels: arrLabels,
                        datasets: [
                            {
                                label: 'Total Bookings',
                                data: arrTotals,
                                borderColor: '#3b82f6', // blue
                                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                borderWidth: 2,
                                tension: 0.4,
                                fill: true,
                                pointBackgroundColor: '#3b82f6'
                            },
                            {
                                label: 'Confirmed',
                                data: arrConfirmed,
                                borderColor: '#10b981', // green
                                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                                borderWidth: 2,
                                tension: 0.4,
                                fill: true,
                                pointBackgroundColor: '#10b981'
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: { beginAtZero: true, max: 20, grid: { borderDash: [4, 4], color: '#f3f4f6' } },
                            x: { grid: { display: false } }
                        }
                    }
                });

                // Room Status Donut Chart
                const ctx2 = document.getElementById('roomStatusDonutChart').getContext('2d');
                new Chart(ctx2, {
                    type: 'doughnut',
                    data: {
                        labels: ['Available', 'Occupied', 'Cleaning', 'Maintenance', 'Blocked'],
                        datasets: [{
                            data: donutData,
                            backgroundColor: ['#10b981', '#3b82f6', '#f59e0b', '#ef4444', '#6b7280'],
                            borderWidth: 0,
                            hoverOffset: 4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '75%',
                        plugins: { legend: { display: false }, tooltip: { enabled: true } }
                    }
                });
            });
        </script>
    </asp:Content>