<%@ Page Title="Room Rates | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="RoomRates.aspx.cs" Inherits="Admin_RoomRates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Room Rates Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Room Rates Management</h2>
            <p class="text-muted small mb-0">Manage rate plans, occupancy pricing, seasonal tariffs, and room-only vs breakfast packages.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="AddRoom.aspx" class="btn-admin-primary">
                <i class="bi bi-plus-lg"></i> Add Room Rate
            </a>
            <button type="button" class="btn-admin-secondary" onclick="showAdminToast('Filter Rates', 'Filtering active rate matrices...', 'bi-funnel text-primary')">
                <i class="bi bi-funnel"></i> Filter
            </button>
        </div>
    </div>

    <!-- Search & Filter Bar -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="ratesSearchInput" class="form-control border-start-0 bg-light" placeholder="Search room or rate plan..." onkeyup="filterRatesTable()">
                </div>
            </div>
            <div class="col-6 col-md-3">
                <select class="form-select bg-light" id="planFilterSelect" onchange="filterRatesTable()">
                    <option value="">All Rate Plans</option>
                    <option value="Room Only">Room Only</option>
                    <option value="Standard Rate">Standard Rate</option>
                </select>
            </div>
            <div class="col-6 col-md-3 text-end">
                <span class="text-muted small fw-semibold">Active Tariffs: <strong>0 Plans</strong></span>
            </div>
        </div>
    </div>

    <!-- Room Rates Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="ratesTable">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Room</th>
                        <th>Category</th>
                        <th>Base Rate</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <asp:Repeater ID="rptRoomRates" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td class="ps-4 fw-semibold text-dark"><%# Eval("RoomName") %></td>
                                <td><span class="badge bg-light text-secondary border border-secondary-subtle rounded-pill px-3 py-2"><%# Eval("RoomCategory") %></span></td>
                                <td class="fw-bold text-dark fs-6">&#8377;<%# Convert.ToDecimal(Eval("PricePerNight")).ToString("N0") %></td>
                                <td><%# GetStatusBadge(Eval("IsActive")) %></td>
                                <td class="text-end pe-4">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="EditRoom.aspx?id=<%# Eval("RoomID") %>" class="btn btn-sm btn-outline-primary rounded-pill px-3 shadow-sm d-flex align-items-center gap-1"><i class="bi bi-pencil-square"></i> Edit</a>
                                        <a href="../RoomDetails.aspx?id=<%# Eval("RoomID") %>" class="btn btn-sm btn-outline-secondary rounded-pill px-3 shadow-sm d-flex align-items-center gap-1" target="_blank"><i class="bi bi-eye"></i> View</a>
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <% if (rptRoomRates.Items.Count == 0) { %>
                    <tr>
                        <td colspan="5" class="text-center text-muted py-5">
                            <i class="bi bi-tag fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Room Rates Configured</h6>
                            <p class="small text-muted mb-0">Click "Add Room Rate" to set up tariffs.</p>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="js/roomrates.js"></script>
</asp:Content>
