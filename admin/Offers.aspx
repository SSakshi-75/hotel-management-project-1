<%@ Page Title="Offers Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Offers.aspx.cs" Inherits="Admin_Offers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Special Offers Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header & Actions -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Offers & Promotional Deals</h2>
            <p class="text-muted small mb-0">Create and manage special seasonal discounts, weekend promotions, and promo codes for guest bookings.</p>
        </div>
        <div>
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('Create Offer', 'Opening offer builder modal...', 'bi-gift text-gold')">
                <i class="bi bi-plus-lg"></i> Create Offer
            </button>
        </div>
    </div>

    <!-- Offers Table -->
    <div class="card border-0 shadow-sm rounded-4 bg-white overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-muted small text-uppercase">
                    <tr>
                        <th class="ps-4">Offer Name</th>
                        <th>Discount Value</th>
                        <th>Validity Period</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Actions</th>
                    </tr>
                </thead>
                <tbody class="border-top-0">
                    <tr>
                        <td colspan="5" class="text-center text-muted py-5">
                            <i class="bi bi-gift fs-1 opacity-50 d-block mb-2 text-gold"></i>
                            <h6 class="fw-bold text-dark mb-1">No Special Offers Created</h6>
                            <p class="small text-muted mb-0">Click "+ Create Offer" to set up promotional discounts.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
