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
                
                <!-- Row 1 Item 1: Rooms (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-rooms" data-aos="fade-up" data-aos-duration="800" data-aos-delay="100">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/room-classic-double.jpg" data-title="Deluxe King Suite">
                        <img src="images/room-classic-double.jpg" loading="lazy" alt="Deluxe King Suite" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Rooms &amp; Suites</span>
                            <h3 class="gallery-overlay-title">Deluxe King Suite</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 1 Item 2: Amenities (Col 8 - WIDE CARD MATCHING SCREENSHOT) -->
                <div class="col-lg-8 col-md-6 item filter-amenities" data-aos="fade-up" data-aos-duration="800" data-aos-delay="200">
                    <div class="gallery-item-card wide-card gallery-lightbox-trigger" data-img-src="images/amenity-pool.jpg" data-title="Infinity Pool & Sun Deck">
                        <img src="images/amenity-pool.jpg" loading="lazy" alt="Infinity Pool & Sun Deck" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Amenities</span>
                            <h3 class="gallery-overlay-title">Infinity Pool &amp; Sun Deck</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 2 Item 1: Dining (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-dining" data-aos="fade-up" data-aos-duration="800" data-aos-delay="300">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/amenity-restaurant.jpg" data-title="Signature Restaurant Fine Dining">
                        <img src="images/amenity-restaurant.jpg" loading="lazy" alt="Signature Restaurant" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Fine Dining</span>
                            <h3 class="gallery-overlay-title">Signature Restaurant</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 2 Item 2: Rooms (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-rooms" data-aos="fade-up" data-aos-duration="800" data-aos-delay="400">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/room-superior-king.jpg" data-title="Executive Suite Living Area">
                        <img src="images/room-superior-king.jpg" loading="lazy" alt="Executive Suite" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Rooms &amp; Suites</span>
                            <h3 class="gallery-overlay-title">Executive Suite</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 2 Item 3: Exterior (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-exterior" data-aos="fade-up" data-aos-duration="800" data-aos-delay="500">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/gallery-1.jpg" data-title="Terrace Garden Lounge">
                        <img src="images/gallery-1.jpg" loading="lazy" alt="Terrace Garden Lounge" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Exterior &amp; Garden</span>
                            <h3 class="gallery-overlay-title">Terrace Garden Lounge</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 3 Item 1: Amenities (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-amenities" data-aos="fade-up" data-aos-duration="800" data-aos-delay="600">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/amenity-spa.jpg" data-title="Royal Spa & Wellness">
                        <img src="images/amenity-spa.jpg" loading="lazy" alt="Royal Spa & Wellness" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Amenities</span>
                            <h3 class="gallery-overlay-title">Luxury Spa &amp; Wellness</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 3 Item 2: Exterior (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-exterior" data-aos="fade-up" data-aos-duration="800" data-aos-delay="700">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/indian-palace-hero.jpg" data-title="Heritage Palace Facade">
                        <img src="images/indian-palace-hero.jpg" loading="lazy" alt="Heritage Palace Facade" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Exterior</span>
                            <h3 class="gallery-overlay-title">Heritage Palace Facade</h3>
                        </div>
                    </div>
                </div>

                <!-- Row 3 Item 3: Rooms (Col 4) -->
                <div class="col-lg-4 col-md-6 item filter-rooms" data-aos="fade-up" data-aos-duration="800" data-aos-delay="800">
                    <div class="gallery-item-card gallery-lightbox-trigger" data-img-src="images/room-featured-presidential.jpg" data-title="Royal Presidential Suite">
                        <img src="images/room-featured-presidential.jpg" loading="lazy" alt="Royal Presidential Suite" class="gallery-item-img">
                        <div class="gallery-zoom-icon">
                            <i class="bi bi-eye-fill"></i>
                        </div>
                        <div class="gallery-overlay-mask">
                            <span class="gallery-overlay-cat">Rooms &amp; Suites</span>
                            <h3 class="gallery-overlay-title">Presidential Suite</h3>
                        </div>
                    </div>
                </div>

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
