<%@ Page Title="Restaurant Tables Management | Executive Admin" Language="C#"
    MasterPageFile="~/admin/AdminMaster.master" AutoEventWireup="true" CodeFile="RestaurantTables.aspx.cs"
    Inherits="Admin_RestaurantTables" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
        <meta name="description" content="Restaurant Tables Management - The Royal Kitchen" />
        <style>
            .rest-card-box {
                background: #ffffff;
                border-radius: 16px;
                border: 1px solid rgba(0, 0, 0, 0.08);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                overflow: hidden;
            }

            .rest-card-header {
                background: linear-gradient(135deg, #442305 0%, #2a1401 100%);
                color: #ffffff;
                padding: 18px 24px;
                border-bottom: 2px solid #B88E68;
            }

            .kpi-table-card {
                background: #ffffff;
                border-radius: 14px;
                padding: 18px 20px;
                border: 1px solid rgba(0, 0, 0, 0.07);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
                transition: transform 0.2s ease;
            }

            .kpi-table-card:hover {
                transform: translateY(-2px);
            }

            .btn-gold-save {
                background: linear-gradient(135deg, #442305 0%, #783d09 100%);
                color: #ffffff;
                border: none;
                padding: 10px 28px;
                border-radius: 10px;
                font-weight: 700;
                box-shadow: 0 4px 12px rgba(68, 35, 5, 0.2);
                transition: all 0.2s ease;
            }

            .btn-gold-save:hover {
                background: linear-gradient(135deg, #B88E68 0%, #442305 100%);
                color: #ffffff;
            }

            .table-num-pill {
                display: inline-block;
                background: #442305;
                color: #ffffff;
                font-weight: 700;
                padding: 4px 12px;
                border-radius: 8px;
                font-family: 'Playfair Display', Georgia, serif;
                letter-spacing: 0.5px;
            }

            .status-badge-available {
                background-color: #d1fae5;
                color: #065f46;
                font-weight: 600;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.82rem;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .status-badge-booked {
                background-color: #fee2e2;
                color: #991b1b;
                font-weight: 600;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.82rem;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .status-badge-reserved {
                background-color: #fef3c7;
                color: #92400e;
                font-weight: 600;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.82rem;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .status-badge-blocked {
                background-color: #fee2e2;
                color: #991b1b;
                font-weight: 600;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.82rem;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .table-admin-custom th {
                background-color: #f8fafc;
                color: #334155;
                font-weight: 700;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-bottom: 2px solid #e2e8f0;
                padding: 14px 16px;
            }

            .table-admin-custom td {
                padding: 14px 16px;
                vertical-align: middle;
                border-bottom: 1px solid #f1f5f9;
                font-size: 0.92rem;
            }

            .table-admin-custom tr:hover td {
                background-color: #fcfbf9;
            }
            .kpi-table-card .rounded-circle {
                width: 50px;
                height: 50px;
                padding: 0 !important;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-shrink: 0;
            }
            .kpi-table-card .rounded-circle i {
                font-size: 1.4rem;
            }
        </style>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

        <!-- Floating 2-Second Confirmation Toast -->
        <div id="confirmationToast"
            style="display:none; position:fixed; top:28px; left:50%; transform:translate(-50%, -20px); z-index:999999; background:#198754; color:#ffffff; padding:12px 28px; border-radius:50px; box-shadow:0 8px 24px rgba(0,0,0,0.22); font-size:0.95rem; font-weight:600; align-items:center; gap:10px; pointer-events:none; transition:opacity 0.3s ease, transform 0.3s ease;">
            <i class="bi bi-check-circle-fill fs-5 text-white"></i>
            <span id="confirmationToastMsg">Updated successfully</span>
        </div>

        <!-- Top Header: Restaurant Tables Management -->
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
            <div>
                <nav aria-label="breadcrumb" class="mb-1">
                    <ol class="breadcrumb small text-muted mb-0">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx" class="text-decoration-none text-muted"><i
                                    class="bi bi-house-door-fill text-warning me-1"></i> Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="RestaurantManagement.aspx"
                                class="text-decoration-none text-muted">Dining &amp; Restaurant</a></li>
                        <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Manage Tables</li>
                    </ol>
                </nav>
                <h2 class="fw-bold mb-1 text-dark" style="font-family: 'Playfair Display', Georgia, serif;">Restaurant
                    Tables Management</h2>
                <p class="text-muted small mb-0">The Royal Kitchen &mdash; Manage dining tables and availability</p>
            </div>
            <div class="d-flex align-items-center gap-2">
                <a href="../TableReservation.aspx" target="_blank"
                    class="btn btn-outline-secondary px-3 py-2 rounded-3 fw-semibold small">
                    <i class="bi bi-globe2 me-1"></i> Live Reservation Page
                </a>
                <a href="RestaurantManagement.aspx" class="btn btn-outline-dark px-3 py-2 rounded-3 fw-semibold small">
                    <i class="bi bi-clock-history me-1"></i> Meal Schedules
                </a>
            </div>
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

        <!-- Table Statistics KPI Strip -->
        <div class="row g-3 mb-4">
            <div class="col-6 col-lg-3">
                <div
                    class="kpi-table-card d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-2">
                    <div>
                        <span class="text-muted small font-monospace d-block">TOTAL TABLES</span>
                        <h3 class="fw-bold text-dark mb-0 mt-1">
                            <asp:Label ID="lblTotalTables" runat="server" Text="8 Tables"></asp:Label>
                        </h3>
                    </div>
                    <div class="p-3 bg-primary-subtle text-primary rounded-circle"><i
                            class="bi bi-grid-3x3-gap fs-4"></i></div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div
                    class="kpi-table-card d-flex flex-column flex-md-row align-items-start align-items-md-center justify-content-between gap-2">
                    <div>
                        <span class="text-muted small font-monospace d-block">AVAILABLE NOW</span>
                        <h3 class="fw-bold text-success mb-0 mt-1">
                            <asp:Label ID="lblAvailableTables" runat="server" Text="6 Tables"></asp:Label>
                        </h3>
                    </div>
                    <div class="p-3 bg-success-subtle text-success rounded-circle"><i
                            class="bi bi-check-circle fs-4"></i></div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="kpi-table-card d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small font-monospace d-block">RESERVED</span>
                        <h3 class="fw-bold text-warning mb-0 mt-1">
                            <asp:Label ID="lblReservedTables" runat="server" Text="1 Table"></asp:Label>
                        </h3>
                    </div>
                    <div class="p-3 bg-warning-subtle text-warning-dark rounded-circle"><i
                            class="bi bi-clock-history fs-4"></i></div>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <div class="kpi-table-card d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small font-monospace d-block">BLOCKED</span>
                        <h3 class="fw-bold text-danger mb-0 mt-1">
                            <asp:Label ID="lblBlockedTables" runat="server" Text="1 Table"></asp:Label>
                        </h3>
                    </div>
                    <div class="p-3 bg-danger-subtle text-danger rounded-circle"><i class="bi bi-slash-circle fs-4"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- ==========================================
         1. ADD / EDIT TABLE FORM
         ========================================== -->
        <div class="rest-card-box mb-4">
            <div class="rest-card-header d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-plus-circle-fill fs-4 text-warning"></i>
                    <div>
                        <h4 class="mb-0 fw-bold text-white">
                            <asp:Literal ID="litFormTitle" runat="server" Text="1. Add New Table"></asp:Literal>
                        </h4>
                        <small class="text-white-50">Create and configure individual dining tables for The Royal
                            Kitchen</small>
                    </div>
                </div>
                <div>
                    <span class="badge bg-gold text-dark px-3 py-2 rounded-pill fw-bold"
                        style="background-color: #B88E68; color: #ffffff;">
                        <i class="bi bi-shop me-1"></i> The Royal Kitchen
                    </span>
                </div>
            </div>

            <div class="p-4">
                <asp:HiddenField ID="hfEditTableId" runat="server" Value="0" />

                <div class="row g-3">
                    <!-- Table Number -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Table Number <span
                                class="text-danger">*</span></label>
                        <asp:TextBox ID="txtTableNumber" runat="server" CssClass="form-control" placeholder="e.g. T-01">
                        </asp:TextBox>
                        <span class="text-muted" style="font-size: 0.75rem;">Unique identifier (e.g. T-01, T-02)</span>
                    </div>

                    <!-- Table Name -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Table Name <span
                                class="text-danger">*</span></label>
                        <asp:TextBox ID="txtTableName" runat="server" CssClass="form-control"
                            placeholder="e.g. Couple Table"></asp:TextBox>
                        <span class="text-muted" style="font-size: 0.75rem;">Descriptive name for dining guests</span>
                    </div>

                    <!-- Capacity -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Capacity <span
                                class="text-danger">*</span></label>
                        <asp:TextBox ID="txtCapacity" runat="server" TextMode="Number" CssClass="form-control"
                            placeholder="e.g. 2" min="1" max="30"></asp:TextBox>
                        <span class="text-muted" style="font-size: 0.75rem;">Max guests seated (e.g. 2, 4, 6, 8)</span>
                    </div>

                    <!-- Section -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Section <span
                                class="text-danger">*</span></label>
                        <asp:TextBox ID="txtSection" runat="server" CssClass="form-control"
                            placeholder="e.g. Window Side"></asp:TextBox>
                        <span class="text-muted" style="font-size: 0.75rem;">e.g. Window Side, Main Dining, VIP</span>
                    </div>

                    <!-- Location -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Location <span
                                class="text-danger">*</span></label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control"
                            placeholder="e.g. Main Hall"></asp:TextBox>
                        <span class="text-muted" style="font-size: 0.75rem;">e.g. Main Hall, Center Area, West
                            Wing</span>
                    </div>

                    <!-- Floor -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Floor <span
                                class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlFloor" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Ground Floor" Selected="True">Ground Floor</asp:ListItem>
                            <asp:ListItem Value="First Floor">First Floor</asp:ListItem>
                            <asp:ListItem Value="Garden Wing">Garden Wing</asp:ListItem>
                            <asp:ListItem Value="Terrace">Terrace</asp:ListItem>
                            <asp:ListItem Value="Private Salon">Private Salon</asp:ListItem>
                        </asp:DropDownList>
                        <span class="text-muted" style="font-size: 0.75rem;">Floor/zone within restaurant</span>
                    </div>

                    <!-- Table Status -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Table Status <span
                                class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlTableStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Value="Available" Selected="True">Available</asp:ListItem>
                            <asp:ListItem Value="Booked">Booked</asp:ListItem>
                            <asp:ListItem Value="Reserved">Reserved</asp:ListItem>
                            <asp:ListItem Value="Blocked">Blocked</asp:ListItem>
                        </asp:DropDownList>
                        <span class="text-muted" style="font-size: 0.75rem;">Live availability for booking</span>
                    </div>

                    <!-- Active Status -->
                    <div class="col-md-3">
                        <label class="form-label small fw-semibold text-dark">Active Status <span
                                class="text-danger">*</span></label>
                        <asp:DropDownList ID="ddlIsActive" runat="server" CssClass="form-select">
                            <asp:ListItem Value="1" Selected="True">Active</asp:ListItem>
                            <asp:ListItem Value="0">Inactive</asp:ListItem>
                        </asp:DropDownList>
                        <span class="text-muted" style="font-size: 0.75rem;">Included in restaurant inventory</span>
                    </div>
                </div>

                <!-- Form Action Buttons -->
                <div class="d-flex align-items-center justify-content-between pt-3 mt-4 border-top">
                    <span class="text-muted small">
                        <i class="bi bi-info-circle text-primary me-1"></i> Fill fields and click button to save table
                        record
                    </span>
                    <div>
                        <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel"
                            CssClass="btn btn-outline-secondary px-3 py-2 rounded-3 me-2 fw-semibold"
                            OnClick="btnCancelEdit_Click" Visible="false" />
                        <asp:Button ID="btnSaveTable" runat="server" Text="+ Add Table" CssClass="btn btn-gold-save"
                            OnClick="btnSaveTable_Click" />
                    </div>
                </div>

            </div>
        </div>

        <!-- ==========================================
         3. MANAGE TABLES LIST
         ========================================== -->
        <div class="rest-card-box">
            <div class="rest-card-header d-flex align-items-center justify-content-between flex-wrap gap-2">
                <div class="d-flex align-items-center gap-2">
                    <i class="bi bi-grid-3x3-gap-fill fs-4 text-warning"></i>
                    <div>
                        <h4 class="mb-0 fw-bold text-white">Manage Tables</h4>
                        <small class="text-white-50">Complete inventory and live status of all dining tables</small>
                    </div>
                </div>
                <div>
                    <span class="badge bg-success text-white px-3 py-2 rounded-pill fw-bold">
                        <i class="bi bi-check-circle-fill me-1"></i> Live Table List
                    </span>
                </div>
            </div>

            <div class="p-0">
                <div class="table-responsive">
                    <table class="table table-admin-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th style="width: 100px;">Table</th>
                                <th>Name</th>
                                <th>Capacity</th>
                                <th>Location</th>
                                <th>Section</th>
                                <th>Status</th>
                                <th class="text-end" style="width: 140px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptTables" runat="server" OnItemCommand="rptTables_ItemCommand">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <span class="table-num-pill">
                                                <%# Eval("TableNumber") %>
                                            </span>
                                        </td>
                                        <td>
                                            <strong class="text-dark">
                                                <%# Eval("TableName") %>
                                            </strong>
                                            <div class="text-muted" style="font-size: 0.75rem;">
                                                <%# Eval("Floor") %>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center gap-1">
                                                <i class="bi bi-people-fill text-muted"></i>
                                                <span class="fw-semibold text-dark">
                                                    <%# Eval("Capacity") %>
                                                </span>
                                                <small class="text-muted">Guests</small>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="text-secondary">
                                                <%# Eval("Location") %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-dark fw-medium">
                                                <%# Eval("Section") %>
                                            </span>
                                        </td>
                                        <td>
                                            <%# GetStatusBadge(Eval("TableStatus") !=null ?
                                                Eval("TableStatus").ToString() : "" ) %>
                                        </td>
                                        <td class="text-end">
                                            <div class="d-inline-flex align-items-center gap-1">
                                                <asp:LinkButton ID="btnEditTable" runat="server"
                                                    CssClass="btn btn-sm btn-outline-primary py-1 px-2.5 rounded-2"
                                                    CommandName="EditTable" CommandArgument='<%# Eval("TableId") %>'
                                                    ToolTip="Edit Table">
                                                    <i class="bi bi-pencil-square"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDeleteTable" runat="server"
                                                    CssClass="btn btn-sm btn-outline-danger py-1 px-2 rounded-2"
                                                    CommandName="DeleteTable" CommandArgument='<%# Eval("TableId") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this table?');"
                                                    ToolTip="Delete Table">
                                                    <i class="bi bi-trash"></i>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr id="trNoTables" runat="server" visible="false">
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-2 d-block text-secondary mb-2"></i>
                                    <strong class="text-dark d-block mb-1">No Dining Tables Found</strong>
                                    <span class="small text-muted">Use the form above ("1. Add New Table") to add your
                                        first restaurant table.</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Confirmation Toast & Auto-Dismiss Script (2 Seconds) -->
        <script src="js/restauranttables.js"></script>
    </asp:Content>