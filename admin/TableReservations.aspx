<%@ Page Title="Table Reservations | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="TableReservations.aspx.cs" Inherits="Admin_TableReservations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Manage Table Reservations for The Royal Kitchen - Single Hotel Restaurant" />
    <style>
        .res-card-table {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(0,0,0,0.08);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            overflow: hidden;
        }
        .filter-pill-btn {
            border: 1px solid #cbd5e1;
            background: #ffffff;
            color: #475569;
            font-weight: 600;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            transition: all 0.2s ease;
        }
        .filter-pill-btn.active, .filter-pill-btn:hover {
            background: #442305;
            color: #ffffff;
            border-color: #442305;
        }
        .res-status-pending { background: #fef3c7; color: #92400e; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-confirmed { background: #dbeafe; color: #1e40af; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-seated { background: #e0e7ff; color: #3730a3; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-completed { background: #d1fae5; color: #065f46; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        .res-status-cancelled { background: #fee2e2; color: #991b1b; font-weight: 700; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; display: inline-flex; align-items: center; gap: 4px; }
        
        .kpi-res-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 16px 20px;
            border: 1px solid rgba(0,0,0,0.07);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            transition: transform 0.2s ease;
        }
        .kpi-res-card:hover {
            transform: translateY(-2px);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Floating 2-Second Confirmation Toast -->
    <div id="confirmationToast" style="display:none; position:fixed; top:28px; left:50%; transform:translate(-50%, -20px); z-index:999999; background:#198754; color:#ffffff; padding:12px 28px; border-radius:50px; box-shadow:0 8px 24px rgba(0,0,0,0.22); font-size:0.95rem; font-weight:600; align-items:center; gap:10px; pointer-events:none; transition:opacity 0.3s ease, transform 0.3s ease;">
        <i class="bi bi-check-circle-fill fs-5 text-white"></i>
        <span id="confirmationToastMsg">Updated successfully</span>
    </div>

    <!-- Header Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item text-muted">Dining &amp; Restaurant</li>
                    <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Table Reservations</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-1 text-dark" style="font-family: 'Playfair Display', Georgia, serif;">Table Reservations Dashboard</h2>
            <p class="text-muted small mb-0">Overview and status workflow of table reservations for <strong>The Royal Kitchen</strong>.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="../TableReservation.aspx" target="_blank" class="btn btn-outline-secondary px-3 py-2 rounded-3 fw-semibold small">
                <i class="bi bi-plus-circle me-1"></i> New Table Reservation
            </a>
            <a href="RestaurantTables.aspx" class="btn btn-dark px-3 py-2 rounded-3 fw-semibold small">
                <i class="bi bi-grid-3x3-gap me-1"></i> Manage Tables
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

    <!-- KPI STRIP -->
    <div class="row g-3 mb-4">
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">TOTAL</span>
                <h3 class="fw-bold text-dark mb-0 mt-1"><asp:Label ID="lblTotalCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">PENDING</span>
                <h3 class="fw-bold text-warning mb-0 mt-1"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">CONFIRMED</span>
                <h3 class="fw-bold text-primary mb-0 mt-1"><asp:Label ID="lblConfirmedCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">SEATED</span>
                <h3 class="fw-bold mb-0 mt-1" style="color: #4338ca;"><asp:Label ID="lblSeatedCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">COMPLETED</span>
                <h3 class="fw-bold text-success mb-0 mt-1"><asp:Label ID="lblCompletedCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
        <div class="col-6 col-lg-2">
            <div class="kpi-res-card">
                <span class="text-muted small font-monospace d-block">CANCELLED</span>
                <h3 class="fw-bold text-danger mb-0 mt-1"><asp:Label ID="lblCancelledCount" runat="server" Text="0"></asp:Label></h3>
            </div>
        </div>
    </div>

    <!-- FILTER BAR & SEARCH -->
    <div class="res-card-table p-3 mb-4">
        <div class="row g-3 align-items-center">
            
            <!-- Status Filter Pills -->
            <div class="col-12 col-lg-8 d-flex flex-wrap gap-2">
                <button type="button" class="filter-pill-btn active" onclick="filterResStatus('All', this)">All (<asp:Literal ID="litFilterAll" runat="server" Text="0" />)</button>
                <button type="button" class="filter-pill-btn" onclick="filterResStatus('Pending', this)">Pending (<asp:Literal ID="litFilterPending" runat="server" Text="0" />)</button>
                <button type="button" class="filter-pill-btn" onclick="filterResStatus('Confirmed', this)">Confirmed (<asp:Literal ID="litFilterConfirmed" runat="server" Text="0" />)</button>
                <button type="button" class="filter-pill-btn" onclick="filterResStatus('Seated', this)">Seated (<asp:Literal ID="litFilterSeated" runat="server" Text="0" />)</button>
                <button type="button" class="filter-pill-btn" onclick="filterResStatus('Completed', this)">Completed (<asp:Literal ID="litFilterCompleted" runat="server" Text="0" />)</button>
                <button type="button" class="filter-pill-btn" onclick="filterResStatus('Cancelled', this)">Cancelled (<asp:Literal ID="litFilterCancelled" runat="server" Text="0" />)</button>
            </div>

            <!-- Search Box -->
            <div class="col-12 col-lg-4">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="txtSearchReservation" class="form-control border-start-0 bg-light shadow-none"
                        placeholder="Search code, customer, phone, table..." onkeyup="searchReservationsTable();" />
                </div>
            </div>

        </div>
    </div>

    <!-- DATA TABLE -->
    <div class="res-card-table">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="tblReservations">
                <thead class="table-dark">
                    <tr>
                        <th>Booking Code</th>
                        <th>Customer Details</th>
                        <th>Date &amp; Time</th>
                        <th>Guests</th>
                        <th>Assigned Table</th>
                        <th>Status</th>
                        <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptReservations" runat="server" OnItemCommand="rptReservations_ItemCommand">
                        <ItemTemplate>
                            <tr data-status='<%# Eval("Status") %>'>
                                <td>
                                    <span class="font-monospace fw-bold text-primary"><%# Eval("BookingCode") %></span>
                                </td>
                                <td>
                                    <div class="fw-bold text-dark"><%# Eval("CustomerName") %></div>
                                    <small class="text-muted"><%# Eval("CustomerPhone") %><%# Eval("CustomerEmail") != DBNull.Value && !string.IsNullOrEmpty(Eval("CustomerEmail").ToString()) ? " &bull; " + Eval("CustomerEmail") : "" %></small>
                                </td>
                                <td>
                                    <div class="fw-semibold"><%# Eval("ReservationDate", "{0:dd MMM yyyy}") %></div>
                                    <small class="text-muted"><i class="bi bi-clock me-1"></i> <%# Eval("TimeSlot") %></small>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border"><%# Eval("GuestCount") %> Guests</span>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark">Table <%# Eval("TableNumber") %></span>
                                </td>
                                <td>
                                    <%# GetStatusBadge(Eval("Status") != null ? Eval("Status").ToString() : "") %>
                                </td>
                                <td class="text-center">
                                    <div class="d-inline-flex align-items-center gap-1">
                                        <asp:LinkButton ID="btnConfirm" runat="server" CssClass="btn btn-sm btn-success px-2 py-1 small"
                                            CommandName="ConfirmRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "pending" %>' ToolTip="Confirm Reservation">
                                            Confirm
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSeat" runat="server" CssClass="btn btn-sm btn-primary px-2 py-1 small"
                                            CommandName="SeatRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "confirmed" %>' ToolTip="Mark Seated">
                                            Mark Seated
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnComplete" runat="server" CssClass="btn btn-sm btn-success px-2 py-1 small"
                                            CommandName="CompleteRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "seated" %>' ToolTip="Complete Dining">
                                            Complete Dining
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-sm btn-outline-danger px-2 py-1 small"
                                            CommandName="CancelRes" CommandArgument='<%# Eval("ReservationId") %>'
                                            Visible='<%# Eval("Status").ToString().ToLower() == "pending" || Eval("Status").ToString().ToLower() == "confirmed" %>'
                                            OnClientClick="return confirm('Are you sure you want to cancel this reservation?');" ToolTip="Cancel Reservation">
                                            Cancel
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-outline-secondary px-2 py-1 small"
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
    <script type="text/javascript">
        function filterResStatus(status, btnElem) {
            var buttons = document.querySelectorAll('.filter-pill-btn');
            buttons.forEach(function (b) { b.classList.remove('active'); });
            if (btnElem) btnElem.classList.add('active');

            var rows = document.querySelectorAll('#tblReservations tbody tr[data-status]');
            rows.forEach(function (row) {
                var rowStatus = row.getAttribute('data-status');
                if (status === 'All' || rowStatus === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function searchReservationsTable() {
            var filter = document.getElementById('txtSearchReservation').value.toLowerCase().trim();
            var rows = document.querySelectorAll('#tblReservations tbody tr[data-status]');
            rows.forEach(function (row) {
                var text = row.textContent.toLowerCase();
                if (filter === '' || text.indexOf(filter) !== -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function showConfirmation(message) {
            var toast = document.getElementById('confirmationToast');
            var msgElem = document.getElementById('confirmationToastMsg');
            if (toast) {
                if (msgElem && message) msgElem.textContent = message;
                toast.style.display = 'flex';
                toast.style.opacity = '0';
                toast.style.transform = 'translate(-50%, -20px)';
                setTimeout(function () {
                    toast.style.opacity = '1';
                    toast.style.transform = 'translate(-50%, 0)';
                }, 10);
                setTimeout(function () {
                    toast.style.opacity = '0';
                    toast.style.transform = 'translate(-50%, -20px)';
                    setTimeout(function () {
                        toast.style.display = 'none';
                    }, 350);
                }, 2000);
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            var pnl = document.getElementById('<%= pnlStatusMsg.ClientID %>');
            if (pnl) {
                setTimeout(function () {
                    pnl.style.transition = 'opacity 0.4s ease';
                    pnl.style.opacity = '0';
                    setTimeout(function () {
                        pnl.style.display = 'none';
                    }, 400);
                }, 2000);
            }
        });
    </script>

</asp:Content>
