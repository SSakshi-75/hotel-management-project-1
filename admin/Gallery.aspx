<%@ Page Title="Photo Gallery Management | Executive Admin" Language="C#" MasterPageFile="~/admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Admin_Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="adminHead" Runat="Server">
    <meta name="description" content="Hotel Photo Gallery Management">
    <style>
        .gallery-card-thumb {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            background: #f1f5f9;
        }
        .gallery-admin-card {
            border: 1px solid rgba(184, 142, 104, 0.25);
            border-radius: 14px;
            overflow: hidden;
            background: #ffffff;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
        }
        .gallery-admin-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(68, 35, 5, 0.1);
            border-color: #B88E68;
        }
        .cat-badge-rooms { background: #e0f2fe; color: #0369a1; }
        .cat-badge-amenities { background: #dcfce7; color: #15803d; }
        .cat-badge-dining { background: #fef3c7; color: #b45309; }
        .cat-badge-exterior { background: #f3e8ff; color: #7e22ce; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" Runat="Server">

    <!-- Page Header & Action Bar -->
    <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-1" style="font-family: 'Playfair Display', Georgia, serif;">
                Photo Gallery Management
            </h2>
            <p class="text-muted small mb-0">
                Upload and manage photos for hotel rooms, amenities, dining, and exterior spaces.
            </p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <a href="../Gallery.aspx" target="_blank" class="btn-admin-secondary">
                <i class="bi bi-box-arrow-up-right me-1"></i> View Live Gallery
            </a>
        </div>
    </div>

    <!-- Error Alert Message -->
    <asp:Panel ID="pnlErrorMessage" runat="server" Visible="false"
        CssClass="alert alert-danger alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-exclamation-triangle-fill fs-3 text-danger"></i>
            <div>
                <strong class="d-block text-dark">Error</strong>
                <asp:Label ID="lblErrorMessage" runat="server" CssClass="small text-danger"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Success Alert Message -->
    <asp:Panel ID="pnlSuccessMessage" runat="server" Visible="false"
        CssClass="alert alert-success alert-dismissible fade show rounded-4 mb-4 shadow-sm" role="alert">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-check-circle-fill fs-3 text-success"></i>
            <div>
                <strong class="d-block text-dark">Success</strong>
                <asp:Label ID="lblSuccessMessage" runat="server" CssClass="small text-success"></asp:Label>
            </div>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Top Grid: Upload Form (Left) & Gallery Stats (Right) -->
    <div class="row g-4 mb-5">

        <!-- Form: Upload New Gallery Photo -->
        <div class="col-lg-6 col-md-12">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
                <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                    <div class="rounded-circle d-flex align-items-center justify-content-center"
                        style="width: 36px; height: 36px; background: rgba(184, 142, 104, 0.15); color: #442305;">
                        <i class="bi bi-cloud-arrow-up-fill fs-5"></i>
                    </div>
                    <h5 class="fw-bold text-dark mb-0 font-serif">Add New Gallery Photo</h5>
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold text-uppercase">Photo Title / Caption <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtPhotoTitle" runat="server" CssClass="form-control form-control-admin"
                        placeholder="e.g. Deluxe Room Mountain View, Infinity Swimming Pool" MaxLength="150" />
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold text-uppercase">Category <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select form-control-admin">
                        <asp:ListItem Value="Rooms" Text="Rooms (Suites & Bed)" Selected="True" />
                        <asp:ListItem Value="Amenities" Text="Amenities (Pool, Spa, Gym)" />
                        <asp:ListItem Value="Dining" Text="Dining (Restaurants & Bars)" />
                        <asp:ListItem Value="Exterior" Text="Exterior (Gardens, Architecture & Facade)" />
                    </asp:DropDownList>
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted small fw-bold text-uppercase">Select Image File <span class="text-danger">*</span></label>
                    <asp:FileUpload ID="fuGalleryImage" runat="server" CssClass="form-control form-control-admin"
                        accept="image/png, image/jpeg, image/jpg, image/webp" onchange="previewGalleryImage(this);" />
                    <small class="text-muted d-block mt-1">Accepted: JPG, JPEG, PNG, WEBP (Max: 5 MB)</small>
                </div>

                <!-- Instant Image Preview Box -->
                <div id="galleryPreviewContainer" style="display: none;" class="mb-3 p-3 bg-light rounded-3 text-center border">
                    <span class="small text-muted d-block mb-2 fw-semibold">Photo Preview:</span>
                    <img id="imgPreview" src="" alt="Selected Preview" style="max-height: 160px; max-width: 100%; border-radius: 8px; object-fit: cover;" />
                </div>

                <div class="mt-auto pt-2">
                    <asp:Button ID="btnUploadPhoto" runat="server" Text="Upload to Gallery"
                        CssClass="btn-admin-primary w-100 py-2 fs-6 fw-bold" OnClick="btnUploadPhoto_Click" />
                </div>
            </div>
        </div>

        <!-- Right Side: Gallery Overview & Category Breakdown -->
        <div class="col-lg-6 col-md-12">
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white h-100">
                <div class="d-flex align-items-center gap-2 mb-3 pb-2 border-bottom">
                    <div class="rounded-circle d-flex align-items-center justify-content-center"
                        style="width: 36px; height: 36px; background: rgba(184, 142, 104, 0.15); color: #442305;">
                        <i class="bi bi-images fs-5"></i>
                    </div>
                    <h5 class="fw-bold text-dark mb-0 font-serif">Category Breakdown</h5>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-6">
                        <div class="p-3 rounded-3 bg-light border text-center">
                            <span class="d-block text-muted small text-uppercase fw-bold">Total Photos</span>
                            <h3 class="fw-bold text-dark mb-0" id="statTotalPhotos" runat="server">0</h3>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="p-3 rounded-3 border text-center" style="background: #e0f2fe;">
                            <span class="d-block small text-uppercase fw-bold" style="color: #0369a1;">Rooms</span>
                            <h3 class="fw-bold mb-0" style="color: #0369a1;" id="statRooms" runat="server">0</h3>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="p-3 rounded-3 border text-center" style="background: #dcfce7;">
                            <span class="d-block small text-uppercase fw-bold" style="color: #15803d;">Amenities</span>
                            <h4 class="fw-bold mb-0" style="color: #15803d;" id="statAmenities" runat="server">0</h4>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="p-3 rounded-3 border text-center" style="background: #fef3c7;">
                            <span class="d-block small text-uppercase fw-bold" style="color: #b45309;">Dining</span>
                            <h4 class="fw-bold mb-0" style="color: #b45309;" id="statDining" runat="server">0</h4>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="p-3 rounded-3 border text-center" style="background: #f3e8ff;">
                            <span class="d-block small text-uppercase fw-bold" style="color: #7e22ce;">Exterior</span>
                            <h4 class="fw-bold mb-0" style="color: #7e22ce;" id="statExterior" runat="server">0</h4>
                        </div>
                    </div>
                </div>

                <div class="p-3 rounded-3 bg-light border">
                    <h6 class="fw-bold text-dark mb-1 small text-uppercase"><i class="bi bi-info-circle-fill text-warning me-1"></i> Direct Public Sync</h6>
                    <p class="text-muted small mb-0">
                        Photos added or removed here immediately update the customer-facing <strong>Gallery.aspx</strong> page and filter under the respective tabs.
                    </p>
                </div>
            </div>
        </div>

    </div>

    <!-- Photos Grid List -->
    <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-3 mb-4 pb-2 border-bottom">
            <div>
                <h5 class="fw-bold text-dark mb-0 font-serif">Current Gallery Photos</h5>
                <span class="text-muted small">Manage all existing photos currently shown in hotel gallery.</span>
            </div>
            <div>
                <asp:DropDownList ID="ddlFilterCategory" runat="server" CssClass="form-select form-select-sm"
                    AutoPostBack="true" OnSelectedIndexChanged="ddlFilterCategory_SelectedIndexChanged">
                    <asp:ListItem Value="All" Text="All Categories" Selected="True" />
                    <asp:ListItem Value="Rooms" Text="Rooms Only" />
                    <asp:ListItem Value="Amenities" Text="Amenities Only" />
                    <asp:ListItem Value="Dining" Text="Dining Only" />
                    <asp:ListItem Value="Exterior" Text="Exterior Only" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Gallery Items Repeater -->
        <div class="row g-4">
            <asp:Repeater ID="rptGallery" runat="server" OnItemCommand="rptGallery_ItemCommand">
                <ItemTemplate>
                    <div class="col-xl-3 col-lg-4 col-md-6 col-12">
                        <div class="gallery-admin-card h-100 d-flex flex-column">
                            <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' alt='<%# Eval("Title") %>'
                                class="gallery-card-thumb" onerror="this.src='../images/room-placeholder.jpg';" />
                            <div class="p-3 d-flex flex-column flex-grow-1">
                                <div class="d-flex align-items-center justify-content-between gap-2 mb-2">
                                    <span class='badge px-2 py-1 small fw-semibold <%# GetCategoryBadgeClass(Eval("Category")) %>'>
                                        <%# Eval("Category") %>
                                    </span>
                                    <span class="text-muted small">
                                        <%# Eval("CreatedDate", "{0:dd MMM yyyy}") %>
                                    </span>
                                </div>
                                <h6 class="fw-bold text-dark mb-3 text-truncate" title='<%# Eval("Title") %>'>
                                    <%# Eval("Title") %>
                                </h6>
                                <div class="mt-auto pt-2 border-top d-flex align-items-center justify-content-between">
                                    <a href='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' target="_blank"
                                        class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                                        <i class="bi bi-eye"></i> View
                                    </a>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeletePhoto"
                                        CommandArgument='<%# Eval("GalleryId") %>'
                                        CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                        OnClientClick="return confirm('Are you sure you want to permanently delete this photo?');">
                                        <i class="bi bi-trash"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Empty State -->
        <asp:Panel ID="pnlNoPhotos" runat="server" Visible="false" CssClass="text-center py-5">
            <i class="bi bi-images text-muted opacity-50" style="font-size: 3.5rem;"></i>
            <h5 class="fw-bold text-dark mt-2 mb-1">No Photos Found</h5>
            <p class="text-muted small mb-0">No photos match the selected filter. Upload a new photo above.</p>
        </asp:Panel>

    </div>

    <!-- JavaScript for Instant Image Preview -->
    <script type="text/javascript">
        function previewGalleryImage(input) {
            var container = document.getElementById("galleryPreviewContainer");
            var img = document.getElementById("imgPreview");
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    img.src = e.target.result;
                    container.style.display = "block";
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                container.style.display = "none";
            }
        }
    </script>

</asp:Content>
