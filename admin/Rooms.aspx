<%@ Page Title="Rooms Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Rooms.aspx.cs" Inherits="Admin_Rooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Rooms Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Action Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Rooms Administration</h2>
            <p class="text-muted small mb-0">Manage all hotel room categories, pricing, availability status, and luxury suites.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="AddRoom.aspx" class="btn-admin-primary">
                <i class="bi bi-plus-lg"></i> Add New Room
            </a>
            <button type="button" class="btn-admin-secondary" onclick="showAdminToast('Export Data', 'Exporting rooms data to CSV...', 'bi-download text-primary')">
                <i class="bi bi-download"></i> Export
            </button>
        </div>
    </div>

    <!-- Search & Filter Bar -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="roomSearchInput" class="form-control border-start-0 bg-light" placeholder="Search room name or type..." onkeyup="filterRoomsTable()">
                </div>
            </div>
            <div class="col-6 col-md-3">
                <select class="form-select bg-light" id="statusFilterSelect" onchange="filterRoomsTable()">
                    <option value="">All Statuses</option>
                    <option value="Active">🟢 Active</option>
                    <option value="Inactive">⚪ Inactive</option>
                    <option value="Maintenance">🟠 Maintenance</option>
                </select>
            </div>
            <div class="col-6 col-md-4 text-end">
                <span class="text-muted small fw-semibold">Total Suites Registered: <strong>0 Rooms</strong></span>
            </div>
        </div>
    </div>

    <!-- Rooms Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="roomsTable">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th style="width: 80px;" class="ps-4">Image</th>
                        <th>Room Name</th>
                        <th>Type</th>
                        <th>Price / Night</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="6" class="text-center text-muted py-5">
                            <i class="bi bi-door-closed fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Rooms Registered Yet</h6>
                            <p class="small text-muted mb-3">Click on "+ Add New Room" to add a room, or "+ Add Room Details" to configure full room page specs.</p>
                            <div class="d-inline-flex gap-2">
                                <a href="AddRoom.aspx" class="btn-admin-primary btn-sm">
                                    <i class="bi bi-plus-lg"></i> Add New Room
                                </a>
                                <a href="ManageRoomDetails.aspx" class="btn-admin-secondary btn-sm">
                                    <i class="bi bi-sliders"></i> Add Room Details
                                </a>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterRoomsTable() {
            var input = document.getElementById('roomSearchInput').value.toLowerCase();
            var status = document.getElementById('statusFilterSelect').value.toLowerCase();
            var rows = document.querySelectorAll('#roomsTable tbody tr');

            rows.forEach(function (row) {
                var text = row.innerText.toLowerCase();
                var matchesSearch = text.includes(input);
                var matchesStatus = !status || text.includes(status);
                row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
            });
        }

        function confirmDeleteRoom(roomName) {
            if (confirm('Are you sure you want to delete "' + roomName + '"?')) {
                showAdminToast('Room Removed', roomName + ' deleted successfully.', 'bi-trash text-danger');
            }
        }
    </script>
</asp:Content>
