<%@ Page Title="Restaurant Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="RestaurantManagement.aspx.cs" Inherits="Admin_RestaurantManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Single Hotel Restaurant Details & Status Management" />
    <style>
        .rest-card-box {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(0,0,0,0.08);
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            overflow: hidden;
        }
        .rest-card-header {
            background: linear-gradient(135deg, #442305 0%, #2a1401 100%);
            color: #ffffff;
            padding: 20px 24px;
            border-bottom: 2px solid #B88E68;
        }
        .rest-status-badge {
            font-size: 0.85rem;
            padding: 6px 14px;
            border-radius: 30px;
            font-weight: 700;
        }
        .kpi-rest-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 20px;
            border: 1px solid rgba(0,0,0,0.07);
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            transition: transform 0.2s ease;
        }
        .kpi-rest-card:hover {
            transform: translateY(-3px);
        }
        .btn-gold-save {
            background: linear-gradient(135deg, #442305 0%, #783d09 100%);
            color: #ffffff;
            border: none;
            padding: 12px 32px;
            border-radius: 10px;
            font-weight: 700;
            box-shadow: 0 4px 12px rgba(68, 35, 5, 0.2);
        }
        .btn-gold-save:hover {
            background: linear-gradient(135deg, #B88E68 0%, #442305 100%);
            color: #ffffff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Header & Breadcrumbs -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <nav aria-label="breadcrumb" class="mb-1">
                <ol class="breadcrumb small text-muted mb-0">
                    <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                    <li class="breadcrumb-item text-muted">Dining &amp; Restaurant</li>
                    <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Restaurant Management</li>
                </ol>
            </nav>
            <h2 class="fw-bold mb-1 text-dark" style="font-family: 'Playfair Display', Georgia, serif;">Single Restaurant Management</h2>
            <p class="text-muted small mb-0">Manage daily meal hours, timing slots, and dining experiences for <strong>The Royal Kitchen</strong>.</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="../TableReservation.aspx" target="_blank" class="btn btn-outline-secondary px-3 py-2 rounded-3 fw-semibold small">
                <i class="bi bi-globe2 me-1"></i> Live Reservation Page
            </a>
            <a href="RestaurantTables.aspx" class="btn btn-dark px-3 py-2 rounded-3 fw-semibold small">
                <i class="bi bi-grid-3x3-gap me-1"></i> Manage Tables
            </a>
        </div>
    </div>

    <!-- 2-Second Confirmation Toast -->
    <div id="confirmationToast" style="display:none; position:fixed; top:28px; left:50%; transform:translate(-50%, -20px); z-index:999999; background:#198754; color:#ffffff; padding:12px 28px; border-radius:50px; box-shadow:0 8px 24px rgba(0,0,0,0.22); font-size:0.95rem; font-weight:600; align-items:center; gap:10px; pointer-events:none; transition:opacity 0.3s ease, transform 0.3s ease;">
        <i class="bi bi-check-circle-fill fs-5 text-white"></i>
        <span id="confirmationToastMsg">Updated successfully</span>
    </div>

    <!-- Alert / Toast Messages -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false"
        CssClass="alert alert-success alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-check-circle-fill fs-4 text-success"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>
    <!-- Daily Meal Schedule & Experiences Management Form -->
    <div class="rest-card-box">
        <div class="rest-card-header d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-clock-history fs-4 text-warning"></i>
                <div>
                    <h4 class="mb-0 fw-bold text-white">Daily Meal Hours &amp; Experiences Schedule</h4>
                    <small class="text-white-50">Manage meal timing slots, descriptions, and venues displayed on the public Dining page</small>
                </div>
            </div>
            <div>
                <span class="badge bg-gold text-dark px-3 py-2 rounded-pill fw-bold" style="background-color: #B88E68; color: #ffffff;">
                    <i class="bi bi-calendar4-week me-1"></i> Live Schedule
                </span>
            </div>
        </div>

        <div class="p-4">
            
            <!-- 4 Meal Slots Grid -->
            <div class="row g-4">
                
                <!-- 1. Royal Breakfast -->
                <div class="col-lg-6">
                    <div class="p-3 border rounded-3 bg-light">
                        <div class="d-flex align-items-center gap-2 mb-3 text-dark fw-bold border-bottom pb-2">
                            <i class="bi bi-cup-hot-fill text-warning fs-5"></i> 1. Breakfast Slot
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Meal Title</label>
                                <asp:TextBox ID="txtBreakfastTitle" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. Royal Breakfast"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Timing Slot</label>
                                <asp:TextBox ID="txtBreakfastTime" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 07:00 AM - 10:30 AM"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Description</label>
                                <asp:TextBox ID="txtBreakfastDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-sm" placeholder="Breakfast description..."></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Venue Location</label>
                                <asp:TextBox ID="txtBreakfastVenue" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. The Royal Kitchen"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 2. Imperial Lunch -->
                <div class="col-lg-6">
                    <div class="p-3 border rounded-3 bg-light">
                        <div class="d-flex align-items-center gap-2 mb-3 text-dark fw-bold border-bottom pb-2">
                            <i class="bi bi-sun-fill text-warning fs-5"></i> 2. Lunch Slot
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Meal Title</label>
                                <asp:TextBox ID="txtLunchTitle" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. Imperial Lunch"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Timing Slot</label>
                                <asp:TextBox ID="txtLunchTime" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 12:30 PM - 03:30 PM"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Description</label>
                                <asp:TextBox ID="txtLunchDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-sm" placeholder="Lunch description..."></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Venue Location</label>
                                <asp:TextBox ID="txtLunchVenue" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. The Royal Kitchen"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 3. Royal High Tea -->
                <div class="col-lg-6">
                    <div class="p-3 border rounded-3 bg-light">
                        <div class="d-flex align-items-center gap-2 mb-3 text-dark fw-bold border-bottom pb-2">
                            <i class="bi bi-flower2 text-warning fs-5"></i> 3. High Tea Slot
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Meal Title</label>
                                <asp:TextBox ID="txtHighTeaTitle" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. Royal High Tea"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Timing Slot</label>
                                <asp:TextBox ID="txtHighTeaTime" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 04:00 PM - 06:30 PM"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Description</label>
                                <asp:TextBox ID="txtHighTeaDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-sm" placeholder="High tea description..."></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Venue Location</label>
                                <asp:TextBox ID="txtHighTeaVenue" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. The Royal Kitchen"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 4. Grand Dinner -->
                <div class="col-lg-6">
                    <div class="p-3 border rounded-3 bg-light">
                        <div class="d-flex align-items-center gap-2 mb-3 text-dark fw-bold border-bottom pb-2">
                            <i class="bi bi-moon-stars-fill text-warning fs-5"></i> 4. Dinner Slot
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Meal Title</label>
                                <asp:TextBox ID="txtDinnerTitle" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. Grand Dinner"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label small fw-semibold text-dark">Timing Slot</label>
                                <asp:TextBox ID="txtDinnerTime" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. 07:00 PM - 11:30 PM"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Description</label>
                                <asp:TextBox ID="txtDinnerDesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-sm" placeholder="Dinner description..."></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label small fw-semibold text-dark">Venue Location</label>
                                <asp:TextBox ID="txtDinnerVenue" runat="server" CssClass="form-control form-control-sm" placeholder="e.g. All Venues Open"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Action Buttons -->
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between gap-3 pt-4 mt-4 border-top">
                <span class="text-muted small text-center"><i class="bi bi-info-circle me-1 text-primary"></i> Saves Dining Schedule &amp; Experience Timings</span>
                <asp:Button ID="btnSaveMealSchedule" runat="server" Text="Save Meal Hours &amp; Schedule"
                    CssClass="btn btn-gold-save" OnClick="btnSaveMealSchedule_Click" />
            </div>

        </div>
    </div>

    <!-- Live Meal Schedules Display Repeater Card -->
    <div class="rest-card-box mt-4">
        <div class="rest-card-header d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-list-stars fs-4 text-warning"></i>
                <div>
                    <h4 class="mb-0 fw-bold text-white">Live Meal Schedules Preview &amp; Records</h4>
                    <small class="text-white-50">Active meal experiences as displayed on live guest portal</small>
                </div>
            </div>
            <div>
                <span class="badge bg-success text-white px-3 py-2 rounded-pill fw-bold">
                    <i class="bi bi-check-circle-fill me-1"></i> Data Bound Repeater
                </span>
            </div>
        </div>

        <div class="p-4">
            <div class="row g-4">
                <asp:Repeater ID="rptMealSchedules" runat="server" OnItemCommand="rptMealSchedules_ItemCommand">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-6">
                            <div class="p-3 border rounded-3 bg-white h-100 shadow-sm d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <span class="badge text-dark font-monospace" style="background-color: #B88E68; color: #ffffff;">
                                            <i class='<%# Eval("MealIcon") != DBNull.Value && !string.IsNullOrEmpty(Eval("MealIcon").ToString()) ? Eval("MealIcon") : "bi bi-clock-history" %> me-1'></i>
                                            <%# Eval("MealType") %>
                                        </span>
                                        <small class="text-muted font-monospace">ID: #<%# Eval("MealId") %></small>
                                    </div>
                                    <h5 class="fw-bold text-dark mb-2" style="font-family: 'Playfair Display', Georgia, serif;">
                                        <%# Eval("MealTitle") %>
                                    </h5>
                                    <div class="badge bg-light text-dark border mb-3 text-wrap text-start w-100 py-2 px-2 fw-semibold">
                                        <i class="bi bi-clock me-1 text-warning"></i> <%# Eval("TimeSlot") %>
                                    </div>
                                    <p class="text-muted small mb-3 leading-relaxed">
                                        <%# Eval("Description") %>
                                    </p>
                                </div>
                                <div class="pt-3 border-top mt-auto d-flex align-items-center justify-content-between flex-wrap gap-2">
                                    <span class="small text-muted fw-semibold text-truncate" style="max-width: 120px;" title='<%# Eval("VenuLocation") %>'>
                                        <i class="bi bi-geo-alt me-1 text-warning"></i> <%# Eval("VenuLocation") %>
                                    </span>
                                    <div class="d-flex align-items-center gap-1">
                                        <asp:LinkButton ID="btnEditMeal" runat="server" CssClass="btn btn-sm btn-outline-primary py-1 px-2"
                                            CommandName="EditMeal" CommandArgument='<%# Eval("MealId") %>' ToolTip="Edit in form above">
                                            <i class="bi bi-pencil-square"></i> Edit
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDeleteMeal" runat="server" CssClass="btn btn-sm btn-outline-danger py-1 px-2"
                                            CommandName="DeleteMeal" CommandArgument='<%# Eval("MealId") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this meal schedule record?');" ToolTip="Delete this record">
                                            <i class="bi bi-trash"></i> Delete
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>

    <!-- Confirmation Toast & Auto-Dismiss Script (2 Seconds) -->
    <script src="js/restaurantmanagement.js"></script>
</asp:Content>
