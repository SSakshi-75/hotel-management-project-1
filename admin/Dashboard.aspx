<%@ Page Title="Admin Executive Dashboard | Hotel Management" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">

        <meta name="description" content="Hotel Management System Executive Real-time Dashboard">

    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- ==========================================
         EXECUTIVE WELCOME BANNER
         ========================================== -->
        <div class="dashboard-welcome-strip">
            <div class="row align-items-center g-4">

                <div class="col-lg-7">

                    <div class="welcome-subtitle-badge">
                        <i class="bi bi-patch-check-fill text-gold me-1"></i>
                        Executive Operations Console
                    </div>

                    <h1 class="welcome-title">
                        Welcome back, Administrator
                    </h1>

                    <p class="welcome-desc">
                        Hotel Administrative Console. Real-time overview of room inventory,
                        guest reservations, front desk flow, and revenue operations.
                    </p>

                </div>

                <div class="col-lg-5">

                    <div class="welcome-actions-group justify-content-lg-end">

                        <button type="button" class="btn btn-welcome-primary"
                            onclick="triggerQuickAction('new-reservation')">

                            <i class="bi bi-calendar-plus me-1"></i>
                            + New Reservation

                        </button>

                        <button type="button" class="btn btn-welcome-glass"
                            onclick="triggerQuickAction('quick-checkin')">

                            <i class="bi bi-person-check me-1"></i>
                            Express Check-In

                        </button>

                        <button type="button" class="btn btn-welcome-glass" onclick="triggerQuickAction('block-room')">

                            <i class="bi bi-shield-lock me-1"></i>
                            Block Room

                        </button>

                        <button type="button" class="btn btn-welcome-glass"
                            onclick="triggerQuickAction('export-report')" title="Download Daily Operations Briefing">

                            <i class="bi bi-download me-1"></i>
                            Export PDF

                        </button>

                    </div>

                </div>

            </div>
        </div>


        <!-- ==========================================
         KEY PERFORMANCE INDICATORS (KPIs)
         ========================================== -->
        <div class="row g-3 mb-4">

            <!-- KPI 1 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-gold">
                            <i class="bi bi-currency-rupee"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            0.0%
                        </span>

                    </div>

                    <div class="metric-title">
                        Today's Revenue
                    </div>

                    <div class="metric-value">
                        ₹0.00
                    </div>

                    <p class="metric-caption">
                        vs ₹0.00 yesterday
                    </p>

                </div>

            </div>


            <!-- KPI 2 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-brown">
                            <i class="bi bi-pie-chart-fill"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            0.0%
                        </span>

                    </div>

                    <div class="metric-title">
                        Room Occupancy
                    </div>

                    <div class="metric-value">
                        0.0%
                    </div>

                    <div class="progress-luxury">

                        <div class="progress-bar progress-bar-gold" role="progressbar" style="width: 0%"
                            aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                        </div>

                    </div>

                    <p class="metric-caption mt-2">
                        0 of 0 Rooms Occupied
                    </p>

                </div>

            </div>


            <!-- KPI 3 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-emerald">
                            <i class="bi bi-journal-bookmark-fill"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            0 Active
                        </span>

                    </div>

                    <div class="metric-title">
                        Active Bookings
                    </div>

                    <div class="metric-value">
                        0 Stays
                    </div>

                    <p class="metric-caption">
                        0 Arrived &bull; 0 In-Stay
                    </p>

                </div>

            </div>


            <!-- KPI 4 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-sapphire">
                            <i class="bi bi-arrow-left-right"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            <i class="bi bi-clock"></i> Today
                        </span>

                    </div>

                    <div class="metric-title">
                        Front Desk Flow
                    </div>

                    <div class="metric-value">
                        0 / 0
                    </div>

                    <p class="metric-caption">
                        0 Check-Ins &bull; 0 Check-Outs
                    </p>

                </div>

            </div>


            <!-- KPI 5 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-amber">
                            <i class="bi bi-cup-straw"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            0% Cap
                        </span>

                    </div>

                    <div class="metric-title">
                        Dining Covers
                    </div>

                    <div class="metric-value">
                        0 Tables
                    </div>

                    <p class="metric-caption">
                        No table reservations today
                    </p>

                </div>

            </div>


            <!-- KPI 6 -->
            <div class="col-12 col-sm-6 col-xl-4 col-xxl-2">

                <div class="metric-card">

                    <div class="metric-card-top">

                        <div class="metric-icon-box icon-purple">
                            <i class="bi bi-award-fill"></i>
                        </div>

                        <span class="metric-trend-pill trend-neutral">
                            0 VIPs
                        </span>

                    </div>

                    <div class="metric-title">
                        VIP In-House
                    </div>

                    <div class="metric-value">
                        0 Guests
                    </div>

                    <p class="metric-caption">
                        No VIP guests in-house
                    </p>

                </div>

            </div>

        </div>


        <!-- ==========================================
         LIVE ROOM OCCUPANCY
         ========================================== -->
        <div class="content-card">

            <div class="content-card-header">

                <div>

                    <h3 class="content-card-title">
                        <i class="bi bi-door-open-fill text-gold"></i>
                        Live Room &amp; Suite Inventory Matrix
                    </h3>

                    <p class="content-card-subtitle">
                        Real-time room occupancy status across wings and luxury tiers
                    </p>

                </div>

                <div class="filter-btn-group">

                    <button type="button" class="filter-pill-btn room-filter-btn active" data-room-filter="all">
                        All Rooms
                    </button>

                    <button type="button" class="filter-pill-btn room-filter-btn" data-room-filter="occupied">
                        Occupied
                    </button>

                    <button type="button" class="filter-pill-btn room-filter-btn" data-room-filter="available">
                        Available
                    </button>

                    <button type="button" class="filter-pill-btn room-filter-btn" data-room-filter="reserved">
                        Reserved
                    </button>

                    <button type="button" class="filter-pill-btn room-filter-btn" data-room-filter="cleaning">
                        Cleaning
                    </button>

                </div>

            </div>


            <div class="room-grid-wrapper">

                <div id="roomStatusGrid" class="row g-3">

                    <div class="col-12 text-center py-5">

                        <div class="py-4">

                            <i class="bi bi-door-closed text-gold fs-1 d-block mb-3 opacity-75"></i>

                            <h5 class="fw-bold text-dark mb-2"
                                style="font-family: var(--font-heading); font-size: 1.5rem;">
                                No Room Records Loaded
                            </h5>

                            <p class="small text-muted mb-3 mx-auto" style="max-width: 480px;">

                                Room inventory and live occupancy status will automatically
                                display here once rooms are synchronized with the central database.

                            </p>

                            <button type="button" class="btn btn-sm btn-outline-gold"
                                onclick="triggerQuickAction('block-room')">

                                <i class="bi bi-plus-circle me-1"></i>
                                Configure Rooms

                            </button>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- ==========================================
         REGISTERED GUESTS - DYNAMIC DATABASE SECTION
         ========================================== -->
        <div class="content-card mt-4">

            <div class="content-card-header">

                <div>

                    <h3 class="content-card-title">

                        <i class="bi bi-people-fill text-gold"></i>

                        Registered Guests

                    </h3>

                    <p class="content-card-subtitle">

                        Guest registrations from the hotel database

                    </p>

                </div>

                <div class="d-flex align-items-center gap-2 flex-wrap">

                    <div class="input-group input-group-sm" style="max-width: 320px;">
                        <input type="search" id="userSearchInput" class="form-control form-control-sm"
                            placeholder="Search by name, email, phone, ID..."
                            autocomplete="off"
                            onkeyup="filterRegisteredGuests()"
                            onsearch="filterRegisteredGuests()"
                            onkeydown="if(event.key==='Enter'){event.preventDefault();filterRegisteredGuests();}"
                            style="border-color: rgba(184, 142, 104, 0.4); border-radius: 20px 0 0 20px; font-size: 0.82rem; padding: 6px 14px;">
                        <button type="button" class="btn btn-outline-gold" id="btnUserSearch"
                            onclick="filterRegisteredGuests()"
                            style="border-radius: 0 20px 20px 0; font-size: 0.82rem; padding: 6px 14px;">
                            <i class="bi bi-search"></i> Search
                        </button>
                    </div>

                    <button type="button" class="btn btn-sm btn-outline-secondary" id="btnUserReset"
                        onclick="resetRegisteredGuests()"
                        style="display: none; border-radius: 20px; font-size: 0.82rem; padding: 6px 12px;">
                        <i class="bi bi-x-circle"></i> Clear
                    </button>

                    <span class="badge bg-gold-subtle text-gold">

                        Registered Users

                    </span>

                </div>

            </div>


            <div class="table-luxury-wrapper">

                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-luxury"
                    GridLines="None" EmptyDataText="No registered guests found.">

                    <Columns>


                        <asp:BoundField DataField="UserId" HeaderText="ID" />


                        <asp:TemplateField HeaderText="Guest Name">

                            <ItemTemplate>

                                <%# Eval("FirstName") + " " + Eval("LastName") %>

                            </ItemTemplate>

                        </asp:TemplateField>


                        <asp:BoundField DataField="Email" HeaderText="Email" />


                        <asp:BoundField DataField="Phone" HeaderText="Phone" />


                        <asp:BoundField DataField="CreatedAt" HeaderText="Registered On"
                            DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" />

                    </Columns>

                </asp:GridView>

                <!-- Empty Search Results Message (when searching) -->
                <div id="noUserResultsRow" class="text-center py-4" style="display: none;">
                    <i class="bi bi-search text-muted fs-2 mb-2 d-block"></i>
                    <h6 class="fw-bold text-muted mb-1">No registered guests matched your search.</h6>
                    <p class="small text-muted mb-0">Try searching by another name, email address, phone number, or ID.</p>
                </div>

            </div>

        </div>

        <script>
            function filterRegisteredGuests() {
                var input = document.getElementById('userSearchInput');
                var resetBtn = document.getElementById('btnUserReset');
                var noResults = document.getElementById('noUserResultsRow');
                var table = document.querySelector('[id$="gvUsers"]');
                if (!input || !table) return;

                var query = input.value.trim().toLowerCase();
                if (resetBtn) {
                    resetBtn.style.display = query.length > 0 ? 'inline-block' : 'none';
                }

                var rows = table.querySelectorAll('tr');
                var visibleCount = 0;
                var dataRowCount = 0;

                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.querySelector('th')) continue;
                    var cells = row.querySelectorAll('td');
                    if (!cells || cells.length === 0) continue;
                    if (cells.length === 1 && cells[0].hasAttribute('colspan')) continue;

                    dataRowCount++;
                    var text = (row.textContent || row.innerText || '').toLowerCase();
                    if (query === '' || text.indexOf(query) > -1) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                }

                if (noResults && dataRowCount > 0) {
                    noResults.style.display = (visibleCount === 0 && query !== '') ? 'block' : 'none';
                }
            }

            function resetRegisteredGuests() {
                var input = document.getElementById('userSearchInput');
                if (input) {
                    input.value = '';
                    filterRegisteredGuests();
                    input.focus();
                }
            }
        </script>


        <!-- ==========================================
         RECENT BOOKINGS & GUEST ROSTER
         ========================================== -->
        <div class="content-card mt-4">

            <div class="content-card-header">

                <div>

                    <h3 class="content-card-title">

                        <i class="bi bi-calendar-check-fill text-gold"></i>

                        Live Reservations &amp; Front Desk Ledger

                    </h3>

                    <p class="content-card-subtitle">

                        Real-time incoming and active guest stays for hotel property

                    </p>

                </div>

                <div class="d-flex align-items-center gap-2 flex-wrap">

                    <div class="filter-btn-group">

                        <button type="button" class="filter-pill-btn booking-filter-btn active" data-filter="all">
                            All Stays
                        </button>

                        <button type="button" class="filter-pill-btn booking-filter-btn" data-filter="confirmed">
                            Confirmed
                        </button>

                        <button type="button" class="filter-pill-btn booking-filter-btn" data-filter="checkedin">
                            Checked-In
                        </button>

                        <button type="button" class="filter-pill-btn booking-filter-btn" data-filter="pending">
                            Pending
                        </button>

                    </div>

                    <div class="ms-lg-2">

                        <input type="text" id="tableSearchInput" class="form-control form-control-sm"
                            placeholder="Search guest name, phone..."
                            style="border-color: rgba(184, 142, 104, 0.35); border-radius: 20px; font-size: 0.82rem; padding: 5px 14px; width: 220px;">

                    </div>

                </div>

            </div>


            <div class="table-luxury-wrapper">

                <table id="recentBookingsTable" class="table table-luxury">

                    <thead>

                        <tr>

                            <th>Booking ID</th>
                            <th>Guest Information</th>
                            <th>Room &amp; Suite</th>
                            <th>Dates of Stay</th>
                            <th>Total Amount</th>
                            <th>Payment</th>
                            <th>Reservation Status</th>
                            <th class="text-end">Actions</th>

                        </tr>

                    </thead>

                    <tbody>

                        <tr id="emptyBookingsRow">

                            <td colspan="8" class="text-center py-5">

                                <div class="py-4">

                                    <i class="bi bi-calendar2-x text-gold fs-1 d-block mb-3 opacity-75"></i>

                                    <h5 class="fw-bold text-dark mb-2"
                                        style="font-family: var(--font-heading); font-size: 1.5rem;">

                                        No Active Bookings Found

                                    </h5>

                                    <p class="small text-muted mb-3 mx-auto" style="max-width: 480px;">

                                        There are currently no active reservations or in-house
                                        guest records in the ledger. New bookings will appear here in real time.

                                    </p>

                                    <button type="button" class="btn btn-sm btn-welcome-primary"
                                        onclick="triggerQuickAction('new-reservation')">

                                        <i class="bi bi-calendar-plus me-1"></i>
                                        Create First Reservation

                                    </button>

                                </div>

                            </td>

                        </tr>

                    </tbody>

                </table>


                <div id="noBookingsRow" class="text-center py-5" style="display: none;">

                    <i class="bi bi-search text-muted fs-1 mb-2 d-block"></i>

                    <h6 class="fw-bold text-muted">
                        No reservations matched your search query.
                    </h6>

                    <p class="small text-muted mb-0">

                        Try searching by another guest name, phone number,
                        or booking reference.

                    </p>

                </div>

            </div>

        </div>


        <!-- ==========================================
         ANALYTICS
         ========================================== -->
        <div class="row g-4 mt-1">

            <div class="col-12 col-xl-8">

                <div class="content-card h-100">

                    <div class="content-card-header">

                        <div>

                            <h3 class="content-card-title">

                                <i class="bi bi-graph-up-arrow text-gold"></i>

                                7-Day Revenue &amp; Occupancy Trend

                            </h3>

                            <p class="content-card-subtitle">

                                Hotel daily revenue performance &bull; Current week

                            </p>

                        </div>

                        <div class="d-flex align-items-center gap-2">

                            <span class="badge bg-gold-subtle text-gold px-3 py-2 fw-semibold">

                                Total Week: ₹0.00

                            </span>

                        </div>

                    </div>


                    <div class="chart-card-body">

                        <div class="chart-bar-container">

                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Mon: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Mon
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Tue: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Tue
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Wed: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Wed
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Thu: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Thu
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Fri: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Fri
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Sat: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #E2DBD2;">
                                </div>

                                <span class="chart-col-label">
                                    Sat
                                </span>
                            </div>


                            <div class="chart-col">
                                <span class="chart-bar-tooltip">
                                    Sun: ₹0.00 (0%)
                                </span>

                                <div class="chart-bar-pillar" style="height: 6px; background: #B88E68;">
                                </div>

                                <span class="chart-col-label text-gold fw-bold">
                                    Today
                                </span>
                            </div>

                        </div>


                        <div class="row g-3 pt-3 mt-1 text-center">

                            <div class="col-4 border-end">

                                <div class="text-muted small">
                                    Avg Daily Revenue
                                </div>

                                <div class="fw-bold fs-5 text-dark">
                                    ₹0.00
                                </div>

                            </div>


                            <div class="col-4 border-end">

                                <div class="text-muted small">
                                    Peak Day
                                </div>

                                <div class="fw-bold fs-5 text-gold">
                                    --
                                </div>

                            </div>


                            <div class="col-4">

                                <div class="text-muted small">
                                    Weekly RevPAR
                                </div>

                                <div class="fw-bold fs-5 text-dark">
                                    ₹0.00
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- VIP ARRIVALS -->
            <div class="col-12 col-xl-4">

                <div class="content-card h-100">

                    <div class="content-card-header">

                        <div>

                            <h3 class="content-card-title">

                                <i class="bi bi-person-lines-fill text-gold"></i>
                                VIP Arrivals

                            </h3>

                            <p class="content-card-subtitle">

                                Scheduled check-ins requiring executive attention

                            </p>

                        </div>

                        <span class="badge bg-gold-subtle text-gold">
                            0 Scheduled
                        </span>

                    </div>


                    <div class="arrival-list">

                        <div class="text-center py-4 px-2">

                            <i class="bi bi-person-check text-gold fs-2 d-block mb-2 opacity-75"></i>

                            <h6 class="fw-bold text-dark mb-1"
                                style="font-family: var(--font-heading); font-size: 1.25rem;">

                                No VIP Arrivals Scheduled

                            </h6>

                            <p class="small text-muted mb-0">

                                Upcoming arrivals requiring executive concierge
                                or personalized amenities will appear here.

                            </p>

                        </div>


                        <div class="p-3 bg-light rounded-3 border border-secondary border-opacity-10 mt-3">

                            <div class="d-flex align-items-center gap-2 mb-1 text-gold fw-bold small">

                                <i class="bi bi-info-circle-fill"></i>
                                Concierge Protocol

                            </div>

                            <div class="small text-muted" style="line-height: 1.4;">

                                VIP concierge protocol active.
                                Welcome beverages and express check-in prepared upon guest arrival.

                            </div>

                        </div>

                    </div>

                </div>

            </div>

        </div>


        <!-- ==========================================
         LIVE AUDIT & ACTIVITY STREAM
         ========================================== -->
        <div class="row mt-4">

            <div class="col-12">

                <div class="content-card mb-0">

                    <div class="content-card-header">

                        <div>

                            <h3 class="content-card-title">

                                <i class="bi bi-activity text-gold"></i>

                                Property Activity &amp; Operational Stream

                            </h3>

                            <p class="content-card-subtitle">

                                Real-time event logging across Front Desk,
                                Housekeeping &amp; Point-of-Sale

                            </p>

                        </div>

                        <span class="badge bg-success-subtle text-success border border-success-subtle">

                            <i class="bi bi-broadcast me-1"></i>
                            Stream Ready

                        </span>

                    </div>


                    <div class="text-center py-5 px-3">

                        <i class="bi bi-clock-history text-gold fs-2 d-block mb-2 opacity-75"></i>

                        <h6 class="fw-bold text-dark mb-1"
                            style="font-family: var(--font-heading); font-size: 1.25rem;">

                            No Recent System Activities

                        </h6>

                        <p class="small text-muted mb-0">

                            Operational events across front desk,
                            housekeeping, and billing will stream here in real time.

                        </p>

                    </div>

                </div>

            </div>

        </div>

    </asp:Content>