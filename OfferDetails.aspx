<%@ Page Title="Offer Details | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="OfferDetails.aspx.cs" Inherits="OfferDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- ==========================================
         1. COMPACT HERO / PAGE TITLE
         ========================================== -->
    <section class="room-compact-hero text-white text-center">
        <div class="container py-2 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
            <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                <i class="bi bi-tag-fill me-1 text-warning"></i> Curated Package Details
            </span>
            <h1 class="display-5 font-serif fw-bold text-white mb-2" id="detailHeroHeading">Breakfast Inclusive Offer</h1>
            <p class="text-champagne-gold fs-5 mb-0 font-serif" id="detailHeroSubtitle">
                Elevate your luxury stay with handcrafted complimentary inclusions
            </p>
        </div>
    </section>

    <!-- ==========================================
         2. BREADCRUMBS
         ========================================== -->
    <div class="container px-4 px-lg-5 pt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb page-title-breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="index.aspx"><i class="bi bi-house-door-fill me-1"></i> Home</a></li>
                <li class="breadcrumb-item"><a href="Offers.aspx">Special Offers</a></li>
                <li class="breadcrumb-item active" id="detailBreadcrumbTitle" aria-current="page">Breakfast Inclusive Offer</li>
            </ol>
        </nav>
    </div>

    <!-- ==========================================
         3. OFFER DETAIL CONTENT
         ========================================== -->
    <section class="py-5">
        <div class="container px-4 px-lg-5">
            <div class="row g-5">

                <!-- Left Column: Large Image, Inclusions, Validity, Terms (col-lg-8) -->
                <div class="col-lg-8" data-aos="fade-right" data-aos-duration="800">
                    
                    <!-- Large Image -->
                    <div class="offer-detail-hero-box mb-4">
                        <img id="detailLargeImg" src="images/amenity-restaurant.jpg" loading="lazy" alt="Offer Detail Image" class="img-fluid w-100">
                        <span class="offer-card-overlay-badge" id="detailCategoryBadge">
                            <i class="bi bi-star-fill text-warning"></i> Best Value
                        </span>
                    </div>

                    <!-- Title & Price Header -->
                    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-3 pb-3 mb-4 border-bottom">
                        <div>
                            <span class="text-uppercase fw-bold small text-gold letter-spacing-1" id="detailCategoryName">Stay &amp; Dining Package</span>
                            <h2 class="display-6 font-serif fw-bold mb-0" style="color: #442305;" id="detailTitle">Breakfast Inclusive Offer</h2>
                        </div>
                        <div class="text-sm-end">
                            <span class="small text-muted d-block text-uppercase">Special Rate</span>
                            <div class="fs-2 fw-bold" style="color: #442305;" id="detailPriceContainer">
                                <span id="detailPriceText">&#8377;4,999</span>
                                <span class="fs-6 fw-normal text-muted" id="detailPricePeriod">/ Night</span>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="mb-5">
                        <h4 class="font-serif fw-bold mb-3" style="color: #442305;">About This Exclusive Experience</h4>
                        <p class="text-muted leading-relaxed" style="font-size: 1rem; line-height: 1.8;" id="detailFullDesc">
                            Start every morning of your luxurious vacation with an opulent chef-curated morning feast. Featuring lavish live cooking stations, freshly baked Viennoiserie, artisanal cheeses, tropical fruit displays, and personalized barista coffee brews at The Imperial Spice dining pavilion. Immerse yourself in pure comfort and attentive royal hospitality.
                        </p>
                    </div>

                    <!-- Inclusions Checklist (Requested: Breakfast for 2, Free Wi-Fi, Parking, Complimentary welcome drink) -->
                    <div class="mb-5">
                        <h4 class="font-serif fw-bold mb-3" style="color: #442305;">
                            <i class="bi bi-gift text-warning me-2"></i> What's Included In This Package
                        </h4>
                        <div class="row g-3" id="detailInclusionsContainer">
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">Breakfast for 2</strong>
                                        <small class="text-muted">Daily gourmet buffet breakfast at the hotel restaurant</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">Free High-Speed Wi-Fi</strong>
                                        <small class="text-muted">Uncapped premium internet access in suites and public areas</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">Valet Parking</strong>
                                        <small class="text-muted">Complimentary on-site secure parking throughout your stay</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">Complimentary Welcome Drink</strong>
                                        <small class="text-muted">Signature heritage royal cooler served upon arrival</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">24/7 Royal Concierge</strong>
                                        <small class="text-muted">Dedicated concierge service for tours, dining, and assistance</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="offer-inclusion-item">
                                    <i class="bi bi-check-circle-fill"></i>
                                    <div>
                                        <strong class="d-block text-dark">Pool &amp; Fitness Access</strong>
                                        <small class="text-muted">Full complimentary access to heated swimming pool &amp; gym</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Validity Section -->
                    <div class="mb-5">
                        <h4 class="font-serif fw-bold mb-3" style="color: #442305;">
                            <i class="bi bi-calendar-check text-warning me-2"></i> Validity &amp; Schedule
                        </h4>
                        <div class="p-4 rounded-3 bg-white border shadow-sm">
                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <span class="text-muted small text-uppercase d-block">Booking Period</span>
                                    <strong class="text-dark" id="detailBookingWindow">Now &mdash; 31 December 2026</strong>
                                </div>
                                <div class="col-sm-6">
                                    <span class="text-muted small text-uppercase d-block">Stay Period</span>
                                    <strong class="text-dark" id="detailStayWindow">Valid On All Days (Subject to Availability)</strong>
                                </div>
                                <div class="col-sm-6">
                                    <span class="text-muted small text-uppercase d-block">Minimum Stay</span>
                                    <strong class="text-dark" id="detailMinStay">No Minimum Stay Required</strong>
                                </div>
                                <div class="col-sm-6">
                                    <span class="text-muted small text-uppercase d-block">Applicable Rooms</span>
                                    <strong class="text-dark">All Luxury Rooms, Suites &amp; Villas</strong>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Terms & Conditions Section -->
                    <div class="offer-terms-card">
                        <h5 class="font-serif fw-bold mb-2" style="color: #442305;">
                            <i class="bi bi-file-earmark-text text-warning me-2"></i> Terms &amp; Conditions
                        </h5>
                        <ul class="small text-muted mb-0 ps-3 d-flex flex-column gap-2" style="line-height: 1.6;">
                            <li>Government taxes and 18% luxury GST will be applicable additionally as per prevailing statutory regulations.</li>
                            <li>Free cancellation is available up to 48 hours prior to scheduled 2:00 PM check-in date without penalty.</li>
                            <li>Standard hotel check-in time is 2:00 PM and check-out time is 12:00 PM noon. Early check-in is subject to availability.</li>
                            <li>Valid government-issued photo ID (Aadhaar / Passport / Driving License) is mandatory for all guests upon arrival.</li>
                            <li>This promotional offer cannot be combined with other ongoing corporate codes or banquet bookings.</li>
                        </ul>
                    </div>

                </div>

                <!-- Right Column: Sticky Booking Card (col-lg-4) -->
                <div class="col-lg-4" data-aos="fade-left" data-aos-duration="800">
                    <div class="offer-sidebar-card">
                        <span class="badge bg-gold-subtle text-warning-dark px-3 py-1 text-uppercase fw-semibold mb-2">Direct Official Booking</span>
                        <h4 class="font-serif fw-bold mb-1" style="color: #442305;">Reserve This Package</h4>
                        <p class="small text-muted mb-3">Best rate guaranteed with direct hotel benefits.</p>

                        <div class="p-3 rounded-3 mb-4" style="background: #faf8f5; border: 1px dashed #B88E68;">
                            <div class="small text-muted text-uppercase">Total Package Rate</div>
                            <div class="fs-2 fw-bold" style="color: #442305;" id="sidebarPriceDisplay">
                                &#8377;4,999 <small class="fs-6 fw-normal text-muted">/ night</small>
                            </div>
                            <small class="text-success fw-semibold"><i class="bi bi-check2 me-1"></i> No prepayment needed today</small>
                        </div>

                        <!-- Date Selection for Fast Booking -->
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase" style="color: #442305;">Check-In Date</label>
                            <input type="date" class="form-control" id="offerCheckIn">
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-uppercase" style="color: #442305;">Check-Out Date</label>
                            <input type="date" class="form-control" id="offerCheckOut">
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold text-uppercase" style="color: #442305;">Guests</label>
                            <select class="form-select" id="offerGuests">
                                <option value="2" selected>2 Guests (Included in Package)</option>
                                <option value="1">1 Guest</option>
                                <option value="3">3 Guests (Extra Bed Charge)</option>
                                <option value="4">4 Guests (Family Suite)</option>
                            </select>
                        </div>

                        <!-- Prominent [ BOOK THIS OFFER ] CTA Button -->
                        <button type="button" class="btn-book-offer mb-3" onclick="handleBookThisOffer()">
                            <i class="bi bi-calendar-check-fill"></i>
                            <span>BOOK THIS OFFER</span>
                        </button>

                        <div class="text-center">
                            <a href="Offers.aspx" class="text-decoration-none small" style="color: #B88E68;">
                                <i class="bi bi-arrow-left me-1"></i> Browse Other Offers
                            </a>
                        </div>

                        <div class="mt-4 pt-3 border-top text-center">
                            <small class="text-muted d-block mb-1">Need Assistance or Customization?</small>
                            <strong style="color: #442305;"><i class="bi bi-telephone-fill text-warning me-1"></i> +91 11 3933 1234</strong>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ==========================================
         OFFER DETAILS DYNAMIC LOADER SCRIPT
         ========================================== -->
    <script>
        var OFFERS_DATABASE = {
            "breakfast-included": {
                title: "Breakfast Inclusive Offer",
                category: "Stay & Dining Package",
                badge: "Best Value",
                price: "4999",
                priceDisplay: "&#8377;4,999",
                period: "/ Night",
                image: "images/amenity-restaurant.jpg",
                desc: "Start every morning of your luxurious vacation with an opulent chef-curated morning feast. Featuring lavish live cooking stations, freshly baked Viennoiserie, artisanal cheeses, tropical fruit displays, and personalized barista coffee brews at The Imperial Spice dining pavilion. Immerse yourself in pure comfort and attentive royal hospitality.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid On All Days (Subject to Availability)",
                minStay: "No Minimum Stay Required",
                inclusions: [
                    { title: "Breakfast for 2", desc: "Daily gourmet buffet breakfast at the hotel restaurant" },
                    { title: "Free High-Speed Wi-Fi", desc: "Uncapped premium internet access in suites and public areas" },
                    { title: "Valet Parking", desc: "Complimentary on-site secure parking throughout your stay" },
                    { title: "Complimentary Welcome Drink", desc: "Signature heritage royal cooler served upon arrival" },
                    { title: "24/7 Royal Concierge", desc: "Dedicated concierge service for tours, dining, and assistance" },
                    { title: "Pool & Fitness Access", desc: "Full complimentary access to heated swimming pool & gym" }
                ]
            },
            "weekend-getaway": {
                title: "Weekend Royal Getaway",
                category: "Weekend Leisure Special",
                badge: "Weekend Special",
                price: "5499",
                priceDisplay: "&#8377;5,499",
                period: "/ Night",
                image: "images/amenity-pool.jpg",
                desc: "Escape the bustling workweek with our rejuvenating weekend sanctuary. Unwind in private poolside cabanas, savor afternoon traditional high tea with warm scones and savory tartlets, and enjoy 20% savings across all therapeutic rituals at Jiva Luxury Spa.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid on Friday, Saturday & Sunday Check-in",
                minStay: "1 Night Minimum",
                inclusions: [
                    { title: "Royal Afternoon High Tea", desc: "Handcrafted savories, scones, and single-origin teas daily" },
                    { title: "20% Spa Savings", desc: "Applicable on all treatments at Jiva Luxury Spa & Wellness" },
                    { title: "Heated Swimming Pool Access", desc: "Complimentary poolside loungers and cabana towels" },
                    { title: "Guaranteed Late Checkout", desc: "Relax longer with confirmed 2:00 PM late check-out" },
                    { title: "Free High-Speed Wi-Fi", desc: "Stay connected throughout the resort grounds" },
                    { title: "Valet Parking", desc: "Complimentary secure valet parking" }
                ]
            },
            "long-stay": {
                title: "Long Stay Offer (Save 20%)",
                category: "Extended Stay Privilege",
                badge: "Save 20%",
                price: "7200",
                priceDisplay: "20% OFF",
                period: "/ Stay",
                image: "images/room-featured-presidential.jpg",
                desc: "Savor a longer sanctuary in New Delhi. Stay for 3 nights or more and enjoy a 20% discount on our best available suite rates, accompanied by private luxury airport chauffeur pickup and complimentary laundry services.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid All Year Round",
                minStay: "3 Consecutive Nights Minimum",
                inclusions: [
                    { title: "20% Flat Discount", desc: "Direct percentage savings applied across your entire stay" },
                    { title: "One-Way Airport Chauffeur", desc: "Complimentary arrival pickup from New Delhi Airport" },
                    { title: "Daily Laundry Credits", desc: "Complimentary pressing and washing of 4 garments daily" },
                    { title: "Club Lounge Access", desc: "Complimentary evening high tea and cocktails in executive lounge" },
                    { title: "Gourmet Breakfast for 2", desc: "Complimentary daily buffet breakfast" },
                    { title: "Free Wi-Fi & Parking", desc: "High-speed internet and round-the-clock valet parking" }
                ]
            },
            "dine-and-stay": {
                title: "Imperial Dine & Stay Package",
                category: "Gourmet Culinary Escape",
                badge: "Dinner & Breakfast",
                price: "6999",
                priceDisplay: "&#8377;6,999",
                period: "/ Night",
                image: "images/item1.jpg",
                desc: "Embark on an epicurean journey designed for food connoisseurs. Relish an unforgettable 4-course candlelight dinner at The Imperial Spice with a sommelier-selected bottle of wine, followed by a blissful night in our luxury suites.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid All Days",
                minStay: "1 Night Minimum",
                inclusions: [
                    { title: "4-Course Chef Candlelight Dinner", desc: "Multi-course royal menu at The Imperial Spice restaurant" },
                    { title: "Complimentary Bottle of Wine", desc: "Handpicked red or white wine presented at your table" },
                    { title: "Gourmet Buffet Breakfast", desc: "Complimentary lavish morning spread for two" },
                    { title: "Priority Table Reservation", desc: "Guaranteed prime window or poolside candlelight seating" },
                    { title: "Welcome Sweet Platter", desc: "Handmade artisanal chocolates in suite upon arrival" },
                    { title: "Free Wi-Fi & Valet", desc: "Full complimentary internet and parking services" }
                ]
            },
            "family-holiday": {
                title: "Royal Family Vacation Package",
                category: "Family & Kids Special",
                badge: "Kids Stay Free",
                price: "8499",
                priceDisplay: "&#8377;8,499",
                period: "/ Night",
                image: "images/room-mini-family.jpg",
                desc: "Craft unforgettable moments with your loved ones. Our family holiday package offers interconnecting luxury suite accommodations, kids stay and eat free privileges, complimentary extra bed, and a guided sightseeing excursion to Delhi's historic monuments.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid All Year Round",
                minStay: "2 Nights Minimum",
                inclusions: [
                    { title: "Kids Under 12 Stay & Dine Free", desc: "Complimentary meals and stay for up to 2 children" },
                    { title: "Complimentary Extra Bed", desc: "One plush rollaway bed included free of charge" },
                    { title: "Delhi Heritage Monument Pass", desc: "Complimentary family pass for Qutub Minar & Humayun's Tomb" },
                    { title: "Kids Surprise Goodie Bag", desc: "Special welcome kit with coloring books, treats, and toys" },
                    { title: "Breakfast for the Whole Family", desc: "Daily buffet breakfast for 2 adults and 2 children" },
                    { title: "Family Photo Souvenir", desc: "Complimentary framed photograph in the royal courtyard" }
                ]
            },
            "romantic-escape": {
                title: "Romantic Celebration Escape",
                category: "Romance & Honeymoon",
                badge: "Couple Special",
                price: "12999",
                priceDisplay: "&#8377;12,999",
                period: "/ Night",
                image: "images/room-luxury-penthouse.jpg",
                desc: "An enchanting palace experience curated for newlyweds, anniversaries, and romantic milestones. Includes romantic rose petal suite styling, chilled champagne, couple aromatherapy massage, and a private 4-course candlelight balcony dinner under the stars.",
                bookingWindow: "Now — 31 December 2026",
                stayWindow: "Valid All Days",
                minStay: "1 Night Minimum",
                inclusions: [
                    { title: "60-Min Couple Aromatherapy Spa", desc: "Relaxing synchronized body massage at Jiva Luxury Spa" },
                    { title: "Chilled Sparkling Wine & Cake", desc: "Bottle of sparkling wine and handcrafted celebratory cake" },
                    { title: "Private Candlelight Balcony Dinner", desc: "Personal butler service with 4-course curated menu" },
                    { title: "Rose Petal Suite Decoration", desc: "Romantic floral arrangement and aroma diffuser setup" },
                    { title: "Floating Champagne Breakfast", desc: "Exclusive breakfast served in-suite or in private cabana" },
                    { title: "Guaranteed 3:00 PM Late Checkout", desc: "Extended leisurely departure for romantic couples" }
                ]
            }
        };

        var currentOfferData = OFFERS_DATABASE["breakfast-included"];

        document.addEventListener("DOMContentLoaded", function () {
            // Read URL parameter
            var urlParams = new URLSearchParams(window.location.search);
            var offerId = urlParams.get('id') || 'breakfast-included';

            if (OFFERS_DATABASE[offerId]) {
                currentOfferData = OFFERS_DATABASE[offerId];
            }

            // Populate Page Elements
            document.title = currentOfferData.title + " | Hotel Management";
            var heroHeading = document.getElementById("detailHeroHeading");
            var heroSubtitle = document.getElementById("detailHeroSubtitle");
            var breadcrumbTitle = document.getElementById("detailBreadcrumbTitle");
            var detailLargeImg = document.getElementById("detailLargeImg");
            var detailCategoryBadge = document.getElementById("detailCategoryBadge");
            var detailCategoryName = document.getElementById("detailCategoryName");
            var detailTitle = document.getElementById("detailTitle");
            var detailPriceText = document.getElementById("detailPriceText");
            var detailPricePeriod = document.getElementById("detailPricePeriod");
            var detailFullDesc = document.getElementById("detailFullDesc");
            var detailBookingWindow = document.getElementById("detailBookingWindow");
            var detailStayWindow = document.getElementById("detailStayWindow");
            var detailMinStay = document.getElementById("detailMinStay");
            var sidebarPriceDisplay = document.getElementById("sidebarPriceDisplay");

            if (heroHeading) heroHeading.textContent = currentOfferData.title;
            if (breadcrumbTitle) breadcrumbTitle.textContent = currentOfferData.title;
            if (detailLargeImg) detailLargeImg.src = currentOfferData.image;
            if (detailCategoryBadge) detailCategoryBadge.innerHTML = '<i class="bi bi-star-fill text-warning"></i> ' + currentOfferData.badge;
            if (detailCategoryName) detailCategoryName.textContent = currentOfferData.category;
            if (detailTitle) detailTitle.textContent = currentOfferData.title;
            if (detailPriceText) detailPriceText.innerHTML = currentOfferData.priceDisplay;
            if (detailPricePeriod) detailPricePeriod.textContent = currentOfferData.period;
            if (detailFullDesc) detailFullDesc.textContent = currentOfferData.desc;
            if (detailBookingWindow) detailBookingWindow.textContent = currentOfferData.bookingWindow;
            if (detailStayWindow) detailStayWindow.textContent = currentOfferData.stayWindow;
            if (detailMinStay) detailMinStay.textContent = currentOfferData.minStay;
            if (sidebarPriceDisplay) sidebarPriceDisplay.innerHTML = currentOfferData.priceDisplay + ' <small class="fs-6 fw-normal text-muted">' + currentOfferData.period + '</small>';

            // Inclusions Render
            var incContainer = document.getElementById("detailInclusionsContainer");
            if (incContainer && currentOfferData.inclusions) {
                var incHtml = '';
                currentOfferData.inclusions.forEach(function (inc) {
                    incHtml += '<div class="col-md-6">' +
                        '<div class="offer-inclusion-item">' +
                        '<i class="bi bi-check-circle-fill"></i>' +
                        '<div>' +
                        '<strong class="d-block text-dark">' + inc.title + '</strong>' +
                        '<small class="text-muted">' + inc.desc + '</small>' +
                        '</div></div></div>';
                });
                incContainer.innerHTML = incHtml;
            }

            // Dates Init
            var cin = document.getElementById("offerCheckIn");
            var cout = document.getElementById("offerCheckOut");
            if (cin && cout) {
                var today = new Date();
                var tomorrow = new Date(today);
                tomorrow.setDate(tomorrow.getDate() + 1);
                var fmt = function (d) { return d.toISOString().split("T")[0]; };

                cin.min = fmt(today);
                cin.value = fmt(today);
                cout.min = fmt(tomorrow);
                cout.value = fmt(tomorrow);

                cin.addEventListener("change", function () {
                    var nxt = new Date(this.value);
                    nxt.setDate(nxt.getDate() + 1);
                    cout.min = fmt(nxt);
                    if (new Date(cout.value) <= new Date(this.value)) {
                        cout.value = fmt(nxt);
                    }
                });
            }
        });

        function handleBookThisOffer() {
            var cin = document.getElementById("offerCheckIn") ? document.getElementById("offerCheckIn").value : "";
            var cout = document.getElementById("offerCheckOut") ? document.getElementById("offerCheckOut").value : "";
            var guests = document.getElementById("offerGuests") ? document.getElementById("offerGuests").value : "2";
            var offerTitle = encodeURIComponent(currentOfferData.title);
            var offerPrice = encodeURIComponent(currentOfferData.price);

            window.location.href = "Booking.aspx?offer=" + offerTitle + "&price=" + offerPrice + "&checkIn=" + encodeURIComponent(cin) + "&checkOut=" + encodeURIComponent(cout) + "&guests=" + encodeURIComponent(guests);
        }
    </script>

</asp:Content>
