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
                padding: 16px 14px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.02);
                height: 100%;
            }

            .dash-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 14px;
            }

            .dash-card-title {
                font-size: 0.96rem;
                font-weight: 700;
                color: #212529;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* Tables */
            .table-responsive::-webkit-scrollbar {
                height: 4px;
            }
            .table-responsive::-webkit-scrollbar-thumb {
                background: #cbd5e1;
                border-radius: 4px;
            }

            .dash-table {
                width: 100%;
                font-size: 0.8rem;
            }

            .dash-table th {
                font-weight: 600;
                color: #6c757d;
                padding: 8px 6px;
                border-bottom: 1px solid #eaeaea;
            }

            .dash-table td {
                padding: 8px 6px;
                border-bottom: 1px solid #f8f9fa;
                color: #212529;
                vertical-align: middle;
            }

            .dash-table tr:last-child td {
                border-bottom: none;
            }

            .status-badge {
                padding: 2px 7px;
                border-radius: 4px;
                font-size: 0.67rem;
                font-weight: 600;
                display: inline-block;
                white-space: nowrap;
                line-height: 1.35;
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
                padding: 2px 8px;
                border-radius: 4px;
                font-size: 0.71rem;
                font-weight: 600;
                text-decoration: none;
                display: inline-block;
                text-align: center;
                white-space: nowrap;
                line-height: 1.35;
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

            /* Dashboard GridView Table Styles */
            .dash-gridview-table {
                width: 100%;
                margin-bottom: 0;
                border-collapse: collapse !important;
                border: 1.5px solid #d8dee6 !important;
                font-size: 0.77rem;
            }

            .dash-gridview-table th,
            .dash-gridview-table thead th {
                background: #f1f5f9 !important;
                color: #442305 !important;
                font-weight: 700;
                font-size: 0.69rem;
                text-transform: uppercase;
                letter-spacing: 0.02em;
                padding: 7px 5px !important;
                border: 1.5px solid #cbd5e1 !important;
                border-bottom: 2.5px solid #B88E68 !important;
                vertical-align: middle;
                white-space: nowrap;
            }

            .dash-gridview-table td,
            .dash-gridview-table tbody td {
                padding: 6px 5px !important;
                vertical-align: middle;
                border: 1.5px solid #e2e8f0 !important;
                color: #334155;
                font-size: 0.77rem;
                background: #ffffff;
                white-space: nowrap;
            }

            .dash-gridview-table tbody tr:nth-child(even) td {
                background: #fafbfd;
            }

            .dash-gridview-table tbody tr:hover td {
                background: #fdf6ee !important;
            }

            .dining-tab-btn {
                font-size: 0.76rem;
                font-weight: 600;
                padding: 4px 10px;
                border: 1px solid #cbd5e1;
                background: #ffffff;
                color: #475569;
                border-radius: 6px;
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .dining-tab-btn.active,
            .dining-tab-btn:hover {
                background: #442305;
                color: #ffffff;
                border-color: #442305;
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

            /* ==========================================
               RESPONSIVE LAYOUT & MOBILE ENHANCEMENTS
               (Desktop preserved 100% intact)
               ========================================== */

            /* Dining Header Desktop Defaults */
            .dining-card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .dining-header-title-row {
                display: flex;
                align-items: center;
            }
            .dining-header-actions {
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .dining-mobile-viewall {
                display: none;
            }
            .dining-desktop-viewall {
                display: inline-block;
            }

            /* Donut chart desktop defaults */
            .donut-status-wrapper {
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 100%;
                padding-bottom: 1.5rem;
            }
            .donut-legend-list {
                display: flex;
                flex-direction: column;
                gap: 8px;
                width: 120px;
            }

            /* Tablet & Below (<= 991.98px) */
            @media (max-width: 991.98px) {
                .dash-header {
                    margin-bottom: 20px;
                }
                .dash-title {
                    font-size: 1.55rem;
                }
                .dash-card {
                    padding: 14px 12px;
                }
            }

            /* Mobile Landscape & Below (<= 767.98px) */
            @media (max-width: 767.98px) {
                /* Header: stack title and date badge cleanly without squishing */
                .dash-header {
                    flex-direction: column;
                    align-items: stretch;
                    gap: 12px;
                    margin-bottom: 18px;
                }

                .dash-title {
                    font-size: 1.35rem;
                    line-height: 1.25;
                    margin-bottom: 3px;
                }

                .dash-subtitle {
                    font-size: 0.82rem;
                }

                .date-badge {
                    width: 100%;
                    justify-content: flex-start;
                    padding: 8px 12px;
                    gap: 10px;
                }

                .date-badge i {
                    font-size: 1.1rem;
                }

                .date-badge-text small {
                    font-size: 0.7rem;
                }

                .date-badge-text strong {
                    font-size: 0.8rem;
                }

                /* KPI Cards */
                .kpi-box {
                    padding: 12px 14px;
                    border-radius: 10px;
                }

                .kpi-icon {
                    width: 32px;
                    height: 32px;
                    font-size: 0.95rem;
                    margin-bottom: 8px;
                }

                .kpi-title {
                    font-size: 0.78rem;
                    margin-bottom: 2px;
                }

                .kpi-value {
                    font-size: 1.35rem;
                    margin-bottom: 4px;
                }

                .kpi-desc {
                    font-size: 0.72rem;
                }

                .kpi-value i.bi-pie-chart-fill {
                    font-size: 1.05rem !important;
                    flex-shrink: 0;
                    margin-left: 8px;
                }

                /* Cards & Headings */
                .dash-card {
                    padding: 13px 11px;
                    border-radius: 10px;
                }

                .dash-card-header {
                    margin-bottom: 10px;
                }

                .dash-card-title {
                    font-size: 0.9rem;
                    gap: 6px;
                }

                /* Tables & Horizontal Scroll */
                .table-responsive {
                    overflow-x: auto;
                    -webkit-overflow-scrolling: touch;
                    padding-bottom: 3px;
                }

                .dash-gridview-table {
                    min-width: 480px;
                    font-size: 0.74rem;
                }

                .dash-gridview-table th,
                .dash-gridview-table thead th {
                    padding: 6px 5px !important;
                    font-size: 0.66rem !important;
                }

                .dash-gridview-table td,
                .dash-gridview-table tbody td {
                    padding: 6px 5px !important;
                    font-size: 0.74rem !important;
                }

                .status-badge {
                    font-size: 0.65rem;
                    padding: 2px 6px;
                }

                .action-btn {
                    font-size: 0.68rem;
                    padding: 2px 6px;
                }

                /* Dining Card Header on Mobile */
                .dining-card-header {
                    flex-direction: column !important;
                    align-items: stretch !important;
                    gap: 10px !important;
                }

                .dining-header-title-row {
                    display: flex !important;
                    justify-content: space-between !important;
                    align-items: center !important;
                    width: 100% !important;
                }

                .dining-mobile-viewall {
                    display: inline-block !important;
                }

                .dining-desktop-viewall {
                    display: none !important;
                }

                .dining-header-actions {
                    width: 100% !important;
                }

                .dining-tab-group {
                    width: 100% !important;
                }

                .dining-tab-btn {
                    flex: 1 1 50% !important;
                    text-align: center !important;
                    padding: 6px 8px !important;
                    font-size: 0.73rem !important;
                }

                /* Quick Actions */
                .qa-item {
                    padding: 12px 6px !important;
                    font-size: 0.74rem !important;
                    gap: 6px !important;
                    border-radius: 10px;
                }

                .qa-item i {
                    font-size: 1.25rem !important;
                }

                /* Latest Activity */
                .activity-strip {
                    gap: 16px;
                    padding-bottom: 6px;
                    -webkit-overflow-scrolling: touch;
                }

                .activity-item {
                    min-width: 200px;
                    padding-right: 14px !important;
                    gap: 10px;
                }

                .activity-icon {
                    width: 32px;
                    height: 32px;
                    font-size: 0.85rem;
                }

                .activity-details h6 {
                    font-size: 0.8rem;
                }

                .activity-details p {
                    font-size: 0.72rem;
                }

                .activity-details small {
                    font-size: 0.68rem;
                }

                /* Footer action buttons */
                .dash-footer-action-btn {
                    padding: 8px 12px !important;
                    font-size: 0.8rem !important;
                }
            }

            /* Small Mobile Devices (<= 575.98px) */
            @media (max-width: 575.98px) {
                /* Reduce admin body padding slightly for more screen real estate */
                .admin-content-body {
                    padding: 10px 8px !important;
                }

                /* Donut Chart: Center donut, 2-column legend below */
                .donut-status-wrapper {
                    flex-direction: column !important;
                    justify-content: center !important;
                    align-items: center !important;
                    gap: 16px !important;
                    padding-bottom: 0.5rem !important;
                }

                .donut-legend-list {
                    width: 100% !important;
                    max-width: 280px !important;
                    display: grid !important;
                    grid-template-columns: repeat(2, 1fr) !important;
                    gap: 6px 14px !important;
                }

                /* Booking Chart Height */
                .chart-container {
                    height: 180px !important;
                }

                /* Dining Strip */
                .dining-status-strip {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                    gap: 8px !important;
                    padding: 10px 12px !important;
                }

                .dining-badge-group {
                    width: 100% !important;
                    justify-content: space-between !important;
                }

                .dining-badge-group .badge {
                    font-size: 0.7rem !important;
                    padding: 4px 6px !important;
                }
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <div class="dash-header">
            <div>
                <h2 class="dash-title"><span id="dashGreetingText"><asp:Literal ID="litGreeting" runat="server">Good Morning, Admin!</asp:Literal></span></h2>
                <p class="dash-subtitle mb-0">Here's what's happening at your hotel today.</p>
            </div>
            <div class="date-badge">
                <i class="bi bi-calendar3"></i>
                <div class="date-badge-text">
                    <small>Today</small>
                    <strong id="dashDateText"><asp:Literal ID="litCurrentDate" runat="server"></asp:Literal></strong>
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
            <!-- Bookings -->
            <div class="col-12 col-sm-6 col-md-4 col-xl">
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
            <div class="col-12 col-sm-6 col-md-4 col-xl">
                <div class="kpi-box">
                    <div class="kpi-icon kpi-purple"><i class="bi bi-percent"></i></div>
                    <div class="kpi-title">Occupancy Rate</div>
                    <div class="kpi-value d-flex justify-content-between align-items-center">
                        <span><asp:Literal ID="lblOccupancyRate" runat="server" Text="0"></asp:Literal>%</span>
                        <i class="bi bi-pie-chart-fill text-muted fs-5 opacity-50 flex-shrink-0 ms-2"></i>
                    </div>
                    <div class="kpi-desc">
                        <asp:Literal ID="lblOccupiedRooms" runat="server" Text="0"></asp:Literal> / <asp:Literal
                            ID="lblTotalRooms" runat="server" Text="0"></asp:Literal> Rooms
                    </div>
                </div>
            </div>
            <!-- Available Rooms -->
            <div class="col-12 col-sm-6 col-md-4 col-xl">
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
            <div class="col-12 col-sm-6 col-md-4 col-xl">
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
            <div class="col-12 col-sm-6 col-md-4 col-xl">
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
                    <div class="d-flex align-items-center justify-content-between h-100 pb-4 donut-status-wrapper">
                        <div style="position: relative; width: 140px; height: 140px;">
                            <canvas id="roomStatusDonutChart"></canvas>
                            <div
                                style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); text-align: center;">
                                <div id="donutCenterTotalRooms" style="font-size:1.5rem; font-weight:700; color:#212529;">
                                    <asp:Literal ID="lblChartDonutCenter" runat="server" Text="0"></asp:Literal>
                                </div>
                                <div style="font-size:0.7rem; color:#6c757d;">Total Rooms</div>
                            </div>
                        </div>
                        <div class="d-flex flex-column gap-2 donut-legend-list" style="width: 120px;">
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

        <!-- ROW 3: TODAY'S ARRIVALS & DEPARTURES (50/50 MATCHING GRID VIEWS) -->
        <div class="row g-3 mb-4">
            <!-- Arrivals GridView Card -->
            <div class="col-12 col-lg-6">
                <div class="dash-card h-100 d-flex flex-column">
                    <div class="dash-card-header mb-3">
                        <h5 class="dash-card-title"><i class="bi bi-calendar2-plus text-warning fs-5"></i> Today's Arrivals</h5>
                        <a href="Bookings.aspx" class="view-all-link">View All <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive flex-grow-1">
                        <table class="dash-gridview-table align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-2 text-start">Ref #</th>
                                    <th class="text-start">Guest</th>
                                    <th class="text-center">Room</th>
                                    <th class="text-center">Time</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center pe-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptArrivals" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-2 text-start">
                                                <span class="fw-bold font-monospace" style="color: #442305; font-size: 0.72rem;">
                                                    <%# Eval("BookingReference") %>
                                                </span>
                                            </td>
                                            <td class="text-start">
                                                <span class="fw-semibold text-dark text-truncate d-inline-block" style="max-width: 95px; vertical-align: middle;" title='<%# Eval("GuestName") %>'>
                                                    <%# Eval("GuestName") %>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-1 py-0" style="font-size: 0.74rem;"><%# Eval("RoomNo") %></span>
                                            </td>
                                            <td class="text-center small text-muted">
                                                <%# Convert.ToDateTime(Eval("CheckInDate")).ToString("hh:mm tt") %>
                                            </td>
                                            <td class="text-center">
                                                <span class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td class="text-center pe-2">
                                                <%# GetArrivalActionHtml(Eval("BookingId"), Eval("GuestName"), Eval("BookingStatus")) %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptArrivals.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-calendar2-check fs-3 d-block mb-2 opacity-50"></i>
                                            <div class="small fw-semibold text-dark mb-1">No Arrivals Scheduled Today</div>
                                            <div class="small text-muted">All guests arriving today are up to date or none are scheduled.</div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-auto pt-3">
                        <a href="Bookings.aspx" class="btn w-100 dash-footer-action-btn" style="border: 1px solid #ebdccb; color: #442305; font-size: 0.84rem; font-weight: 600; padding: 8px 16px; border-radius: 8px; background: #faf6f0;">
                            <i class="bi bi-box-arrow-in-right me-1 text-warning"></i> Manage Guest Check-Ins
                        </a>
                    </div>
                </div>
            </div>

            <!-- Departures GridView Card -->
            <div class="col-12 col-lg-6">
                <div class="dash-card h-100 d-flex flex-column">
                    <div class="dash-card-header mb-3">
                        <h5 class="dash-card-title"><i class="bi bi-box-arrow-right text-warning fs-5"></i> Today's Departures</h5>
                        <a href="Bookings.aspx" class="view-all-link">View All <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive flex-grow-1">
                        <table class="dash-gridview-table align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-2 text-start">Ref #</th>
                                    <th class="text-start">Guest</th>
                                    <th class="text-center">Room</th>
                                    <th class="text-center">Time</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center pe-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptDepartures" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-2 text-start">
                                                <span class="fw-bold font-monospace" style="color: #442305; font-size: 0.72rem;">
                                                    <%# Eval("BookingReference") %>
                                                </span>
                                            </td>
                                            <td class="text-start">
                                                <span class="fw-semibold text-dark text-truncate d-inline-block" style="max-width: 95px; vertical-align: middle;" title='<%# Eval("GuestName") %>'>
                                                    <%# Eval("GuestName") %>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-1 py-0" style="font-size: 0.74rem;"><%# Eval("RoomNo") %></span>
                                            </td>
                                            <td class="text-center small text-muted">
                                                <%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("hh:mm tt") %>
                                            </td>
                                            <td class="text-center">
                                                <span class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td class="text-center pe-2">
                                                <%# GetDepartureActionHtml(Eval("BookingId"), Eval("GuestName"), Eval("BookingStatus")) %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptDepartures.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-box-arrow-right fs-3 d-block mb-2 opacity-50"></i>
                                            <div class="small fw-semibold text-dark mb-1">No Departures Scheduled Today</div>
                                            <div class="small text-muted">All guests departing today have checked out or none are scheduled.</div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="mt-auto pt-3">
                        <a href="Bookings.aspx" class="btn w-100 dash-footer-action-btn" style="border: 1px solid #ebdccb; color: #442305; font-size: 0.84rem; font-weight: 600; padding: 8px 16px; border-radius: 8px; background: #faf6f0;">
                            <i class="bi bi-box-arrow-right me-1 text-warning"></i> Manage Guest Check-Outs
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ROW 4: RECENT BOOKINGS & DINING TODAY (50/50 MATCHING GRID VIEWS) -->
        <div class="row g-3 mb-4">
            <!-- Recent Bookings GridView Card -->
            <div class="col-12 col-lg-6">
                <div class="dash-card h-100 d-flex flex-column">
                    <div class="dash-card-header mb-3">
                        <h5 class="dash-card-title"><i class="bi bi-calendar2-range text-warning fs-5"></i> Recent Bookings</h5>
                        <a href="Bookings.aspx" class="view-all-link">View All <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="table-responsive flex-grow-1">
                        <table class="dash-gridview-table align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-2 text-start">Ref #</th>
                                    <th class="text-start">Guest</th>
                                    <th class="text-center">Room</th>
                                    <th class="text-center">Check-In</th>
                                    <th class="text-center">Check-Out</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center pe-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptRecentBookings" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-2 text-start">
                                                <span class="fw-bold font-monospace" style="color: #442305; font-size: 0.72rem;">
                                                    <%# Eval("BookingReference") %>
                                                </span>
                                            </td>
                                            <td class="text-start">
                                                <span class="fw-semibold text-dark text-truncate d-inline-block" style="max-width: 90px; vertical-align: middle;" title='<%# Eval("GuestName") %>'>
                                                    <%# Eval("GuestName") %>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-1 py-0" style="font-size: 0.74rem;"><%# Eval("RoomNo") %></span>
                                            </td>
                                            <td class="text-center small text-muted" title='<%# Convert.ToDateTime(Eval("CheckInDate")).ToString("dd MMM yyyy") %>'>
                                                <%# Convert.ToDateTime(Eval("CheckInDate")).ToString("dd MMM yy") %>
                                            </td>
                                            <td class="text-center small text-muted" title='<%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("dd MMM yyyy") %>'>
                                                <%# Convert.ToDateTime(Eval("CheckOutDate")).ToString("dd MMM yy") %>
                                            </td>
                                            <td class="text-center">
                                                <span class='status-badge <%# GetStatusBadgeClass(Eval("BookingStatus").ToString()) %>'>
                                                    <%# Eval("BookingStatus") %>
                                                </span>
                                            </td>
                                            <td class="text-center pe-2">
                                                <a href='Bookings.aspx?id=<%# Eval("BookingId") %>' class="action-btn btn-view">View</a>
                                            </td>
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
                    <div class="mt-auto pt-3">
                        <a href="Bookings.aspx" class="btn w-100 dash-footer-action-btn" style="border: 1px solid #ebdccb; color: #442305; font-size: 0.84rem; font-weight: 600; padding: 8px 16px; border-radius: 8px; background: #faf6f0;">
                            <i class="bi bi-journal-bookmark me-1 text-warning"></i> View All Room Bookings
                        </a>
                    </div>
                </div>
            </div>

            <!-- Restaurant / Dining Today GridView Card -->
            <div class="col-12 col-lg-6">
                <div class="dash-card h-100 d-flex flex-column">
                    <div class="dash-card-header dining-card-header mb-3">
                        <div class="dining-header-title-row">
                            <h5 class="dash-card-title mb-0"><i class="bi bi-shop-window text-warning fs-5"></i> Restaurant / Dining Today</h5>
                            <a href="TableReservations.aspx" class="view-all-link dining-mobile-viewall">View All <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <div class="dining-header-actions">
                            <div class="dining-tab-group d-flex gap-1">
                                <button type="button" id="btnDiningResTab" class="dining-tab-btn active" onclick="switchDiningView('res'); return false;">
                                    <i class="bi bi-calendar2-check me-1"></i>Reservations (<asp:Literal ID="litDiningResCount" runat="server" Text="0"></asp:Literal>)
                                </button>
                                <button type="button" id="btnDiningTablesTab" class="dining-tab-btn" onclick="switchDiningView('tables'); return false;">
                                    <i class="bi bi-grid-3x3-gap me-1"></i>Table Status (<asp:Literal ID="litDiningTablesCount" runat="server" Text="0"></asp:Literal>)
                                </button>
                            </div>
                            <a href="TableReservations.aspx" class="view-all-link ms-2 dining-desktop-viewall">View All <i class="bi bi-arrow-right"></i></a>
                        </div>
                    </div>

                    <!-- Restaurant Live Status Compact Strip -->
                    <div class="d-flex align-items-center justify-content-between px-3 py-2 rounded-3 mb-3 dining-status-strip" style="background: #faf6f0; border: 1px solid #ebdccb;">
                        <div class="d-flex align-items-center gap-2 flex-wrap dining-brand-group">
                            <span class="fw-bold text-dark" style="font-family: 'Playfair Display', Georgia, serif; font-size: 0.95rem;">The Royal Kitchen</span>
                            <span class="badge bg-success-subtle text-success rounded-pill fw-semibold border border-success-subtle" style="font-size:0.65rem;">Active</span>
                            <span class="text-muted small d-none d-sm-inline">&bull; Indian | Continental | Chinese</span>
                        </div>
                        <div class="d-flex align-items-center gap-1 flex-wrap dining-badge-group">
                            <span class="badge bg-white text-dark border px-2 py-1" title="Available Tables">
                                <span class="stat-indicator bg-success me-1 d-inline-block" style="width:7px; height:7px;"></span>
                                Avail: <strong class="text-success"><asp:Literal ID="lblTableAvailable" runat="server" Text="0"></asp:Literal></strong>
                            </span>
                            <span class="badge bg-white text-dark border px-2 py-1" title="Booked / Occupied Tables">
                                <span class="stat-indicator bg-danger me-1 d-inline-block" style="width:7px; height:7px;"></span>
                                Booked: <strong class="text-danger"><asp:Literal ID="lblTableOccupied" runat="server" Text="0"></asp:Literal></strong>
                            </span>
                            <span class="badge bg-white text-dark border px-2 py-1" title="Today's Table Reservations">
                                <span class="stat-indicator bg-warning me-1 d-inline-block" style="width:7px; height:7px;"></span>
                                Res: <strong class="text-dark"><asp:Literal ID="lblTodayTableRes" runat="server" Text="0"></asp:Literal></strong>
                            </span>
                            <span style="display:none;"><asp:Literal ID="lblTableReserved" runat="server" Text="0"></asp:Literal></span>
                        </div>
                    </div>

                    <!-- 1. Reservations GridView Table (Default Active) -->
                    <div id="diningResGridViewWrap" class="table-responsive flex-grow-1">
                        <table class="dash-gridview-table align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-2 text-start">Code</th>
                                    <th class="text-start">Customer</th>
                                    <th class="text-center">Table</th>
                                    <th class="text-center">Time</th>
                                    <th class="text-center">Guests</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center pe-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptDiningReservations" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-2 text-start">
                                                <span class="fw-bold font-monospace" style="color: #442305; font-size: 0.72rem;">
                                                    <%# Eval("BookingCode") %>
                                                </span>
                                            </td>
                                            <td class="text-start">
                                                <span class="fw-semibold text-dark text-truncate d-inline-block" style="max-width: 85px; vertical-align: middle;" title='<%# Eval("CustomerName") %>'>
                                                    <%# Eval("CustomerName") %>
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border px-1 py-0" style="font-size: 0.74rem;"><%# Eval("TableNumber") %></span>
                                            </td>
                                            <td class="text-center small text-muted">
                                                <%# Eval("TimeSlot") %>
                                            </td>
                                            <td class="text-center small">
                                                <%# Eval("GuestCount") %>p
                                            </td>
                                            <td class="text-center">
                                                <span class='status-badge <%# GetDiningStatusBadgeClass(Eval("Status").ToString()) %>'>
                                                    <%# Eval("Status") %>
                                                </span>
                                            </td>
                                            <td class="text-center pe-2">
                                                <a href="TableReservations.aspx" class="action-btn btn-view">View</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptDiningReservations.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-3 d-block mb-2 opacity-50"></i>
                                            <div class="small fw-semibold text-dark mb-1">No Table Reservations Found</div>
                                            <div class="small text-muted">Click &ldquo;View Reservations&rdquo; to manage table bookings.</div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- 2. Restaurant Tables Inventory GridView Table (Tab Toggle) -->
                    <div id="diningTablesGridViewWrap" class="table-responsive flex-grow-1" style="display: none;">
                        <table class="dash-gridview-table align-middle">
                            <thead>
                                <tr>
                                    <th class="ps-2 text-start">Table #</th>
                                    <th class="text-start">Name</th>
                                    <th class="text-center">Section</th>
                                    <th class="text-center">Capacity</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center pe-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptRestaurantTables" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="ps-2 text-start">
                                                <span class="fw-bold font-monospace" style="color: #442305; font-size: 0.72rem;">
                                                    <%# Eval("TableNumber") %>
                                                </span>
                                            </td>
                                            <td class="text-start">
                                                <span class="fw-semibold text-dark text-truncate d-inline-block" style="max-width: 90px; vertical-align: middle;" title='<%# Eval("TableName") %>'>
                                                    <%# Eval("TableName") %>
                                                </span>
                                            </td>
                                            <td class="text-center small text-muted">
                                                <%# Eval("Section") %>
                                            </td>
                                            <td class="text-center small">
                                                <%# Eval("Capacity") %> Seats
                                            </td>
                                            <td class="text-center">
                                                <span class='status-badge <%# GetTableStatusBadgeClass(Eval("TableStatus").ToString()) %>'>
                                                    <%# Eval("TableStatus") %>
                                                </span>
                                            </td>
                                            <td class="text-center pe-2">
                                                <a href="RestaurantTables.aspx" class="action-btn btn-view">Manage</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <% if (rptRestaurantTables.Items.Count==0) { %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-grid-3x3-gap fs-3 d-block mb-2 opacity-50"></i>
                                            <div class="small fw-semibold text-dark mb-1">No Restaurant Tables Registered</div>
                                            <div class="small text-muted">Click &ldquo;Manage Tables&rdquo; to set up restaurant tables.</div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- Dining Management Action Buttons -->
                    <div class="d-flex gap-2 mt-auto pt-3">
                        <a href="RestaurantTables.aspx" class="btn flex-fill" style="background: #5a2e15; color: #fff; font-size: 0.84rem; font-weight: 600; padding: 8px 16px; border-radius: 8px;">
                            <i class="bi bi-grid-3x3-gap me-1"></i> Manage Tables
                        </a>
                        <a href="TableReservations.aspx" class="btn flex-fill" style="border: 1px solid #dee2e6; color: #495057; font-size: 0.84rem; font-weight: 600; padding: 8px 16px; border-radius: 8px; background: #fff;">
                            <i class="bi bi-calendar2-check me-1"></i> View Reservations
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- ROW 5: QUICK ACTIONS (HORIZONTAL GRID) -->
        <div class="dash-card mb-4">
            <div class="dash-card-header mb-3">
                <h5 class="dash-card-title"><i class="bi bi-lightning-charge text-warning fs-5"></i> Quick Actions</h5>
                <span class="text-muted small d-none d-sm-inline">Fast administrative shortcuts</span>
            </div>
            <div class="row g-3">
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="Bookings.aspx?status=Confirmed" class="qa-item qa-1 w-100">
                        <i class="bi bi-calendar-plus fs-4"></i>
                        <span>+ New Booking</span>
                    </a>
                </div>
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="AddRoom.aspx" class="qa-item qa-2 w-100">
                        <i class="bi bi-door-open fs-4"></i>
                        <span>+ Add Room</span>
                    </a>
                </div>
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="Bookings.aspx" class="qa-item qa-3 w-100">
                        <i class="bi bi-box-arrow-in-right fs-4"></i>
                        <span>Check-In</span>
                    </a>
                </div>
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="Bookings.aspx" class="qa-item qa-4 w-100">
                        <i class="bi bi-box-arrow-right fs-4"></i>
                        <span>+ Check-Out</span>
                    </a>
                </div>
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="RestaurantTables.aspx" class="qa-item qa-5 w-100">
                        <i class="bi bi-cup-hot fs-4"></i>
                        <span>Manage Tables</span>
                    </a>
                </div>
                <div class="col-6 col-sm-4 col-lg-2">
                    <a href="RoomRates.aspx" class="qa-item qa-6 w-100">
                        <i class="bi bi-bar-chart-line fs-4"></i>
                        <span>Tariff Matrix</span>
                    </a>
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

                // Dynamic Greeting & Date
                (function updateDynamicGreetingAndDate() {
                    try {
                        const now = new Date();
                        const hour = now.getHours();
                        let greeting = "Good Morning, Admin!";
                        if (hour >= 5 && hour < 12) {
                            greeting = "Good Morning, Admin!";
                        } else if (hour >= 12 && hour < 17) {
                            greeting = "Good Afternoon, Admin!";
                        } else if (hour >= 17 && hour < 21) {
                            greeting = "Good Evening, Admin!";
                        } else {
                            greeting = "Good Night, Admin!";
                        }

                        const elGreeting = document.getElementById('dashGreetingText');
                        if (elGreeting) {
                            elGreeting.textContent = greeting;
                        }

                        const elDate = document.getElementById('dashDateText');
                        if (elDate) {
                            const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                            const dayNum = String(now.getDate()).padStart(2, '0');
                            const monthName = months[now.getMonth()];
                            const year = now.getFullYear();
                            const dayName = days[now.getDay()];
                            elDate.textContent = dayNum + ' ' + monthName + ' ' + year + ', ' + dayName;
                        }
                    } catch (e) {
                        console.error(e);
                    }
                })();

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
                    const centerTotalEl = document.getElementById('donutCenterTotalRooms');
                    if (centerTotalEl && hfDonutTotal) {
                        centerTotalEl.innerText = hfDonutTotal;
                    }
                } catch (e) { console.error(e); }

                // Bookings Overview Area Chart
                const canvas1 = document.getElementById('bookingsOverviewChart');
                if (canvas1) {
                    const existingChart1 = Chart.getChart(canvas1);
                    if (existingChart1) existingChart1.destroy();
                    const ctx1 = canvas1.getContext('2d');
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
                }

                // Room Status Donut Chart
                const canvas2 = document.getElementById('roomStatusDonutChart');
                if (canvas2) {
                    const existingChart2 = Chart.getChart(canvas2);
                    if (existingChart2) existingChart2.destroy();
                    const ctx2 = canvas2.getContext('2d');
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
                }
            });

            function switchDiningView(tab) {
                var resWrap = document.getElementById('diningResGridViewWrap');
                var tblWrap = document.getElementById('diningTablesGridViewWrap');
                var resBtn = document.getElementById('btnDiningResTab');
                var tblBtn = document.getElementById('btnDiningTablesTab');
                if (!resWrap || !tblWrap) return;
                if (tab === 'tables') {
                    resWrap.style.display = 'none';
                    tblWrap.style.display = 'block';
                    if (tblBtn) tblBtn.classList.add('active');
                    if (resBtn) resBtn.classList.remove('active');
                } else {
                    resWrap.style.display = 'block';
                    tblWrap.style.display = 'none';
                    if (resBtn) resBtn.classList.add('active');
                    if (tblBtn) tblBtn.classList.remove('active');
                }
            }
        </script>
    </asp:Content>