<%@ Page Title="Delete Room | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="DeleteRoom.aspx.cs" Inherits="Admin_DeleteRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management Delete & Decommission Room Confirmation">
    <link rel="stylesheet" type="text/css" href="css/managehotel.css">
    <style>
        .delete-room-card {
            background: #ffffff;
            border-radius: 18px;
            border: 1px solid #fecaca;
            box-shadow: 0 10px 30px rgba(220, 38, 38, 0.08);
            overflow: hidden;
        }
        .delete-card-header-banner {
            background: linear-gradient(135deg, #b91c1c 0%, #dc2626 100%);
            color: #ffffff;
            padding: 24px 32px;
        }
        .delete-room-preview-box {
            background: #faf8f5;
            border: 1.5px solid #e8decb;
            border-radius: 14px;
            padding: 20px;
        }
        .delete-room-image {
            width: 160px;
            height: 110px;
            object-fit: cover;
            border-radius: 10px;
            border: 1.5px solid #cbd5e1;
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
        }
        .delete-badge-pill {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            font-size: 0.84rem;
            font-weight: 700;
            padding: 4px 14px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .spec-item {
            font-size: 0.88rem;
            color: #475569;
            margin-bottom: 6px;
        }
        .spec-item i {
            color: #9A724E;
            width: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Hidden Field for Room ID -->
    <asp:HiddenField ID="hdnRoomId" runat="server" Value="0" />

    <!-- Page Header & Navigation -->
    <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3 mb-4">
        <div>
            <div class="d-flex align-items-center gap-2 mb-1">
                <h2 class="fw-bold text-dark mb-0" style="font-family: 'Playfair Display', Georgia, serif;">
                    Delete Room Confirmation
                </h2>
                <span class="delete-badge-pill">
                    <i class="bi bi-hash"></i> Room #<span id="lblHeaderRoomId" runat="server">0</span>
                </span>
            </div>
            <p class="text-muted small mb-0">
                Review room specifications and database dependencies before confirming removal.
            </p>
        </div>
        <div>
            <a href="ManageHotel.aspx" class="btn btn-outline-secondary px-4 py-2 rounded-3 fw-semibold shadow-sm d-inline-flex align-items-center gap-2">
                <i class="bi bi-arrow-left"></i> Back to Hotel Inventory
            </a>
        </div>
    </div>

    <!-- Alert / Status Notification -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false">
        <div class="d-flex align-items-center gap-3">
            <i id="msgIcon" runat="server" class="bi bi-exclamation-triangle-fill fs-4"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold small"></asp:Label>
            </div>
        </div>
    </asp:Panel>

    <!-- Main Delete Card Form -->
    <div class="row justify-content-center">
        <div class="col-12 col-xl-9">

            <asp:Panel ID="pnlDeleteConfirm" runat="server" CssClass="delete-room-card mb-4">
                <!-- Card Header Banner -->
                <div class="delete-card-header-banner d-flex align-items-center gap-3">
                    <div class="d-flex align-items-center justify-content-center bg-white text-danger rounded-circle shadow-sm" style="width: 52px; height: 52px; min-width: 52px;">
                        <i class="bi bi-trash3-fill fs-4"></i>
                    </div>
                    <div>
                        <h4 class="fw-bold mb-1 text-white">
                            Are you sure you want to delete this room?
                        </h4>
                        <p class="mb-0 text-white-50 small">
                            This action will remove the room from the active guest booking inventory.
                        </p>
                    </div>
                </div>

                <!-- Card Body -->
                <div class="p-4 p-lg-5">

                    <!-- Room Snapshot Box -->
                    <div class="delete-room-preview-box mb-4">
                        <div class="d-flex flex-column flex-md-row gap-4 align-items-start">
                            <!-- Room Image -->
                            <div>
                                <asp:Image ID="imgRoomThumb" runat="server" CssClass="delete-room-image" AlternateText="Room Preview" />
                            </div>

                            <!-- Room Details -->
                            <div class="flex-grow-1">
                                <div class="d-flex flex-wrap align-items-center justify-content-between gap-2 mb-2">
                                    <h4 class="fw-bold text-dark mb-0" id="lblRoomName" runat="server">
                                        Executive Business Suite
                                    </h4>
                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2 rounded-pill fw-bold small" id="lblRoomCategory" runat="server">
                                        Executive
                                    </span>
                                </div>

                                <div class="row g-2 mb-3">
                                    <div class="col-12 col-sm-6 spec-item">
                                        <i class="bi bi-currency-rupee"></i> Tariff: <strong>&#8377; <span id="lblPrice" runat="server">8,500</span></strong> / night
                                    </div>
                                    <div class="col-12 col-sm-6 spec-item">
                                        <i class="bi bi-people-fill"></i> Occupancy: <span id="lblOccupancy" runat="server">3 Guests</span>
                                    </div>
                                    <div class="col-12 col-sm-6 spec-item">
                                        <i class="bi bi-aspect-ratio-fill"></i> Room Area: <span id="lblArea" runat="server">450 sq ft</span>
                                    </div>
                                    <div class="col-12 col-sm-6 spec-item">
                                        <i class="bi bi-compass-fill"></i> View Type: <span id="lblViewType" runat="server">Ocean View</span>
                                    </div>
                                </div>

                                <p class="text-muted small mb-0" id="lblShortDesc" runat="server">
                                    Luxury executive suite with ocean view, premium work desk and complimentary lounge access.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Safety Assessment: Booking History Check Callout -->
                    <asp:Panel ID="pnlBookingWarning" runat="server" Visible="false" CssClass="alert alert-warning border-warning d-flex align-items-start gap-3 p-3 rounded-4 mb-4">
                        <i class="bi bi-shield-exclamation text-warning fs-3 mt-1"></i>
                        <div>
                            <h6 class="fw-bold text-dark mb-1">
                                Existing Booking History Detected
                            </h6>
                            <p class="text-muted small mb-0">
                                This room is referenced in historical guest booking/reservation records. To prevent corrupting guest accounts or financial audits, confirming will <strong>safely deactivate</strong> this room (Soft Delete: <code>IsActive = 0</code>). Historical booking records will remain fully preserved, but the room will be immediately removed from active inventory.
                            </p>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlPermanentNotice" runat="server" Visible="true" CssClass="alert alert-danger border-danger-subtle d-flex align-items-start gap-3 p-3 rounded-4 mb-4" style="background-color: #fff8f8;">
                        <i class="bi bi-exclamation-octagon-fill text-danger fs-3 mt-1"></i>
                        <div>
                            <h6 class="fw-bold text-danger mb-1">
                                Permanent Delete Warning
                            </h6>
                            <p class="text-muted small mb-0">
                                No dependent bookings or reservations were found for this room. Confirming this action will <strong>permanently delete</strong> this room and all its specifications from the database. <strong>This action cannot be undone.</strong>
                            </p>
                        </div>
                    </asp:Panel>

                    <!-- Confirmation Action Buttons -->
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 pt-3 border-top">
                        <a href="ManageHotel.aspx" class="btn btn-light px-4 py-2 border rounded-3 fw-semibold text-secondary">
                            <i class="bi bi-x-circle me-1"></i> Cancel &amp; Keep Room
                        </a>

                        <div class="d-flex align-items-center gap-2">
                            <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete Room" CssClass="btn btn-danger px-4 py-2 rounded-3 fw-bold shadow-sm" OnClick="btnConfirmDelete_Click" />
                        </div>
                    </div>

                </div>
            </asp:Panel>

            <!-- Success State (Shown after deletion) -->
            <asp:Panel ID="pnlDeleteSuccess" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 p-5 text-center mb-4">
                <div class="mx-auto mb-3 d-flex align-items-center justify-content-center bg-success-subtle text-success rounded-circle" style="width: 72px; height: 72px;">
                    <i class="bi bi-check-circle-fill" style="font-size: 2.25rem;"></i>
                </div>
                <h3 class="fw-bold text-dark mb-2">Room Successfully Processed</h3>
                <p class="text-muted mb-4" id="lblSuccessMsgDetail" runat="server">
                    The room has been removed from active inventory.
                </p>
                <div>
                    <a href="ManageHotel.aspx" class="btn btn-dark px-4 py-2 rounded-3 fw-semibold">
                        <i class="bi bi-arrow-left me-1"></i> Return to Hotel Inventory
                    </a>
                </div>
            </asp:Panel>

        </div>
    </div>

</asp:Content>
