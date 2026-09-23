<%@ Page Title="Manage Hotel & Suites | Executive Admin"
    Language="C#"
    MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true"
    MaintainScrollPositionOnPostback="true"
    CodeFile="ManageHotel.aspx.cs"
    Inherits="Admin_ManageHotel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Management - Executive Rooms and Suites Administration" />
    <link rel="stylesheet" type="text/css" href="css/managehotel.css?v=2.0" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Page Header & Action Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold mb-1 manage-hotel-title">Manage Hotel &amp; Suites</h2>
            <p class="text-muted small mb-0">Overview of all hotel room inventories, tariffs, specifications, and live guest portal publishing.</p>
        </div>
        <div class="d-flex align-items-center flex-wrap gap-2">
            <a href="../Room.aspx" target="_blank" class="btn-hotel-preview-site">
                <i class="bi bi-globe2"></i> Live Guest Rooms <i class="bi bi-box-arrow-up-right small"></i>
            </a>
            <a href="AddRoom.aspx" class="btn-hotel-add-room">
                <i class="bi bi-plus-lg"></i> Add New Room
            </a>
        </div>
    </div>

    <!-- Alert / Toast Messages -->
    <asp:Panel ID="pnlStatusMsg" runat="server" Visible="false" CssClass="alert alert-dismissible fade show mb-4 shadow-sm rounded-4" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i id="msgIcon" runat="server" class="bi bi-check-circle-fill fs-4 text-success"></i>
            <div>
                <asp:Label ID="lblStatusMessage" runat="server" CssClass="fw-semibold text-dark"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Luxury KPI Strip -->
    <div class="row g-3 mb-4">
        <!-- Total Rooms -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Total Suites &amp; Rooms</span>
                        <div class="kpi-value mt-1" id="kpiTotalRooms" runat="server">0</div>
                        <span class="text-muted small">Configured in Database</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-gold">
                        <i class="bi bi-buildings-fill"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Published & Live -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Publish Status</span>
                        <div class="kpi-value mt-1 text-success" id="kpiLiveRooms" runat="server">0 Live</div>
                        <span class="text-muted small">Visible on Guest Site</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-green">
                        <i class="bi bi-broadcast"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Average Tariff -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Average Tariff</span>
                        <div class="kpi-value mt-1" id="kpiAvgTariff" runat="server">₹ 0</div>
                        <span class="text-muted small">Per Night Average</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-blue">
                        <i class="bi bi-currency-rupee"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Distinct Categories -->
        <div class="col-6 col-lg-3">
            <div class="hotel-kpi-card">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="kpi-label">Room Categories</span>
                        <div class="kpi-value mt-1" id="kpiTotalCategories" runat="server">0 Tiers</div>
                        <span class="text-muted small">Luxury &amp; Executive</span>
                    </div>
                    <div class="kpi-icon-wrap kpi-icon-purple">
                        <i class="bi bi-stars"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Master Inventory Card -->
    <div class="manage-hotel-card">

        <!-- Header -->
        <div class="manage-hotel-header">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-door-open-fill text-warning fs-5"></i>
                <h4 class="mb-0">Rooms &amp; Suites Inventory</h4>
            </div>
            <div>
                <span class="header-count-pill" id="lblRoomCountPill" runat="server">
                    <i class="bi bi-shield-check me-1"></i> 0 Rooms Active
                </span>
            </div>
        </div>

        <!-- Toolbar -->
        <div class="manage-hotel-toolbar">
            <div class="row g-3 align-items-center">
                <!-- Search Box -->
                <div class="col-12 col-md-5 col-lg-4">
                    <div class="search-wrap-luxury">
                        <i class="bi bi-search search-icon-luxury"></i>
                        <input type="text" id="txtHotelSearch" class="form-control form-control-luxury-search" placeholder="Search room name, category, specs, ID..." onkeyup="filterHotelTable();" />
                    </div>
                </div>

                <!-- Category Filter Pills -->
                <div class="col-12 col-md-7 col-lg-6">
                    <div class="d-flex align-items-center flex-wrap gap-2">
                        <button type="button" class="filter-pill-btn active" onclick="setCategoryFilter('ALL', this); return false;">
                            All Suites
                        </button>
                        <button type="button" class="filter-pill-btn" onclick="setCategoryFilter('DELUXE', this); return false;">
                            Deluxe
                        </button>
                        <button type="button" class="filter-pill-btn" onclick="setCategoryFilter('PENTHOUSE', this); return false;">
                            Penthouse
                        </button>
                        <button type="button" class="filter-pill-btn" onclick="setCategoryFilter('FAMILY', this); return false;">
                            Family
                        </button>
                        <button type="button" class="filter-pill-btn" onclick="setCategoryFilter('EXECUTIVE', this); return false;">
                            Executive
                        </button>
                    </div>
                </div>

                <!-- Bulk Delete Action -->
                <div class="col-12 col-lg-2 text-lg-end">
                    <asp:Button ID="btnBulkDelete" runat="server" CssClass="btn-hotel-delete-selected" Text="Delete Selected" OnClick="btnBulkDelete_Click" OnClientClick="return confirmBulkDelete();" />
                </div>
            </div>
        </div>

        <!-- GridView -->
        <div class="table-responsive">
            <asp:GridView
                ID="grdrooms"
                runat="server"
                AutoGenerateColumns="false"
                DataKeyNames="RoomID"
                ClientIDMode="Static"
                CssClass="table table-bordered table-hover hotel-rooms-table align-middle"
                GridLines="Both"
                UseAccessibleHeader="true"
                AllowPaging="true"
                PageSize="10"
                OnPreRender="grdrooms_PreRender"
                OnPageIndexChanging="grdrooms_PageIndexChanging"
                OnRowDataBound="grdrooms_RowDataBound"
                EmptyDataText="No Hotel Rooms Registered">
                <Columns>
                    <%-- SELECT CHECKBOX --%>
                    <asp:TemplateField HeaderText="#">
                        <HeaderTemplate>
                            <div class="text-center">
                                <asp:CheckBox ID="chkSelectAll" runat="server" CssClass="hotel-chk-custom" onclick="toggleSelectAllRooms(this);" ToolTip="Select All" />
                            </div>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="text-center">
                                <asp:CheckBox ID="chkRoomSelect" runat="server" CssClass="hotel-chk-custom room-row-chk" />
                            </div>
                        </ItemTemplate>
                        <HeaderStyle Width="46px" />
                    </asp:TemplateField>

                    <%-- PREVIEW IMAGE --%>
                    <asp:TemplateField HeaderText="Preview">
                        <ItemTemplate>
                            <div class="room-thumb-wrap">
                                <a href='<%# ResolveUrl("~/RoomDetails.aspx?RoomId=" + Eval("RoomID")) %>' target="_blank" title="View Room">
                                    <asp:Image ID="imgRoom" runat="server" CssClass="hotel-room-thumb" ImageUrl='<%# GetRoomImage(Eval("PrimaryRoomImage")) %>' AlternateText='<%# Eval("RoomName") %>' />
                                </a>
                            </div>
                        </ItemTemplate>
                        <HeaderStyle Width="86px" />
                    </asp:TemplateField>

                    <%-- ROOM DETAILS --%>
                    <asp:TemplateField HeaderText="Room &amp; Suite Details">
                        <ItemTemplate>
                            <a href='<%# ResolveUrl("~/RoomDetails.aspx?RoomId=" + Eval("RoomID")) %>' target="_blank" class="room-name-heading">
                                <%# Eval("RoomName") %>
                            </a>
                            <div class="room-specs-list">
                                <span class="room-spec-item" title="Room ID">
                                    <i class="bi bi-hash"></i> Room #<%# Eval("RoomID") %>
                                </span>
                                <span class="room-spec-item" title="Max Occupancy">
                                    <i class="bi bi-people-fill"></i> <%# Eval("MaxGuests") %> Guests
                                </span>
                                <span class="room-spec-item" title="Room Dimensions">
                                    <i class="bi bi-aspect-ratio-fill"></i> <%# Eval("RoomArea") %>
                                </span>
                                <span class="room-spec-item" title="Scenic View">
                                    <i class="bi bi-eye-fill"></i> <%# Eval("ViewType") %>
                                </span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- CATEGORY --%>
                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <span class='<%# GetCategoryBadgeClass(Eval("RoomCategory")) %>'>
                                <%# Eval("RoomCategory") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- PRICE --%>
                    <asp:TemplateField HeaderText="Tariff / Night">
                        <ItemTemplate>
                            <span class="hotel-tariff-amount">
                                &#8377; <%# string.Format("{0:N0}", Eval("PricePerNight")) %>
                            </span>
                            <span class="hotel-tariff-period">
                                per room / night
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- LIVE STATUS --%>
                    <asp:TemplateField HeaderText="Live Status">
                        <ItemTemplate>
                            <span class="badge-hotel-live">
                                <span class="status-dot-pulse"></span> Published
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%-- ACTIONS --%>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="hotel-table-actions justify-content-center">
                                <a href='<%# "EditRoom.aspx?RoomId=" + Eval("RoomID") %>' class="btn-action-luxury btn-edit" title="Edit Room">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                                <a href='<%# ResolveUrl("~/RoomDetails.aspx?RoomId=" + Eval("RoomID")) %>' target="_blank" class="btn-action-luxury btn-view" title="View Room">
                                    <i class="bi bi-box-arrow-up-right"></i>
                                </a>
                                <a href='<%# "DeleteRoom.aspx?RoomId=" + Eval("RoomID") %>' class="btn-action-luxury btn-delete" title="Delete Room">
                                    <i class="bi bi-trash3"></i>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

                <%-- EMPTY DATA TEMPLATE --%>
                <EmptyDataTemplate>
                    <div class="empty-hotel-state">
                        <div class="empty-hotel-icon">
                            <i class="bi bi-door-closed"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-1">
                            No Hotel Rooms Registered
                        </h4>
                        <p class="text-muted small mb-3">
                            Begin by configuring your first luxury room or executive suite entry.
                        </p>
                        <a href="AddRoom.aspx" class="btn-hotel-add-room">
                            <i class="bi bi-plus-lg"></i> Add New Room
                        </a>
                    </div>
                </EmptyDataTemplate>

                <PagerStyle CssClass="hotel-grid-pager" />
            </asp:GridView>
        </div>

        <!-- Footer -->
        <div class="manage-hotel-footer">
            <div>
                <span class="fw-semibold text-dark">Hotel Property Management</span>
                <span class="mx-2 text-muted">•</span>
                <span class="text-muted">Real-time room tariff and inventory synchronization</span>
            </div>
            <div>
                <a href="../Room.aspx" target="_blank" class="text-decoration-none fw-semibold" style="color: var(--hotel-gold-dark);">
                    View Guest Catalog <i class="bi bi-arrow-right small"></i>
                </a>
            </div>
        </div>

    </div>

    <!-- Hidden Field to store target Room ID for deletion -->
    <asp:HiddenField ID="hdnDeleteRoomId" runat="server" Value="0" />

    <!-- Bootstrap 5 Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 440px;">
            <div class="modal-content border-0 shadow-lg" style="border-radius: 18px; overflow: hidden;">
                <div class="modal-body p-4 text-center">
                    <!-- Danger Alert Icon -->
                    <div class="mx-auto mb-3 d-flex align-items-center justify-content-center" style="width: 62px; height: 62px; border-radius: 50%; background-color: #fef2f2; color: #dc2626; border: 1px solid #fee2e2;">
                        <i class="bi bi-exclamation-triangle-fill" style="font-size: 1.85rem;"></i>
                    </div>

                    <h5 class="modal-title fw-bold text-dark mb-2" id="deleteConfirmModalLabel">Delete Room Confirmation</h5>
                    
                    <p class="text-secondary small mb-3">Are you sure you want to delete this room?</p>

                    <!-- Room Name Highlight Display -->
                    <div class="p-3 mb-3 text-center rounded-3" style="background-color: #f8fafc; border: 1px dashed #cbd5e1;">
                        <span class="d-block text-uppercase fw-bold text-muted mb-1" style="font-size: 0.72rem; letter-spacing: 0.5px;">Selected Room</span>
                        <h6 class="fw-bold mb-0 text-dark" id="lblDeleteModalRoomName">Executive Business Suite</h6>
                    </div>

                    <p class="text-danger small mb-0 fw-semibold">
                        <i class="bi bi-shield-exclamation me-1"></i> This action cannot be undone.
                    </p>
                </div>

                <div class="modal-footer border-0 bg-light px-4 py-3 justify-content-center gap-2">
                    <button type="button" class="btn btn-light px-4 py-2 fw-semibold text-secondary border rounded-3" data-bs-dismiss="modal">
                        Cancel
                    </button>
                    <asp:Button ID="btnConfirmDeleteRoom" runat="server" Text="Delete Room" CssClass="btn btn-danger px-4 py-2 fw-semibold rounded-3 shadow-sm" OnClick="btnConfirmDeleteRoom_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript Interactivity -->
    <script type="text/javascript">
        var currentActiveCategory = 'ALL';

        function confirmDeleteRoom(roomId, roomName) {
            var hdn = document.getElementById('<%= hdnDeleteRoomId.ClientID %>');
            if (hdn) {
                hdn.value = roomId;
            }
            var lbl = document.getElementById('lblDeleteModalRoomName');
            if (lbl) {
                lbl.innerText = roomName || ('Room #' + roomId);
            }
            var modalEl = document.getElementById('deleteConfirmModal');
            if (modalEl) {
                if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                    var modal = bootstrap.Modal.getOrCreateInstance(modalEl);
                    modal.show();
                } else if (typeof $ !== 'undefined' && $(modalEl).modal) {
                    $(modalEl).modal('show');
                }
            }
        }

        function toggleSelectAllRooms(master) {
            var checkboxes = document.querySelectorAll('.room-row-chk input[type="checkbox"]');
            for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = master.checked;
            }
        }

        function filterHotelTable() {
            var searchInput = document.getElementById('txtHotelSearch');
            var filter = searchInput ? searchInput.value.toLowerCase().trim() : '';
            var rows = document.querySelectorAll('#grdrooms tr.hotel-room-row');

            for (var i = 0; i < rows.length; i++) {
                var row = rows[i];
                var text = row.textContent.toLowerCase();
                var category = (row.getAttribute('data-category') || '').toUpperCase();

                var matchesSearch = (filter === '' || text.indexOf(filter) !== -1);
                var matchesCategory = (currentActiveCategory === 'ALL' || category.indexOf(currentActiveCategory) !== -1);

                row.style.display = (matchesSearch && matchesCategory) ? '' : 'none';
            }
        }

        function setCategoryFilter(category, button) {
            currentActiveCategory = category.toUpperCase();

            var buttons = document.querySelectorAll('.filter-pill-btn');
            for (var i = 0; i < buttons.length; i++) {
                buttons[i].classList.remove('active');
            }

            if (button) {
                button.classList.add('active');
            }

            filterHotelTable();
        }

        function confirmBulkDelete() {
            var checked = document.querySelectorAll('.room-row-chk input[type="checkbox"]:checked');
            if (checked.length === 0) {
                alert('Please select at least one room checkbox from the table to delete.');
                return false;
            }
            return confirm('Are you sure you want to permanently delete ' + checked.length + ' selected room(s)?');
        }
    </script>

</asp:Content>