<%@ Page Title="Guest Reviews | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Reviews.aspx.cs" Inherits="Admin_Reviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Guest Reviews Administration">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">
    <div class="mb-4">
        <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">Guest Reviews & Ratings</h2>
        <p class="text-muted small mb-0">Monitor guest feedback, ratings, and publish luxury testimonials.</p>
    </div>

    <div class="card border-0 shadow-sm rounded-4 bg-white p-4 text-center py-5">
        <i class="bi bi-star-fill text-warning display-4 mb-3 d-block"></i>
        <h4 class="fw-bold text-dark">Guest Rating Average: 4.9 / 5.0</h4>
        <p class="text-muted small mb-4">All guest feedback synchronized across public website pages.</p>
        <div>
            <button type="button" class="btn-admin-primary" onclick="showAdminToast('Reviews Sync', 'Guest testimonials updated live.', 'bi-check-circle text-success')">
                <i class="bi bi-arrow-repeat"></i> Synchronize Reviews
            </button>
        </div>
    </div>
</asp:Content>
