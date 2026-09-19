<%@ Page Title="Enquiries | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Enquiries.aspx.cs" Inherits="Admin_Enquiries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Contact Enquiries Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    <div class="mb-4">
        <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Contact Messages & Enquiries</h2>
        <p class="text-muted small mb-0">View messages submitted via the Contact Us page.</p>
    </div>

    <div class="card border-0 shadow-sm rounded-4 bg-white p-4 text-center py-5">
        <i class="bi bi-envelope-open text-primary display-4 mb-3 d-block"></i>
        <h4 class="fw-bold text-dark">Contact Portal Sync Active</h4>
        <p class="text-muted small mb-4">No unread guest enquiries pending.</p>
        <div>
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('Enquiries', 'Checked for new messages.', 'bi-envelope text-gold')">
                <i class="bi bi-arrow-clockwise"></i> Refresh Inbox
            </button>
        </div>
    </div>
</asp:Content>
