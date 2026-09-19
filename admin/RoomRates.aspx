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
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('Add Rate Plan', 'Opening rate plan configuration...', 'bi-tag text-gold')">
                <i class="bi bi-plus-lg"></i> Add Rate Plan
            </button>
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
                        <th class="ps-4">Room Variant</th>
                        <th>Rate Plan</th>
                        <th>Inclusions</th>
                        <th>Nightly Price</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="6" class="text-center text-muted py-5">
                            <i class="bi bi-tag fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Room Rates Configured</h6>
                            <p class="small text-muted mb-0">Click "+ Add Rate Plan" to set up tariffs.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function filterRatesTable() {
            var input = document.getElementById('ratesSearchInput').value.toLowerCase();
            var plan = document.getElementById('planFilterSelect').value.toLowerCase();
            var rows = document.querySelectorAll('#ratesTable tbody tr');

            rows.forEach(function (row) {
                var text = row.innerText.toLowerCase();
                var matchesSearch = text.includes(input);
                var matchesPlan = !plan || text.includes(plan);
                row.style.display = (matchesSearch && matchesPlan) ? '' : 'none';
            });
        }
    </script>
</asp:Content>
