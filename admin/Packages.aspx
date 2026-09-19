<%@ Page Title="Packages | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Packages.aspx.cs" Inherits="Admin_Packages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Enhance Your Stay Add-on Packages Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Enhance Your Stay Packages</h2>
            <p class="text-muted small mb-0">Manage add-on guest services, dining packages, spa access, and luxury transfers.</p>
        </div>
        <div>
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('Add Package', 'Opening package builder...', 'bi-box-seam text-gold')">
                <i class="bi bi-plus-lg"></i> Add Package
            </button>
        </div>
    </div>

    <!-- Packages Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Package Name</th>
                        <th>Category</th>
                        <th>Inclusions & Description</th>
                        <th>Package Price</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="6" class="text-center text-muted py-5">
                            <i class="bi bi-box-seam fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Add-on Packages Added</h6>
                            <p class="small text-muted mb-0">Click "+ Add Package" to offer guest services.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
