<%@ Page Title="Room Availability & Inventory | Executive Admin" Language="C#"
    MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Availability.aspx.cs"
    Inherits="Admin_Availability" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Hotel Management Room Availability & Inventory Control" />
        <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0" />
        <style>
            .btn-status-action {
                font-size: 0.76rem;
                padding: 5px 10px;
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

        <!-- Page Header & Action Bar matching ManageHotel -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1 manage-hotel-title">Room Availability &amp; Inventory</h2>
                <p class="text-muted small mb-0">Overview of room operational lifecycle, housekeeping &amp; maintenance, and real-time reservation schedules.</p>
            </div>
            <div class="d-flex align-items-center flex-wrap gap-2">
                <a href="../Room.aspx" target="_blank" class="btn-hotel-preview-site">
                    <i class="bi bi-globe2"></i> Live Guest Rooms <i class="bi bi-box-arrow-up-right small"></i>
                </a>
                <a href="ManageHotel.aspx" class="btn-hotel-add-room">
                    <i class="bi bi-door-open"></i> Manage Hotel &amp; Suites
                </a>
            </div>
        </div>

        <!-- Luxury KPI Cards matching ManageHotel -->
        <div class="row g-3 mb-4">
            <!-- Total Suites -->
            <div class="col-sm-6 col-xl">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Total Suites &amp; Rooms</span>
                            <div class="kpi-value mt-1">
                                <asp:Label ID="lblTotalSuites" runat="server" Text="0"></asp:Label>
                            </div>
                            <span class="text-muted small">Configured in Database</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-gold">
                            <i class="bi bi-buildings-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Available Suites -->
            <div class="col-sm-6 col-xl">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Available</span>
                            <div class="kpi-value mt-1 text-success">
                                <asp:Label ID="lblAvailableSuites" runat="server" Text="0"></asp:Label>
                            </div>
                            <span class="text-muted small">Ready for Guests</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-green">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Occupied Suites -->
            <div class="col-sm-6 col-xl">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Occupied (In-House)</span>
                            <div class="kpi-value mt-1 text-primary">
                                <asp:Label ID="lblOccupiedSuites" runat="server" Text="0"></asp:Label>
                            </div>
                            <span class="text-muted small">Checked-In Guests</span>
                        </div>
                        <div class="kpi-icon-wrap kpi-icon-blue">
                            <i class="bi bi-person-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cleaning -->
            <div class="col-sm-6 col-xl">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Cleaning</span>
                            <div class="kpi-value mt-1 text-warning">
                                <asp:Label ID="lblCleaningSuites" runat="server" Text="0"></asp:Label>
                            </div>
                            <span class="text-muted small">Housekeeping in Progress</span>
                        </div>
                        <div class="kpi-icon-wrap" style="background: #fefce8; color: #ca8a04; border: 1px solid #fef08a;">
                            <i class="bi bi-brush-fill"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Maintenance / Blocked -->
            <div class="col-sm-6 col-xl">
                <div class="hotel-kpi-card">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <span class="kpi-label">Maintenance / Blocked</span>
                            <div class="kpi-value mt-1 text-danger">
                                <asp:Label ID="lblMaintenanceSuites" runat="server" Text="0"></asp:Label>
                            </div>
                            <span class="text-muted small">Out of Service Hold</span>
                        </div>
                        <div class="kpi-icon-wrap" style="background: #fef2f2; color: #dc2626; border: 1px solid #fecaca;">
                            <i class="bi bi-tools"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Master Availability Card matching ManageHotel design -->
        <div class="manage-hotel-card">

            <!-- Header: Royal Brown / Gold Gradient Bar -->
            <div class="manage-hotel-header">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-door-open-fill text-warning fs-5"></i>
                    <h4 class="mb-0">Rooms &amp; Suites Availability &amp; Status Controls</h4>
                </div>
                <div>
                    <span class="header-count-pill">
                        <i class="bi bi-shield-check me-1"></i> Live Real-Time DB Sync
                    </span>
                </div>
            </div>

            <!-- Date Range Filter Toolbar matching ManageHotel -->
            <div class="manage-hotel-toolbar">
                <div class="row align-items-end g-3">
                    <div class="col-12 col-md-3">
                        <label class="form-label small fw-bold text-dark mb-1" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">
                            <i class="bi bi-calendar-event text-warning me-1"></i> Target Check-In
                        </label>
                        <asp:TextBox ID="txtCheckIn" runat="server" TextMode="Date" CssClass="form-control form-control-luxury-search" style="padding-left: 14px;"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-3">
                        <label class="form-label small fw-bold text-dark mb-1" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">
                            <i class="bi bi-calendar-check text-warning me-1"></i> Target Check-Out
                        </label>
                        <asp:TextBox ID="txtCheckOut" runat="server" TextMode="Date" CssClass="form-control form-control-luxury-search" style="padding-left: 14px;"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-4 d-flex gap-2">
                        <asp:Button ID="btnFilterDates" runat="server" Text="Inspect Date Range" CssClass="btn-hotel-add-room" style="padding: 9px 18px; font-size: 0.85rem;" OnClick="btnFilterDates_Click" />
                        <asp:Button ID="btnResetDates" runat="server" Text="Reset Dates" CssClass="filter-pill-btn" style="padding: 9px 18px; font-size: 0.85rem;" OnClick="btnResetDates_Click" />
                    </div>
                    <div class="col-12 col-md-2 text-md-end text-muted small">
                        <span class="d-inline-flex align-items-center gap-1"><i class="bi bi-arrow-repeat text-warning"></i> Real-time sync</span>
                    </div>
                </div>

                <asp:Panel ID="pnlDateSearchInfo" runat="server" Visible="false" CssClass="mt-3 pt-3 border-top text-primary small fw-semibold">
                    <i class="bi bi-search me-1"></i> <asp:Label ID="lblDateSearchInfo" runat="server"></asp:Label>
                </asp:Panel>
            </div>

            <!-- Table with explicit gridlines & matching typography -->
            <div class="table-responsive">
                <table class="table table-bordered table-hover hotel-rooms-table align-middle">
                    <thead>
                        <tr>
                            <th style="width: 80px;" class="text-center">Preview</th>
                            <th>Room &amp; Suite Details</th>
                            <th class="text-center">Category</th>
                            <th class="text-center">Tariff / Night</th>
                            <th class="text-center">Capacity</th>
                            <th class="text-center">Current Status</th>
                            <th class="text-center">Date Availability</th>
                            <th class="text-end pe-4">Lifecycle Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptRoomInventory" runat="server" OnItemCommand="rptRoomInventory_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td class="text-center">
                                        <div class="room-thumb-wrap mx-auto">
                                            <img src='<%# GetRoomThumbnail(Eval("PrimaryRoomImage")) %>'
                                                alt='<%# Eval("RoomName") %>' class="hotel-room-thumb">
                                        </div>
                                    </td>
                                    <td>
                                        <div class="room-name-heading">
                                            <%# Eval("RoomName") %>
                                        </div>
                                        <div class="room-specs-list">
                                            <span class="room-spec-item"><i class="bi bi-hash"></i> Room #<%# Eval("RoomID") %></span>
                                            <span class="room-spec-item"><i class="bi bi-aspect-ratio"></i> <%# FormatRoomArea(Eval("RoomArea")) %></span>
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <%# GetCategoryBadgeHtml(Eval("RoomCategory")) %>
                                    </td>
                                    <td class="text-center">
                                        <span class="hotel-tariff-amount">&#8377; <%# Eval("PricePerNight") %></span>
                                        <span class="hotel-tariff-period">per room / night</span>
                                    </td>
                                    <td class="text-center">
                                        <span class="small text-muted fw-semibold"><i class="bi bi-people me-1"></i>
                                            <%# FormatCapacity(Eval("MaxGuests")) %>
                                        </span>
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
                                            <asp:LinkButton ID="btnSetAvailable" runat="server" CommandName="SetStatus"
                                                CommandArgument='<%# Eval("RoomID") + ":Available" %>'
                                                CssClass="btn btn-outline-success btn-status-action"
                                                ToolTip="Mark as Available & Ready for Guests">
                                                <i class="bi bi-check-lg"></i> Available
                                            </asp:LinkButton>

                                            <!-- Set Cleaning -->
                                            <asp:LinkButton ID="btnSetCleaning" runat="server" CommandName="SetStatus"
                                                CommandArgument='<%# Eval("RoomID") + ":Cleaning" %>'
                                                CssClass="btn btn-outline-warning btn-status-action text-dark"
                                                ToolTip="Send to Housekeeping / Cleaning">
                                                <i class="bi bi-brush"></i> Cleaning
                                            </asp:LinkButton>

                                            <!-- Set Maintenance -->
                                            <asp:LinkButton ID="btnSetMaintenance" runat="server" CommandName="SetStatus"
                                                CommandArgument='<%# Eval("RoomID") + ":Maintenance" %>'
                                                CssClass="btn btn-outline-danger btn-status-action"
                                                ToolTip="Mark Under Maintenance">
                                                <i class="bi bi-tools"></i> Maint.
                                            </asp:LinkButton>

                                            <!-- Set Blocked -->
                                            <asp:LinkButton ID="btnSetBlocked" runat="server" CommandName="SetStatus"
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

            <!-- Card Bottom Bar matching ManageHotel -->
            <div class="p-3 bg-light border-top d-flex justify-content-between align-items-center small text-muted">
                <span>Room Operational Lifecycle &bull; Real-time status sync</span>
                <a href="Bookings.aspx" class="text-decoration-none fw-semibold" style="color: var(--hotel-brown);">View All Bookings &rarr;</a>
            </div>
        </div>

    </asp:Content>