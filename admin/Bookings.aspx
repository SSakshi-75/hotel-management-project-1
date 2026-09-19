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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Reservations &amp; Guest Stay Lifecycle</h2>
            <p class="text-muted small mb-0">Manage guest booking journey: Search Room &rarr; Booking &rarr; Payment &rarr; Check-In &rarr; Stay &rarr; Check-Out &rarr; Completed.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('New Reservation', 'Opening reservation wizard...', 'bi-calendar-plus text-gold')">
                <i class="bi bi-plus-lg"></i> New Booking
            </button>
            <button type="button" class="btn-admin-secondary" onclick="showAdminToast('Export Report', 'Exporting bookings ledger...', 'bi-download text-primary')">
                <i class="bi bi-download"></i> Export
            </button>
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
                    <div class="fw-bold text-dark small">Register / Login</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Customer Account</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 2 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">2</div>
                    <div class="fw-bold text-dark small">Search &amp; Select</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Room &amp; Suite</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 3 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">3</div>
                    <div class="fw-bold text-dark small">Dates &amp; Booking</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Check-in / Check-out</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 4 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2">
                    <div class="lifecycle-step-number mx-auto mb-1">4</div>
                    <div class="fw-bold text-dark small">Payment</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Booking Confirmed</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 5 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2 border-primary bg-primary-subtle">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-primary">5</div>
                    <div class="fw-bold text-primary small">CHECK-IN</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Guest Arrives</span>
                </div>
            </div>
            <div class="col-auto text-muted d-none d-md-block"><i class="bi bi-arrow-right fs-5 text-gold"></i></div>

            <!-- Step 6 -->
            <div class="col-md">
                <div class="lifecycle-step-card p-2 border-purple bg-purple-subtle">
                    <div class="lifecycle-step-number mx-auto mb-1 bg-purple" style="background:#6b21a8;">6</div>
                    <div class="fw-bold text-dark small">CHECK-OUT</div>
                    <span class="text-muted" style="font-size: 0.72rem;">Stay Completed</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Search & Filter Bar -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="bookingSearchInput" class="form-control border-start-0 bg-light" placeholder="Search by Booking ID, Guest name or Room..." onkeyup="filterBookingsTable()">
                </div>
            </div>
            <div class="col-6 col-md-4">
                <select class="form-select bg-light" id="bookingStatusSelect" onchange="filterBookingsTable()">
                    <option value="">All Lifecycle Statuses</option>
                    <option value="Confirmed">🟢 Confirmed (Awaiting Arrival)</option>
                    <option value="Checked-In">🔵 Checked-In (In-House Stay)</option>
                    <option value="Completed">🟣 Completed (Checked-Out)</option>
                    <option value="Cancelled">🔴 Cancelled</option>
                </select>
            </div>
            <div class="col-6 col-md-3 text-end">
                <span class="text-muted small fw-semibold">Active Bookings: <strong id="totalCountText">3 Guests</strong></span>
            </div>
        </div>
    </div>

    <!-- Bookings Table with Interactive Check-In / Check-Out Actions -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden mb-4">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="bookingsTable">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Booking ID</th>
                        <th>Guest Name</th>
                        <th>Room Reserved</th>
                        <th>Check-in &bull; Check-out</th>
                        <th>Amount</th>
                        <th>Stay Status</th>
                        <th class="text-end pe-4">Lifecycle Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <!-- Row 1: Confirmed -> Ready for Check-in -->
                    <tr id="bookingRow1">
                        <td class="ps-4">
                            <span class="fw-bold text-dark">#HTL-98421</span>
                            <div class="text-muted" style="font-size: 0.72rem;">Direct Reservation</div>
                        </td>
                        <td>
                            <div class="fw-bold text-dark">Vikramaditya Singh</div>
                            <div class="text-muted small">+91 98765 43210</div>
                        </td>
                        <td>
                            <span class="fw-semibold text-dark">Executive Business Suite</span>
                            <div class="text-muted small">Room #204</div>
                        </td>
                        <td>
                            <div class="small fw-semibold text-dark">19 Sep 2026 &rarr; 21 Sep 2026</div>
                            <div class="text-muted" style="font-size: 0.72rem;">2 Nights Stay</div>
                        </td>
                        <td>
                            <span class="fw-bold text-dark">&#8377; 17,000</span>
                            <div class="badge bg-success-subtle text-success border px-2 py-0.5 small" style="font-size: 0.68rem;">PAID ONLINE</div>
                        </td>
                        <td>
                            <span id="statusPill1" class="badge badge-status-confirmed px-3 py-1.5 rounded-pill font-monospace small">
                                🟢 CONFIRMED
                            </span>
                        </td>
                        <td class="text-end pe-4">
                            <div id="actionBtnWrap1" class="d-inline-flex gap-1">
                                <button type="button" class="btn btn-sm btn-primary px-3 rounded-pill fw-bold" onclick="processCheckIn(1, 'Vikramaditya Singh', 'Room #204')">
                                    <i class="bi bi-box-arrow-in-right me-1"></i> Check-In
                                </button>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 2: Checked-In -> Ready for Check-out -->
                    <tr id="bookingRow2">
                        <td class="ps-4">
                            <span class="fw-bold text-dark">#HTL-98418</span>
                            <div class="text-muted" style="font-size: 0.72rem;">Direct Reservation</div>
                        </td>
                        <td>
                            <div class="fw-bold text-dark">Marcus Vance</div>
                            <div class="text-muted small">marcus@enterprise.com</div>
                        </td>
                        <td>
                            <span class="fw-semibold text-dark">Royal Penthouse Haven</span>
                            <div class="text-muted small">Room #501</div>
                        </td>
                        <td>
                            <div class="small fw-semibold text-dark">18 Sep 2026 &rarr; 20 Sep 2026</div>
                            <div class="text-muted" style="font-size: 0.72rem;">In-House Stay</div>
                        </td>
                        <td>
                            <span class="fw-bold text-dark">&#8377; 37,000</span>
                            <div class="badge bg-success-subtle text-success border px-2 py-0.5 small" style="font-size: 0.68rem;">PAID ONLINE</div>
                        </td>
                        <td>
                            <span id="statusPill2" class="badge badge-status-checkedin px-3 py-1.5 rounded-pill font-monospace small">
                                🔵 CHECKED-IN (In-House)
                            </span>
                        </td>
                        <td class="text-end pe-4">
                            <div id="actionBtnWrap2" class="d-inline-flex gap-1">
                                <button type="button" class="btn btn-sm btn-purple text-white px-3 rounded-pill fw-bold" style="background: #6b21a8;" onclick="processCheckOut(2, 'Marcus Vance', 'Room #501')">
                                    <i class="bi bi-box-arrow-right me-1"></i> Check-Out
                                </button>
                            </div>
                        </td>
                    </tr>

                    <!-- Row 3: Completed Stay -->
                    <tr id="bookingRow3">
                        <td class="ps-4">
                            <span class="fw-bold text-dark">#HTL-98410</span>
                            <div class="text-muted" style="font-size: 0.72rem;">Direct Reservation</div>
                        </td>
                        <td>
                            <div class="fw-bold text-dark">Ananya Sharma</div>
                            <div class="text-muted small">+91 98123 45678</div>
                        </td>
                        <td>
                            <span class="fw-semibold text-dark">Garden View Deluxe Room</span>
                            <div class="text-muted small">Room #108</div>
                        </td>
                        <td>
                            <div class="small fw-semibold text-dark">16 Sep 2026 &rarr; 18 Sep 2026</div>
                            <div class="text-muted" style="font-size: 0.72rem;">Completed Stay</div>
                        </td>
                        <td>
                            <span class="fw-bold text-dark">&#8377; 13,600</span>
                            <div class="badge bg-secondary-subtle text-secondary border px-2 py-0.5 small" style="font-size: 0.68rem;">FOLIO CLOSED</div>
                        </td>
                        <td>
                            <span id="statusPill3" class="badge badge-status-completed px-3 py-1.5 rounded-pill font-monospace small">
                                🟣 BOOKING COMPLETED
                            </span>
                        </td>
                        <td class="text-end pe-4">
                            <span class="text-muted small fw-semibold"><i class="bi bi-check-circle-fill text-success me-1"></i> Stay Finished</span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterBookingsTable() {
            var input = document.getElementById('bookingSearchInput').value.toLowerCase();
            var status = document.getElementById('bookingStatusSelect').value.toLowerCase();
            var rows = document.querySelectorAll('#bookingsTable tbody tr');
            var count = 0;

            rows.forEach(function (row) {
                var text = row.innerText.toLowerCase();
                var matchesSearch = !input || text.includes(input);
                var matchesStatus = !status || text.includes(status);
                if (matchesSearch && matchesStatus) {
                    row.style.display = '';
                    count++;
                } else {
                    row.style.display = 'none';
                }
            });

            var countElem = document.getElementById('totalCountText');
            if (countElem) countElem.innerText = count + ' Bookings';
        }

        function processCheckIn(rowId, guestName, roomNum) {
            var pill = document.getElementById('statusPill' + rowId);
            var wrap = document.getElementById('actionBtnWrap' + rowId);

            if (pill) {
                pill.className = 'badge badge-status-checkedin px-3 py-1.5 rounded-pill font-monospace small';
                pill.innerHTML = '🔵 CHECKED-IN (In-House)';
            }

            if (wrap) {
                wrap.innerHTML = `
                    <button type="button" class="btn btn-sm text-white px-3 rounded-pill fw-bold" style="background: #6b21a8;" onclick="processCheckOut(${rowId}, '${guestName}', '${roomNum}')">
                        <i class="bi bi-box-arrow-right me-1"></i> Check-Out
                    </button>
                `;
            }

            if (window.showAdminToast) {
                window.showAdminToast(
                    'Guest Checked-In!',
                    guestName + ' checked into ' + roomNum + '. Digital Key Issued.',
                    'bi-door-open-fill text-primary'
                );
            }
        }

        function processCheckOut(rowId, guestName, roomNum) {
            var pill = document.getElementById('statusPill' + rowId);
            var wrap = document.getElementById('actionBtnWrap' + rowId);

            if (pill) {
                pill.className = 'badge badge-status-completed px-3 py-1.5 rounded-pill font-monospace small';
                pill.innerHTML = '🟣 BOOKING COMPLETED';
            }

            if (wrap) {
                wrap.innerHTML = '<span class="text-muted small fw-semibold"><i class="bi bi-check-circle-fill text-success me-1"></i> Stay Finished</span>';
            }

            if (window.showAdminToast) {
                window.showAdminToast(
                    'Booking Completed!',
                    guestName + ' checked out of ' + roomNum + '. Invoice archived & review invitation sent.',
                    'bi-check-circle-fill text-success'
                );
            }
        }
    </script>
</asp:Content>
