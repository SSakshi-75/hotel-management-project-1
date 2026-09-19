<%@ Page Title="Settings | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Settings.aspx.cs" Inherits="Admin_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management System Configuration & Admin Profile">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    
    <!-- Page Header -->
    <div class="mb-4">
        <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">System Settings & Profile</h2>
        <p class="text-muted small mb-0">Configure general hotel information, currency, tax rates, and administrator profile.</p>
    </div>

    <div class="row g-4">
        <!-- Left: Hotel Settings Form -->
        <div class="col-12 col-lg-8">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <h5 class="fw-bold text-dark mb-3"><i class="bi bi-building text-gold me-2"></i> Hotel Profile Settings</h5>
                
                <div class="row g-3">
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Hotel Name</label>
                        <input type="text" class="form-control" value="Hotel Management Executive Portal">
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Contact Email</label>
                        <input type="email" class="form-control" value="admin@hotelmanagement.com">
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Phone Number</label>
                        <input type="text" class="form-control" value="+91 98765 43210">
                    </div>
                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-dark">Default Currency</label>
                        <input type="text" class="form-control" value="INR (₹)" readonly>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-semibold text-dark">Hotel Address</label>
                        <textarea class="form-control" rows="2">Luxury Boulevard, Resort Quarter, New Delhi, India</textarea>
                    </div>
                </div>

                <div class="mt-4 text-end">
                    <button type="button" class="btn-admin-primary" onclick="showAdminToast('Settings Saved', 'Hotel configuration updated successfully!', 'bi-check-circle text-success')">
                        <i class="bi bi-check-lg"></i> Save Changes
                    </button>
                </div>
            </div>
        </div>

        <!-- Right: Admin Profile Card -->
        <div class="col-12 col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white text-center">
                <div class="mx-auto mb-3 rounded-circle d-flex align-items-center justify-content-center text-white fw-bold fs-3" style="width: 80px; height: 80px; background-color: #442305;">
                    AS
                </div>
                <h5 class="fw-bold text-dark mb-0">Admin</h5>
                <p class="text-muted small">Super Administrator</p>
                <span class="badge bg-success-subtle text-success mx-auto mb-3 px-3 py-2 border">🟢 Active Session</span>
                <hr>
                <div class="text-start small text-muted">
                    <div class="mb-2"><strong>Role:</strong> Master Hotel Administrator</div>
                    <div class="mb-2"><strong>Last Login:</strong> Today, 12:36 PM</div>
                    <div><strong>Security:</strong> 2FA Authentication Enabled</div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
