<%@ Page Title="Registered Customers | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Admin_Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Registered Customers Directory">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Registered Customers Directory</h2>
            <p class="text-muted small mb-0">Manage guest accounts, view reservation histories, and control login status.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <button type="button" class="btn-admin-secondary" onclick="showAdminToast('Export Users', 'Exporting customer directory to CSV...', 'bi-download text-primary')">
                <i class="bi bi-download"></i> Export Users
            </button>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-6">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" id="userSearchInput" class="form-control border-start-0 bg-light" placeholder="Search by name, email or phone..." onkeyup="filterUsersTable()">
                </div>
            </div>
            <div class="col-6 col-md-3">
                <select class="form-select bg-light" id="userStatusSelect" onchange="filterUsersTable()">
                    <option value="">All Statuses</option>
                    <option value="Active">🟢 Active</option>
                    <option value="Blocked">🔴 Blocked</option>
                </select>
            </div>
            <div class="col-6 col-md-3 text-end">
                <span class="text-muted small fw-semibold">Total Guests: <strong>0 Users</strong></span>
            </div>
        </div>
    </div>

    <!-- Users Table (NO PASSWORDS SHOWN) -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="usersTable">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">User ID</th>
                        <th>Guest Name</th>
                        <th>Email Address</th>
                        <th>Phone Number</th>
                        <th>Registered Date</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="7" class="text-center text-muted py-5">
                            <i class="bi bi-people fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Registered Customers Found</h6>
                            <p class="small text-muted mb-0">Registered guest accounts will appear here automatically.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterUsersTable() {
            var input = document.getElementById('userSearchInput').value.toLowerCase();
            var status = document.getElementById('userStatusSelect').value.toLowerCase();
            var rows = document.querySelectorAll('#usersTable tbody tr');

            rows.forEach(function (row) {
                var text = row.innerText.toLowerCase();
                var matchesSearch = text.includes(input);
                var matchesStatus = !status || text.includes(status);
                row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
            });
        }
    </script>
</asp:Content>
