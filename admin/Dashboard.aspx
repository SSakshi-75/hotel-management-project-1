<%@ Page Title="Admin Dashboard | Hotel Management" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management System Executive Real-time Dashboard">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- On-Page Admin Login Confirmation Banner (NO POPUP: White BG & Green Text) -->
        <div id="loginSuccessBanner"
            class="alert alert-dismissible fade show d-none align-items-center gap-3 p-3 rounded-4 shadow-sm mb-4"
            role="alert"
            style="background-color: #ffffff !important; border: 1.5px solid #22c55e !important; border-left: 5px solid #16a34a !important;">
            <div class="d-flex align-items-center justify-content-center rounded-circle flex-shrink-0"
                style="width: 38px; height: 38px; background-color: #f0fdf4;">
                <i class="bi bi-check2-circle fs-5" style="color: #16a34a;"></i>
            </div>
            <div class="flex-grow-1">
                <strong class="d-block fw-bold mb-0" style="color: #15803d; font-size: 0.95rem;">Admin Login
                    Successfully!</strong>
                <span class="small" style="color: #16a34a;">Welcome back to the Hotel Management Executive Console. All
                    real-time hotel metrics are synchronized.</span>
            </div>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>



        <!-- ==========================================
             2. TOP 6 KEY METRIC CARDS (KPIs)
             ========================================== -->
        <div class="row g-3 mb-4">

            <!-- Card 1: Today's Revenue -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-amber-subtle text-warning-dark">
                            <i class="bi bi-currency-rupee fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">Today</span>
                    </div>
                    <div class="text-muted small fw-semibold">Today's Revenue</div>
                    <div class="fs-4 fw-bold text-dark my-1">&#8377;0.00</div>
                    <div class="text-muted small">0 Transactions Today</div>
                </div>
            </div>

            <!-- Card 2: Room Occupancy -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-blue-subtle text-primary">
                            <i class="bi bi-pie-chart-fill fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">0%</span>
                    </div>
                    <div class="text-muted small fw-semibold">Room Occupancy</div>
                    <div class="fs-4 fw-bold text-dark my-1">0%</div>
                    <div class="text-muted small">0 Occupied / 0 Total</div>
                </div>
            </div>

            <!-- Card 3: Active Bookings -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-green-subtle text-success">
                            <i class="bi bi-calendar-check fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">Active</span>
                    </div>
                    <div class="text-muted small fw-semibold">Active Bookings</div>
                    <div class="fs-4 fw-bold text-dark my-1">0</div>
                    <div class="text-muted small">0 Pending</div>
                </div>
            </div>

            <!-- Card 4: Available Rooms -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-purple-subtle text-purple">
                            <i class="bi bi-door-open-fill fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">0 Ready</span>
                    </div>
                    <div class="text-muted small fw-semibold">Available Rooms</div>
                    <div class="fs-4 fw-bold text-dark my-1">0</div>
                    <div class="text-muted small">Out of 0 total</div>
                </div>
            </div>

            <!-- Card 5: Check-ins Today -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-blue-subtle text-info">
                            <i class="bi bi-box-arrow-in-right fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">Today</span>
                    </div>
                    <div class="text-muted small fw-semibold">Check-ins Today</div>
                    <div class="fs-4 fw-bold text-dark my-1">0</div>
                    <div class="text-muted small">0 Completed</div>
                </div>
            </div>

            <!-- Card 6: Check-outs Today -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-2">
                <div class="kpi-card bg-white p-3 rounded-4 shadow-sm h-100 border">
                    <div class="d-flex align-items-center justify-content-between mb-2">
                        <div class="kpi-icon-circle bg-amber-subtle text-danger">
                            <i class="bi bi-box-arrow-right fs-5"></i>
                        </div>
                        <span class="badge bg-light text-dark border">Today</span>
                    </div>
                    <div class="text-muted small fw-semibold">Check-outs Today</div>
                    <div class="fs-4 fw-bold text-dark my-1">0</div>
                    <div class="text-muted small">0 Pending</div>
                </div>
            </div>

        </div>

                    <div class="kpi-sub-detail text-muted small mb-2">
                        &#8377; 0.00 Today's Earnings
                    </div>

                    <div class="kpi-trend-pill text-muted small fw-semibold">
                        <i class="bi bi-dash fs-6"></i> 0.0% <span class="fw-normal text-muted">from last week</span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ==========================================
             3. CHARTS ROW: BOOKINGS OVERVIEW & ROOM STATUS
             ========================================== -->
        <div class="row g-3 g-xl-4 mb-4">

            <!-- Bookings Overview (Spline Area Chart) -->
            <div class="col-12 col-lg-7 col-xl-8">
                <div class="dashboard-card bg-white p-4 rounded-4 shadow-sm h-100">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-3">
                        <div>
                            <h5 class="card-heading fw-bold text-dark mb-0">Bookings Overview</h5>
                            <span class="text-muted small">Last 7 Days</span>
                        </div>

                        <div class="dropdown">
                            <button class="btn btn-filter-pill btn-sm d-flex align-items-center gap-2" type="button"
                                id="chartFilterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <span>This Week</span>
                                <i class="bi bi-chevron-down small"></i>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="chartFilterDropdown">
                                <li><a class="dropdown-item active" href="javascript:void(0)">This Week</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0)">Last Week</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0)">This Month</a></li>
                            </ul>
                        </div>
                    </div>

                    <!-- Canvas for Area Chart -->
                    <div class="chart-container-area position-relative" style="height: 240px;">
                        <canvas id="bookingsOverviewChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- Room Status (Doughnut Chart with Center Number) -->
            <div class="col-12 col-lg-5 col-xl-4">
                <div class="dashboard-card bg-white p-4 rounded-4 shadow-sm h-100">
                    <h5 class="card-heading fw-bold text-dark mb-3">Room Status</h5>

                    <div class="row align-items-center h-100 py-2">
                        <!-- Donut Graphic Column -->
                        <div class="col-7 position-relative">
                            <div style="height: 180px;" class="d-flex align-items-center justify-content-center">
                                <canvas id="roomStatusDonutChart"></canvas>
                            </div>
                            <!-- Centered Total Rooms Text -->
                            <div class="donut-center-metric text-center">
                                <div class="donut-number fw-bold text-dark">0</div>
                                <div class="donut-label text-muted">Total Rooms</div>
                            </div>
                        </div>

                        <!-- Legend Column -->
                        <div class="col-5">
                            <div class="donut-legend-wrap d-flex flex-column gap-3">
                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="d-flex align-items-center gap-2 small text-dark">
                                        <span class="legend-indicator bg-success"></span>
                                        Occupied
                                    </span>
                                    <span class="fw-bold text-dark small">0</span>
                                </div>

                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="d-flex align-items-center gap-2 small text-dark">
                                        <span class="legend-indicator bg-warning"></span>
                                        Available
                                    </span>
                                    <span class="fw-bold text-dark small">0</span>
                                </div>

                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="d-flex align-items-center gap-2 small text-dark">
                                        <span class="legend-indicator bg-danger"></span>
                                        Maintenance
                                    </span>
                                    <span class="fw-bold text-dark small">0</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

        </div>

        <!-- ==========================================
             4. BOTTOM ROW: RECENT BOOKINGS, QUICK ACTIONS, LATEST ACTIVITY
             ========================================== -->
        <div class="row g-3 g-xl-4 mb-4">

            <!-- Recent Bookings Table -->
            <div class="col-12 col-xl-5">
                <div class="dashboard-card bg-white p-4 rounded-4 shadow-sm h-100">
                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <h5 class="card-heading fw-bold text-dark mb-0">Recent Bookings</h5>
                        <a href="javascript:void(0)"
                            class="view-all-link small fw-semibold text-decoration-none d-flex align-items-center gap-1"
                            onclick="toggleDatabaseGuests()">
                            <span>View All</span> <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-dashboard align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="text-muted small fw-semibold">#</th>
                                    <th class="text-muted small fw-semibold">Guest Name</th>
                                    <th class="text-muted small fw-semibold">Room No.</th>
                                    <th class="text-muted small fw-semibold">Check In</th>
                                    <th class="text-muted small fw-semibold">Status</th>
                                    <th class="text-muted small fw-semibold text-center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2 opacity-50"></i>
                                        <div class="small fw-semibold text-dark mb-1">No Recent Bookings</div>
                                        <span class="text-muted small">New guest reservations will appear here
                                            automatically.</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Quick Actions (6 Colored Tile Cards: 2 cols x 3 rows) -->
            <div class="col-12 col-md-6 col-xl-4">
                <div class="dashboard-card bg-white p-4 rounded-4 shadow-sm h-100">
                    <h5 class="card-heading fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-lightning-charge-fill text-warning"></i> Quick Actions
                    </h5>

                    <div class="row g-3">
                        <div class="col-6">
                            <a href="javascript:void(0)"
                                class="action-tile tile-peach text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100"
                                onclick="triggerQuickAction('new-reservation')">
                                <div class="tile-icon mb-2"><i class="bi bi-calendar-plus fs-4"></i></div>
                                <span class="tile-title small fw-semibold">Add Booking</span>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="AddRoom.aspx"
                                class="action-tile tile-blue text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100">
                                <div class="tile-icon mb-2"><i class="bi bi-door-closed fs-4"></i></div>
                                <span class="tile-title small fw-semibold">Add Room</span>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="javascript:void(0)"
                                class="action-tile tile-purple text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100"
                                onclick="toggleDatabaseGuests()">
                                <div class="tile-icon mb-2"><i class="bi bi-people fs-4"></i></div>
                                <span class="tile-title small fw-semibold">Manage Guests</span>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="javascript:void(0)"
                                class="action-tile tile-green text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100"
                                onclick="triggerQuickAction('export-report')">
                                <div class="tile-icon mb-2"><i class="bi bi-bar-chart-line fs-4"></i></div>
                                <span class="tile-title small fw-semibold">View Reports</span>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="javascript:void(0)"
                                class="action-tile tile-pink text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100"
                                onclick="handleMenuClick('Settings')">
                                <div class="tile-icon mb-2"><i class="bi bi-gear fs-4"></i></div>
                                <span class="tile-title small fw-semibold">Settings</span>
                            </a>
                        </div>
                        <div class="col-6">
                            <a href="Login.aspx"
                                class="action-tile tile-slate text-decoration-none text-center p-3 rounded-3 d-flex flex-column align-items-center justify-content-center h-100">
                                <div class="tile-icon mb-2"><i class="bi bi-box-arrow-right fs-4"></i></div>
                                <span class="tile-title small fw-semibold">Logout</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Latest Activity Timeline -->
            <div class="col-12 col-md-6 col-xl-3">
                <div class="dashboard-card bg-white p-4 rounded-4 shadow-sm h-100">
                    <h5 class="card-heading fw-bold text-dark mb-3 d-flex align-items-center gap-2">
                        <i class="bi bi-clock-history text-dark"></i> Latest Activity
                    </h5>

                    <div class="timeline-activity-list position-relative">
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-clock-history fs-3 d-block mb-2 opacity-50"></i>
                            <div class="small fw-semibold text-dark mb-1">No Recent Activity</div>
                            <span class="text-muted small">Live front desk, booking, and check-in logs will stream
                                here.</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- ==========================================
             5. REGISTERED GUESTS (ASP.NET DATABASE GRIDVIEW)
             Retains gvUsers for Dashboard.aspx.cs DataBind
             ========================================== -->
        <div id="databaseGuestsPanel" class="dashboard-card bg-white p-4 rounded-4 shadow-sm mt-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-3">
                <div>
                    <h5 class="card-heading fw-bold text-dark mb-1 d-flex align-items-center gap-2">
                        <i class="bi bi-people-fill text-gold"></i> Registered Guests Directory (Database)
                    </h5>
                    <p class="text-muted small mb-0">Live records connected to Users table in SQL Server database.</p>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <input type="text" id="userSearchInput" class="form-control form-control-sm"
                        placeholder="Search guests..." onkeyup="filterRegisteredGuests()" style="max-width: 220px;" />
                </div>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-dashboard align-middle mb-0" GridLines="None"
                    EmptyDataText="No registered guests found in database.">
                    <Columns>
                        <asp:BoundField DataField="UserId" HeaderText="ID" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:TemplateField HeaderText="Guest Name" HeaderStyle-CssClass="text-muted small fw-semibold">
                            <ItemTemplate>
                                <span class="fw-semibold text-dark small">
                                    <%# Eval("FirstName") + " " + Eval("LastName") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Registered On"
                            DataFormatString="{0:dd-MMM-yyyy hh:mm tt}" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- ==========================================
             USER LOGINS DIRECTORY (DATABASE: LOGIN TABLE)
             Shows ONLY User Logins (Keval Admin Login Nahi)
             ========================================== -->
        <div id="databaseLoginsPanel" class="dashboard-card bg-white p-4 rounded-4 shadow-sm mt-4">
            <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-3">
                <div>
                    <h5 class="card-heading fw-bold text-dark mb-1 d-flex align-items-center gap-2">
                        <i class="bi bi-box-arrow-in-right text-success"></i> User Logins Directory (Database: Login Table)
                    </h5>
                    <p class="text-muted small mb-0">Live user login records connected to [Login] table in SQL Server database.</p>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <input type="text" id="loginSearchInput" class="form-control form-control-sm"
                        placeholder="Search user logins..." onkeyup="filterLoginDirectory()" style="max-width: 220px;" />
                </div>
            </div>

            <div class="table-responsive">
                <asp:GridView ID="gvLogins" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-dashboard align-middle mb-0" GridLines="None"
                    EmptyDataText="No user login records found in database.">
                    <Columns>
                        <asp:BoundField DataField="LoginId" HeaderText="Login ID" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="UserId" HeaderText="User ID" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="UserName" HeaderText="User Name" ItemStyle-CssClass="small fw-semibold text-dark"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:BoundField DataField="LoginTime" HeaderText="Login Date & Time"
                            DataFormatString="{0:dd-MMM-yyyy hh:mm:ss tt}" ItemStyle-CssClass="small text-muted"
                            HeaderStyle-CssClass="text-muted small fw-semibold" />
                        <asp:TemplateField HeaderText="Status" HeaderStyle-CssClass="text-muted small fw-semibold">
                            <ItemTemplate>
                                <span class="badge bg-success-subtle text-success border border-success-subtle py-1 px-2">
                                    <i class="bi bi-check-circle me-1"></i><%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <script src="js/dashboard.js"></script>

    </asp:Content>