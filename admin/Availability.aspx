<%@ Page Title="Room Availability | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Availability.aspx.cs" Inherits="Admin_Availability" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Room Availability & Inventory Control">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Date Filter -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Room Availability & Inventory</h2>
            <p class="text-muted small mb-0">Track real-time room inventory, occupancy stats, and automated status indicators.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <label for="availDateInput" class="fw-semibold small text-dark mb-0 me-1">Date:</label>
            <input type="date" id="availDateInput" class="form-control form-control-sm bg-white border" value="2026-09-19" onchange="showAdminToast('Date Updated', 'Showing inventory for ' + this.value, 'bi-calendar3 text-primary')">
        </div>
    </div>

    <!-- Inventory Overview Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Room Category</th>
                        <th class="text-center">Total Inventory</th>
                        <th class="text-center">Booked Rooms</th>
                        <th class="text-center">Available Rooms</th>
                        <th>Occupancy Rate</th>
                        <th class="pe-4 text-end">Status</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="6" class="text-center text-muted py-5">
                            <i class="bi bi-calendar3 fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Inventory Records Available</h6>
                            <p class="small text-muted mb-0">Select a date or configure rooms to monitor real-time availability.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
