<%@ Page Title="Admin Dashboard | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <link rel="stylesheet" type="text/css" href="css/dashboard.css">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
         ADMIN DASHBOARD SECTION
         ========================================== -->
        <div class="admin-dashboard-wrapper py-5">
            <div class="container px-3 px-lg-5">

                <!-- Dashboard Header Row -->
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-3 border-bottom gap-3"
                    data-aos="fade-down" data-aos-duration="800">
                    <div>
                        <span class="badge bg-warning text-dark mb-2 px-3 py-1 text-uppercase fw-bold"
                            style="font-size: 0.72rem; letter-spacing: 1px;">
                            <i class="bi bi-shield-check me-1"></i> Admin Console
                        </span>
                        <h1 class="display-5 font-serif fw-bold text-dark mb-1"
                            style="font-family: 'Cormorant Upright', serif; color: #442305 !important;">
                            Hotel Executive Dashboard
                        </h1>
                        <p class="text-muted mb-0">Overview of room occupancy, guest reservations, and daily revenue.
                        </p>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-navbar-login px-3 py-2 fw-bold text-uppercase shadow-sm"
                            onclick="window.print();">
                            <i class="bi bi-printer me-1"></i> Print Report
                        </button>
                        <a href="../Booking.aspx"
                            class="btn btn-navbar-theme px-3 py-2 fw-bold text-uppercase shadow-sm"
                            style="border-radius: 4px !important;">
                            <i class="bi bi-plus-circle me-1"></i> New Booking
                        </a>
                    </div>
                </div>

                <!-- 4 KPI Metrics Row -->
                <div class="row g-3 mb-4" data-aos="fade-up" data-aos-duration="900">

                    <!-- Card 1: Today's Reservations -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="metric-card">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="metric-title">Today's Bookings</div>
                                    <div class="metric-value">48</div>
                                    <div class="small text-success fw-semibold">
                                        <i class="bi bi-arrow-up-right"></i> +12.4% this week
                                    </div>
                                </div>
                                <div class="metric-icon-box icon-dark">
                                    <i class="bi bi-calendar-event"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Occupancy Rate -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="metric-card">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="metric-title">Occupancy Rate</div>
                                    <div class="metric-value">87.5%</div>
                                    <div class="small text-success fw-semibold">
                                        <i class="bi bi-arrow-up-right"></i> 42 / 48 Suites
                                    </div>
                                </div>
                                <div class="metric-icon-box icon-gold">
                                    <i class="bi bi-door-closed"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Card 3: Today's Revenue -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="metric-card">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="metric-title">Today's Revenue</div>
                                    <div class="metric-value">&#8377;3,84,500</div>
                                    <div class="small text-success fw-semibold">
                                        <i class="bi bi-arrow-up-right"></i> +18.2% vs target
                                    </div>
                                </div>
                                <div class="metric-icon-box icon-success">
                                    <i class="bi bi-currency-rupee"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Card 4: In-House Guests -->
                    <div class="col-sm-6 col-xl-3">
                        <div class="metric-card">
                            <div class="d-flex justify-content-between align-items-start">
                                <div>
                                    <div class="metric-title">In-House Guests</div>
                                    <div class="metric-value">96</div>
                                    <div class="small text-muted fw-semibold">
                                        <i class="bi bi-people"></i> 14 Check-outs today
                                    </div>
                                </div>
                                <div class="metric-icon-box icon-info">
                                    <i class="bi bi-person-check"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Main Table & Status Section -->
                <div class="row g-4" data-aos="fade-up" data-aos-duration="1000">

                    <!-- Left: Recent Reservations (8 cols) -->
                    <div class="col-xl-8">
                        <div class="content-card">
                            <div class="content-card-header">
                                <h2 class="content-card-title">
                                    <i class="bi bi-receipt text-warning"></i> Recent Guest Reservations
                                </h2>
                                <span class="badge bg-dark">Live Sync</span>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-luxury align-middle">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Guest Name</th>
                                            <th>Suite Type</th>
                                            <th>Dates</th>
                                            <th>Status</th>
                                            <th>Amount</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><span class="fw-bold text-dark">#HTL-9042</span></td>
                                            <td>
                                                <div class="fw-semibold">Vikram Malhotra</div>
                                                <small class="text-muted">vikram.m@example.com</small>
                                            </td>
                                            <td>Deluxe King Suite</td>
                                            <td>12 Sep - 15 Sep</td>
                                            <td><span class="badge-status badge-confirmed">Confirmed</span></td>
                                            <td class="fw-bold">&#8377;42,500</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-dark"
                                                    onclick="alert('Viewing Details for Booking #HTL-9042');">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="fw-bold text-dark">#HTL-9041</span></td>
                                            <td>
                                                <div class="fw-semibold">Ananya Sharma</div>
                                                <small class="text-muted">ananya.s@example.com</small>
                                            </td>
                                            <td>Presidential Villa</td>
                                            <td>11 Sep - 16 Sep</td>
                                            <td><span class="badge-status badge-checkedin">In-House</span></td>
                                            <td class="fw-bold">&#8377;1,25,000</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-dark"
                                                    onclick="alert('Viewing Details for Booking #HTL-9041');">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="fw-bold text-dark">#HTL-9040</span></td>
                                            <td>
                                                <div class="fw-semibold">David Richardson</div>
                                                <small class="text-muted">david.r@example.com</small>
                                            </td>
                                            <td>Executive Ocean Suite</td>
                                            <td>13 Sep - 17 Sep</td>
                                            <td><span class="badge-status badge-confirmed">Confirmed</span></td>
                                            <td class="fw-bold">&#8377;64,000</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-dark"
                                                    onclick="alert('Viewing Details for Booking #HTL-9040');">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="fw-bold text-dark">#HTL-9039</span></td>
                                            <td>
                                                <div class="fw-semibold">Pooja Verma</div>
                                                <small class="text-muted">pooja.v@example.com</small>
                                            </td>
                                            <td>Luxury Penthouse</td>
                                            <td>14 Sep - 18 Sep</td>
                                            <td><span class="badge-status badge-pending">Pending</span></td>
                                            <td class="fw-bold">&#8377;98,000</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-dark"
                                                    onclick="alert('Viewing Details for Booking #HTL-9039');">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><span class="fw-bold text-dark">#HTL-9038</span></td>
                                            <td>
                                                <div class="fw-semibold">Rajesh Kothari</div>
                                                <small class="text-muted">rajesh.k@example.com</small>
                                            </td>
                                            <td>Deluxe King Suite</td>
                                            <td>10 Sep - 12 Sep</td>
                                            <td><span class="badge-status badge-checkedin">In-House</span></td>
                                            <td class="fw-bold">&#8377;28,000</td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-outline-dark"
                                                    onclick="alert('Viewing Details for Booking #HTL-9038');">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Right: Room Status & Staff Alerts (4 cols) -->
                    <div class="col-xl-4">

                        <!-- Room Status Inventory -->
                        <div class="content-card">
                            <div class="content-card-header">
                                <h2 class="content-card-title">
                                    <i class="bi bi-pie-chart-fill text-warning"></i> Room Occupancy
                                </h2>
                            </div>
                            <div class="p-4">

                                <div class="py-2 border-bottom">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="fw-semibold small">Deluxe King Suites</span>
                                        <span class="small text-muted">10 / 12 Booked</span>
                                    </div>
                                    <div class="progress progress-luxury">
                                        <div class="progress-bar progress-bar-luxury" style="width: 83%;"></div>
                                    </div>
                                </div>

                                <div class="py-2 border-bottom">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="fw-semibold small">Executive Ocean Suites</span>
                                        <span class="small text-muted">7 / 8 Booked</span>
                                    </div>
                                    <div class="progress progress-luxury">
                                        <div class="progress-bar progress-bar-luxury" style="width: 87.5%;"></div>
                                    </div>
                                </div>

                                <div class="py-2 border-bottom">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="fw-semibold small">Presidential Villas</span>
                                        <span class="small text-muted">3 / 4 Booked</span>
                                    </div>
                                    <div class="progress progress-luxury">
                                        <div class="progress-bar progress-bar-luxury" style="width: 75%;"></div>
                                    </div>
                                </div>

                                <div class="py-2">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="fw-semibold small">Luxury Penthouses</span>
                                        <span class="small fw-bold text-danger">2 / 2 Fully Booked</span>
                                    </div>
                                    <div class="progress progress-luxury">
                                        <div class="progress-bar progress-bar-luxury"
                                            style="width: 100%; background: #442305;"></div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Staff Action / Logout card -->
                        <div class="content-card text-center p-4">
                            <div class="rounded-circle bg-dark text-white mx-auto d-flex align-items-center justify-content-center mb-3"
                                style="width: 54px; height: 54px; border: 2px solid #B88E68;">
                                <i class="bi bi-person-fill fs-4 text-warning"></i>
                            </div>
                            <h5 class="fw-bold text-dark mb-1">Logged in as Administrator</h5>
                            <p class="text-muted small mb-3">General Manager &bull; Security Level: High</p>
                            <div class="d-flex justify-content-center gap-2">
                                <a href="../index.aspx" class="btn btn-sm btn-outline-dark px-3 py-1">
                                    <i class="bi bi-house me-1"></i> Website
                                </a>
                                <a href="Login.aspx" class="btn btn-sm btn-outline-danger px-3 py-1">
                                    <i class="bi bi-box-arrow-right me-1"></i> Logout
                                </a>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>

    </asp:Content>