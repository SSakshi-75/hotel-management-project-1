<%@ Page Title="Room Availability & Inventory | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Availability.aspx.cs" Inherits="Admin_Availability" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Room Availability & Inventory Control">
    <style>
        .kpi-stat-card {
            background: #ffffff;
            border: 1px solid #eef0f3;
            border-radius: 16px;
            padding: 20px;
            transition: all 0.25s ease;
        }
        .kpi-stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.06);
        }
        .kpi-icon-box {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
        .room-img-thumb {
            width: 56px;
            height: 44px;
            object-fit: cover;
            border-radius: 8px;
        }
        .btn-status-action {
            font-size: 0.75rem;
            padding: 4px 10px;
            border-radius: 6px;
            font-weight: 600;
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

    <!-- Page Header -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Room Availability &amp; Inventory</h2>
            <p class="text-muted small mb-0">Track real-time room operational status, view date-based booking conflicts, and manage housekeeping &amp; maintenance lifecycles.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="ManageHotel.aspx" class="btn btn-outline-secondary btn-sm rounded-pill px-3">
                <i class="bi bi-gear me-1"></i> Manage Rooms
            </a>
            <a href="Bookings.aspx" class="btn btn-dark btn-sm rounded-pill px-3">
                <i class="bi bi-journal-bookmark me-1"></i> View All Bookings
            </a>
        </div>
    </div>

    <!-- KPI Metric Cards -->
    <div class="row g-3 mb-4">
        <!-- Total Suites -->
        <div class="col-sm-6 col-xl">
            <div class="kpi-stat-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Total Suites</span>
                        <h3 class="fw-bold text-dark mb-0">
                            <asp:Label ID="lblTotalSuites" runat="server" Text="0"></asp:Label>
                        </h3>
                    </div>
                    <div class="kpi-icon-box bg-dark text-white">
                        <i class="bi bi-buildings"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Suites -->
        <div class="col-sm-6 col-xl">
            <div class="kpi-stat-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Available</span>
                        <h3 class="fw-bold text-success mb-0">
                            <asp:Label ID="lblAvailableSuites" runat="server" Text="0"></asp:Label>
                        </h3>
                    </div>
                    <div class="kpi-icon-box bg-success-subtle text-success">
                        <i class="bi bi-check-circle"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Occupied Suites -->
        <div class="col-sm-6 col-xl">
            <div class="kpi-stat-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Occupied (In-House)</span>
                        <h3 class="fw-bold text-primary mb-0">
                            <asp:Label ID="lblOccupiedSuites" runat="server" Text="0"></asp:Label>
                        </h3>
                    </div>
                    <div class="kpi-icon-box bg-primary-subtle text-primary">
                        <i class="bi bi-person-check"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cleaning / Housekeeping -->
        <div class="col-sm-6 col-xl">
            <div class="kpi-stat-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Cleaning</span>
                        <h3 class="fw-bold text-warning mb-0">
                            <asp:Label ID="lblCleaningSuites" runat="server" Text="0"></asp:Label>
                        </h3>
                    </div>
                    <div class="kpi-icon-box bg-warning-subtle text-warning">
                        <i class="bi bi-brush"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Maintenance / Blocked -->
        <div class="col-sm-6 col-xl">
            <div class="kpi-stat-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small text-uppercase fw-semibold d-block mb-1">Maintenance / Blocked</span>
                        <h3 class="fw-bold text-danger mb-0">
                            <asp:Label ID="lblMaintenanceSuites" runat="server" Text="0"></asp:Label>
                        </h3>
                    </div>
                    <div class="kpi-icon-box bg-danger-subtle text-danger">
                        <i class="bi bi-tools"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Date-Range Availability Simulation Filter -->
    <div class="card border-0 shadow-sm rounded-4 p-4 mb-4 bg-white">
        <div class="row align-items-end g-3">
            <div class="col-md-3">
                <label class="form-label small fw-semibold text-dark mb-1">
                    <i class="bi bi-calendar-event me-1 text-primary"></i> Target Check-In:
                </label>
                <asp:TextBox ID="txtCheckIn" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
            </div>
            <div class="col-md-3">
                <label class="form-label small fw-semibold text-dark mb-1">
                    <i class="bi bi-calendar-check me-1 text-primary"></i> Target Check-Out:
                </label>
                <asp:TextBox ID="txtCheckOut" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
            </div>
            <div class="col-md-4 d-flex gap-2">
                <asp:Button ID="btnFilterDates" runat="server" Text="Inspect Date Range" CssClass="btn btn-dark btn-sm px-3 fw-semibold" OnClick="btnFilterDates_Click" />
                <asp:Button ID="btnResetDates" runat="server" Text="Reset Dates" CssClass="btn btn-outline-secondary btn-sm px-3" OnClick="btnResetDates_Click" />
            </div>
            <div class="col-md-2 text-md-end text-muted small">
                <span class="d-block"><i class="bi bi-info-circle text-gold me-1"></i> Real-time DB sync</span>
            </div>
        </div>

        <asp:Panel ID="pnlDateSearchInfo" runat="server" Visible="false" CssClass="mt-3 pt-3 border-top text-primary small fw-semibold">
            <i class="bi bi-search me-1"></i> <asp:Label ID="lblDateSearchInfo" runat="server"></asp:Label>
        </asp:Panel>
    </div>

    <!-- Inventory & Operational Status Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <h6 class="fw-bold text-dark mb-0">
                <i class="bi bi-list-check me-2 text-gold"></i> Live Room Inventory &amp; Status Controls
            </h6>
            <span class="text-muted small">Updated in real-time</span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4" style="width: 80px;">Room #</th>
                        <th>Room Details</th>
                        <th>Category</th>
                        <th>Nightly Rate</th>
                        <th>Capacity</th>
                        <th class="text-center">Current Status</th>
                        <th class="text-center">Date Availability</th>
                        <th class="pe-4 text-end" style="min-width: 230px;">Lifecycle Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <asp:Repeater ID="rptRoomInventory" runat="server" OnItemCommand="rptRoomInventory_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td class="ps-4 fw-bold text-dark">
                                    #<%# Eval("RoomID") %>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <img src='<%# GetRoomThumbnail(Eval("PrimaryRoomImage")) %>' alt='<%# Eval("RoomName") %>' class="room-img-thumb border shadow-sm">
                                        <div>
                                            <div class="fw-bold text-dark"><%# Eval("RoomName") %></div>
                                            <div class="text-muted small"><%# Eval("RoomArea") ?? "35" %> sq m</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-light text-dark border"><%# Eval("RoomCategory") %></span>
                                </td>
                                <td>
                                    <span class="fw-bold text-dark">&#8377; <%# Eval("PricePerNight") %></span>
                                </td>
                                <td>
                                    <span class="small text-muted"><i class="bi bi-people me-1"></i> <%# Eval("MaxGuests") %></span>
                                </td>
                                <td class="text-center">
                                    <%# GetStatusBadgeHtml(Eval("RoomStatus")) %>
                                </td>
                                <td class="text-center">
                                    <%# GetDateAvailabilityBadgeHtml(Eval("OverlapBookingsCount"), Eval("RoomStatus")) %>
                                </td>
                                <td class="pe-4 text-end">
                                    <div class="btn-group btn-group-sm" role="group">
                                        <!-- Set Available -->
                                        <asp:LinkButton ID="btnSetAvailable" runat="server" 
                                            CommandName="SetStatus" 
                                            CommandArgument='<%# Eval("RoomID") + ":Available" %>'
                                            CssClass="btn btn-outline-success btn-status-action" 
                                            ToolTip="Mark as Available & Ready for Guests">
                                            <i class="bi bi-check-lg"></i> Available
                                        </asp:LinkButton>

                                        <!-- Set Cleaning -->
                                        <asp:LinkButton ID="btnSetCleaning" runat="server" 
                                            CommandName="SetStatus" 
                                            CommandArgument='<%# Eval("RoomID") + ":Cleaning" %>'
                                            CssClass="btn btn-outline-warning btn-status-action text-dark" 
                                            ToolTip="Send to Housekeeping / Cleaning">
                                            <i class="bi bi-brush"></i> Cleaning
                                        </asp:LinkButton>

                                        <!-- Set Maintenance -->
                                        <asp:LinkButton ID="btnSetMaintenance" runat="server" 
                                            CommandName="SetStatus" 
                                            CommandArgument='<%# Eval("RoomID") + ":Maintenance" %>'
                                            CssClass="btn btn-outline-danger btn-status-action" 
                                            ToolTip="Mark Under Maintenance">
                                            <i class="bi bi-tools"></i> Maint.
                                        </asp:LinkButton>

                                        <!-- Set Blocked -->
                                        <asp:LinkButton ID="btnSetBlocked" runat="server" 
                                            CommandName="SetStatus" 
                                            CommandArgument='<%# Eval("RoomID") + ":Blocked" %>'
                                            CssClass="btn btn-outline-dark btn-status-action" 
                                            ToolTip="Block Room (VIP / Admin Hold)">
                                            <i class="bi bi-slash-circle"></i> Block
                                        </asp:LinkButton>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
