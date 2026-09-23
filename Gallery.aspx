<%@ Page Title="Photo Gallery | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
    <section class="gallery-compact-hero text-white">
        <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <div class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                <div>
                    <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                        <i class="bi bi-camera-fill me-1 text-warning"></i> 5-Star Resort Photo Gallery
                    </span>
                    <h1 class="display-4 font-serif fw-bold text-white mb-0">Gallery</h1>
                </div>
                <div class="mt-3 mt-md-0">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                            <li class="breadcrumb-item"><a href="index.aspx" class="text-white text-decoration-none">Home</a></li>
                            <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Gallery</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </section>

    <!-- ==========================================
         2. PHOTO GALLERY SECTION WITH FILTER BUTTONS (MATCHING SCREENSHOT)
         ========================================== -->
    <section class="py-5 bg-light">
        <div class="container py-4 px-3 px-lg-5">
            
            <!-- Filter Pills Bar (Centered) -->
            <div class="d-flex flex-wrap align-items-center justify-content-center gap-2 gap-md-3 mb-5" data-aos="fade-up" data-aos-duration="800">
                <button type="button" class="gallery-filter-btn filter-button active" data-filter="*">All Photos</button>
                <button type="button" class="gallery-filter-btn filter-button" data-filter=".filter-rooms">Rooms</button>
                <button type="button" class="gallery-filter-btn filter-button" data-filter=".filter-amenities">Amenities</button>
                <button type="button" class="gallery-filter-btn filter-button" data-filter=".filter-dining">Dining</button>
                <button type="button" class="gallery-filter-btn filter-button" data-filter=".filter-exterior">Exterior</button>
            </div>

            <!-- Gallery Grid Items (Isotope Container) -->
            <div class="row g-4 isotope-container">
                
                <asp:Repeater ID="rptPublicGallery" runat="server">
                    <ItemTemplate>
                        <div class='col-lg-4 col-md-6 item <%# GetFilterClass(Eval("Category")) %>' data-aos="fade-up" data-aos-duration="800">
                            <div class="gallery-item-card gallery-lightbox-trigger" data-img-src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' data-title='<%# Eval("Title") %>'>
                                <img src='<%# ResolveUrl("~/" + Eval("ImageUrl")) %>' loading="lazy" alt='<%# Eval("Title") %>' class="gallery-item-img" onerror="this.src='images/room-placeholder.jpg';">
                                <div class="gallery-zoom-icon">
                                    <i class="bi bi-eye-fill"></i>
                                </div>
                                <div class="gallery-overlay-mask">
                                    <span class="gallery-overlay-cat"><%# GetCategoryDisplayName(Eval("Category")) %></span>
                                    <h3 class="gallery-overlay-title"><%# Eval("Title") %></h3>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>

        </div>
    </section>

    <!-- Lightbox Preview Modal (Ultra-Large Full View) -->
    <div class="modal fade" id="galleryLightboxModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 bg-dark text-white rounded-4 overflow-hidden shadow-lg">
                <div class="modal-header border-0 pb-2 px-4 pt-3 d-flex align-items-center justify-content-between">
                    <h4 class="modal-title font-serif text-gold mb-0 fs-3" id="galleryModalCaption">Photo Preview</h4>
                    <button type="button" class="btn-close btn-close-white shadow-none fs-5" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center p-2 p-md-3">
                    <img src="" id="galleryModalPreviewImg" class="img-fluid rounded-3" alt="Gallery Full Preview">
                </div>
            </div>
        </div>
    </div>

</asp:Content>
