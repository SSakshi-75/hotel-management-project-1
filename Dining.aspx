<%@ Page Title="Dining & Restaurants | Hotel Management" Language="C#" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="Dining.aspx.cs" Inherits="Dining" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <!-- ==========================================
         1. HERO BANNER SECTION WITH ANIMATED HEADING & BREADCRUMB
         ========================================== -->
        <section class="amenities-compact-hero text-white"
            style="background: linear-gradient(rgba(44, 23, 5, 0.75), rgba(44, 23, 5, 0.85)), url('images/dining-royal-zafran.jpg') center/cover no-repeat;">
            <div class="container py-4 position-relative z-2" data-aos="fade-down" data-aos-duration="1000">
                <div
                    class="d-flex flex-column flex-md-row align-items-center justify-content-between text-center text-md-start">
                    <div>
                        <span class="about-intro-badge mb-2 d-inline-block py-1 px-3">
                            <i class="bi bi-stars me-1 text-warning"></i> Haute Gastronomy &amp; Fine Dining
                        </span>
                        <h1 class="display-4 font-serif fw-bold text-white mb-0">Dining &amp; Culinary Journeys</h1>
                    </div>
                    <div class="mt-3 mt-md-0">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb mb-0 page-title-breadcrumb bg-transparent p-0">
                                <li class="breadcrumb-item"><a href="index.aspx"
                                        class="text-white text-decoration-none">Home</a></li>
                                <li class="breadcrumb-item active text-gold fw-bold" aria-current="page">Dining</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
         2. CULINARY PHILOSOPHY & CHEF SHOWCASE
         ========================================== -->
        <section class="py-5" style="background-color: #faf8f5;">
            <div class="container py-4 px-3 px-lg-5">
                <div class="row align-items-center g-5">
                    <div class="col-lg-6" data-aos="fade-right" data-aos-delay="100">
                        <div class="position-relative">
                            <img src="images/indian-chef.jpg" alt="Master Executive Chef"
                                class="img-fluid rounded-4 shadow-lg w-100"
                                style="max-height: 480px; object-fit: cover;">
                            <div class="position-absolute bottom-0 start-0 m-3 p-3 rounded-3 shadow text-white"
                                style="background: rgba(68, 35, 5, 0.9); backdrop-filter: blur(8px); border-left: 4px solid #B88E68;">
                                <span
                                    class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold mb-1">Executive
                                    Master Chef</span>
                                <h5 class="font-serif mb-0 fw-bold">Chef Sanjeev Kapoor Signature Recipes</h5>
                                <small class="text-white-50">30+ Years of Royal Awadhi &amp; Global Culinary Art</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6" data-aos="fade-left" data-aos-delay="200">
                        <span class="text-uppercase fw-bold small text-gold tracking-wider d-block mb-2">
                            <i class="bi bi-award me-1"></i> The Royal Epicurean Tradition
                        </span>
                        <h2 class="display-6 font-serif fw-bold mb-3" style="color: #442305;">The Art of Imperial
                            Gastronomy</h2>
                        <p class="text-muted leading-relaxed mb-4">
                            At Grand Imperial Hotel, dining transcends ordinary sustenance into an exquisite sensory
                            celebration. Honoring centuries of royal Indian hospitality, our award-winning culinary
                            maestros curate bespoke menus combining heritage dum-pukht slow cooking with contemporary
                            world gastronomy.
                        </p>

                        <div class="row g-3 mb-4">
                            <div class="col-sm-6">
                                <div class="d-flex align-items-start gap-3 p-3 bg-white rounded-3 border">
                                    <i class="bi bi-patch-check-fill fs-3 text-warning"></i>
                                    <div>
                                        <strong class="d-block text-dark">Heritage Recipes</strong>
                                        <small class="text-muted">Secret royal court spices &amp; slow-braised
                                            delicacies</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="d-flex align-items-start gap-3 p-3 bg-white rounded-3 border">
                                    <i class="bi bi-flower1 fs-3 text-warning"></i>
                                    <div>
                                        <strong class="d-block text-dark">Farm-To-Table</strong>
                                        <small class="text-muted">Hand-sourced seasonal organic artisanal
                                            produce</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="d-flex align-items-start gap-3 p-3 bg-white rounded-3 border">
                                    <i class="bi bi-cup-hot-fill fs-3 text-warning"></i>
                                    <div>
                                        <strong class="d-block text-dark">Royal High Tea</strong>
                                        <small class="text-muted">Darjeeling single-estate leaves &amp; artisanal
                                            treats</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="d-flex align-items-start gap-3 p-3 bg-white rounded-3 border">
                                    <i class="bi bi-shield-check fs-3 text-warning"></i>
                                    <div>
                                        <strong class="d-block text-dark">Private Dining</strong>
                                        <small class="text-muted">Exclusive butler-serviced dining saloons for
                                            events</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex gap-3 flex-wrap">
                            <button type="button" class="btn btn-navbar-theme px-4 py-2.5 fw-bold"
                                onclick="openTableReservationModal('The Royal Zafran')">
                                <i class="bi bi-calendar-event me-2"></i> Reserve A Table
                            </button>
                            <a href="#signatureVenues" class="btn btn-outline-dark px-4 py-2.5 fw-bold">
                                Explore Venues <i class="bi bi-arrow-down ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- ==========================================
         3. 4 SIGNATURE DINING VENUES
         ========================================== -->
        <section id="signatureVenues" class="py-5 bg-white">
            <div class="container py-4 px-3 px-lg-5">
                <div class="text-center mb-5" data-aos="fade-up">
                    <span class="text-uppercase fw-bold small text-gold tracking-wider d-block mb-1">
                        <i class="bi bi-star-fill me-1"></i> Award-Winning Destinations
                    </span>
                    <h2 class="display-5 font-serif fw-bold" style="color: #442305;">Signature Restaurants &amp; Lounges
                    </h2>
                    <div class="title-gold-divider mx-auto my-3"></div>
                    <p class="text-muted max-w-700 mx-auto">
                        From authentic palace dum-pukht cuisine to international brasserie fare and vintage
                        single-malts, explore our acclaimed dining venues.
                    </p>
                </div>

                <!-- Venue 1: The Royal Zafran -->
                <div class="dining-venue-card mb-5" data-aos="fade-up" data-aos-delay="100">
                    <div class="row g-0 align-items-center">
                        <div class="col-lg-6">
                            <div class="dining-venue-img-wrap">
                                <img src="images/dining-royal-zafran.jpg" alt="The Royal Zafran Fine Dining"
                                    class="dining-venue-img">
                                <span class="dining-venue-badge"><i class="bi bi-crown me-1 text-warning"></i> Indian
                                    Haute Cuisine</span>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-4 p-md-5">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span
                                        class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold">Specialty
                                        Restaurant</span>
                                    <span class="text-muted small"><i class="bi bi-geo-alt me-1 text-gold"></i> Lobby
                                        Level</span>
                                </div>
                                <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">The Royal Zafran
                                </h3>
                                <p class="text-muted mb-4 leading-relaxed">
                                    An iconic destination celebrating the regal culinary treasures of Awadh, Lucknow,
                                    and the North-West Frontier. Dine beneath ornate marble arches and vintage crystal
                                    chandeliers while savouring slow-cooked Galouti kebabs, Dal Zafran, and aromatic Dum
                                    Biryanis.
                                </p>

                                <div class="row g-3 mb-4 small text-muted">
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i class="bi bi-clock me-1 text-gold"></i>
                                            Timings:</strong>
                                        Lunch: 12:30 PM &ndash; 03:30 PM<br>
                                        Dinner: 07:00 PM &ndash; 11:30 PM
                                    </div>
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i
                                                class="bi bi-person-badge me-1 text-gold"></i> Dress Code &amp;
                                            Seating:</strong>
                                        Smart Casual / Formal<br>
                                        Capacity: 90 Guests &bull; 2 Private Salons
                                    </div>
                                </div>

                                <div class="d-flex gap-3 flex-wrap">
                                    <button type="button" class="btn btn-navbar-theme px-4 py-2 fw-bold"
                                        onclick="openTableReservationModal('The Royal Zafran')">
                                        <i class="bi bi-calendar2-check me-1"></i> Reserve Table
                                    </button>
                                    <a href="#menuShowcase" class="btn btn-outline-dark px-4 py-2 fw-bold"
                                        onclick="filterMenuCategory('kebabs')">
                                        <i class="bi bi-journal-text me-1"></i> View Menu
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Venue 2: The Emperor's Pavilion -->
                <div class="dining-venue-card mb-5" data-aos="fade-up" data-aos-delay="200">
                    <div class="row g-0 align-items-center flex-lg-row-reverse">
                        <div class="col-lg-6">
                            <div class="dining-venue-img-wrap">
                                <img src="images/amenity-restaurant.jpg" alt="The Emperor's Pavilion"
                                    class="dining-venue-img">
                                <span class="dining-venue-badge"><i class="bi bi-globe me-1 text-warning"></i> All-Day
                                    World Dining</span>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-4 p-md-5">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span
                                        class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold">All-Day
                                        Dining</span>
                                    <span class="text-muted small"><i class="bi bi-geo-alt me-1 text-gold"></i> Garden
                                        Promenade</span>
                                </div>
                                <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">The Emperor's
                                    Pavilion</h3>
                                <p class="text-muted mb-4 leading-relaxed">
                                    Our vibrant, sun-drenched multi-cuisine brasserie featuring interactive live cooking
                                    theaters. Enjoy lavish international breakfast buffets, wood-fired Neapolitan
                                    pizzas, artisanal pasta, wok-tossed oriental delicacies, and classic Indian
                                    comforting curries.
                                </p>

                                <div class="row g-3 mb-4 small text-muted">
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i class="bi bi-clock me-1 text-gold"></i>
                                            Timings:</strong>
                                        Breakfast: 07:00 AM &ndash; 10:30 AM<br>
                                        All-Day: 11:00 AM &ndash; 11:00 PM
                                    </div>
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i class="bi bi-cup-straw me-1 text-gold"></i>
                                            Dining Style:</strong>
                                        Lavish Buffet &amp; À La Carte<br>
                                        Alfresco Garden Seating Available
                                    </div>
                                </div>

                                <div class="d-flex gap-3 flex-wrap">
                                    <button type="button" class="btn btn-navbar-theme px-4 py-2 fw-bold"
                                        onclick="openTableReservationModal('The Emperor\'s Pavilion')">
                                        <i class="bi bi-calendar2-check me-1"></i> Reserve Table
                                    </button>
                                    <a href="#menuShowcase" class="btn btn-outline-dark px-4 py-2 fw-bold"
                                        onclick="filterMenuCategory('mains')">
                                        <i class="bi bi-journal-text me-1"></i> View Menu
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Venue 3: Chanakya Lounge & Bar -->
                <div class="dining-venue-card mb-5" data-aos="fade-up" data-aos-delay="300">
                    <div class="row g-0 align-items-center">
                        <div class="col-lg-6">
                            <div class="dining-venue-img-wrap">
                                <img src="images/dining-lounge-bar.jpg" alt="Chanakya Lounge & Bar"
                                    class="dining-venue-img">
                                <span class="dining-venue-badge"><i class="bi bi-cup-straw me-1 text-warning"></i> High
                                    Tea &amp; Cocktails</span>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-4 p-md-5">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span
                                        class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold">Lounge
                                        &amp; Bar</span>
                                    <span class="text-muted small"><i class="bi bi-geo-alt me-1 text-gold"></i>
                                        Mezzanine Floor</span>
                                </div>
                                <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">Chanakya Lounge
                                    &amp; Bar</h3>
                                <p class="text-muted mb-4 leading-relaxed">
                                    An intimate sanctuary of refined leisure with plush emerald velvet armchairs, warm
                                    mahogany wood paneling, and soft jazz. By afternoon, delight in quintessential Royal
                                    High Tea; by evening, sip handcrafted signature botanical cocktails and rare vintage
                                    single malts.
                                </p>

                                <div class="row g-3 mb-4 small text-muted">
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i class="bi bi-clock me-1 text-gold"></i>
                                            Timings:</strong>
                                        High Tea: 04:00 PM &ndash; 06:30 PM<br>
                                        Bar Service: 06:00 PM &ndash; 01:00 AM
                                    </div>
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i
                                                class="bi bi-music-note-beamed me-1 text-gold"></i> Experience:</strong>
                                        Curated Sommelier Cellar &bull; Live Acoustic Jazz (Fri&ndash;Sun)
                                    </div>
                                </div>

                                <div class="d-flex gap-3 flex-wrap">
                                    <button type="button" class="btn btn-navbar-theme px-4 py-2 fw-bold"
                                        onclick="openTableReservationModal('Chanakya Lounge & Bar')">
                                        <i class="bi bi-calendar2-check me-1"></i> Reserve Table
                                    </button>
                                    <a href="#menuShowcase" class="btn btn-outline-dark px-4 py-2 fw-bold"
                                        onclick="filterMenuCategory('beverages')">
                                        <i class="bi bi-journal-text me-1"></i> View Menu
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Venue 4: 24/7 In-Room Private Dining -->
                <div class="dining-venue-card" data-aos="fade-up" data-aos-delay="400">
                    <div class="row g-0 align-items-center flex-lg-row-reverse">
                        <div class="col-lg-6">
                            <div class="dining-venue-img-wrap">
                                <img src="images/room-classic-double.jpg" alt="In-Room Private Dining"
                                    class="dining-venue-img">
                                <span class="dining-venue-badge"><i class="bi bi-bell-fill me-1 text-warning"></i>
                                    Round-The-Clock Service</span>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="p-4 p-md-5">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span
                                        class="badge bg-gold-subtle text-warning-dark text-uppercase small fw-bold">In-Room
                                        Dining</span>
                                    <span class="text-muted small"><i class="bi bi-door-closed me-1 text-gold"></i>
                                        Direct to Room &amp; Suite</span>
                                </div>
                                <h3 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">24/7 In-Room
                                    Gourmet Dining</h3>
                                <p class="text-muted mb-4 leading-relaxed">
                                    Enjoy silver-service culinary luxury in the comfort and privacy of your suite.
                                    Whether breakfast in bed, a midnight comfort meal, or a bespoke romantic candlelight
                                    balcony dinner, our butler service delivers perfection anytime day or night.
                                </p>

                                <div class="row g-3 mb-4 small text-muted">
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i class="bi bi-clock me-1 text-gold"></i>
                                            Service Hours:</strong>
                                        24 Hours Daily &bull; 7 Days a Week
                                    </div>
                                    <div class="col-sm-6">
                                        <strong class="d-block text-dark"><i
                                                class="bi bi-telephone-forward me-1 text-gold"></i> Ordering:</strong>
                                        Speed-dial "104" or room tablet
                                    </div>
                                </div>

                                <div class="d-flex gap-3 flex-wrap">
                                    <a href="Booking.aspx" class="btn btn-navbar-theme px-4 py-2 fw-bold">
                                        <i class="bi bi-calendar-check me-1"></i> Book A Room Stay
                                    </a>
                                    <a href="#menuShowcase" class="btn btn-outline-dark px-4 py-2 fw-bold"
                                        onclick="filterMenuCategory('mains')">
                                        <i class="bi bi-journal-text me-1"></i> Browse Menu
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <!-- ==========================================
         4. MEAL SCHEDULES & TIMINGS TABLE
         ========================================== -->
        <section class="py-5 text-white" style="background: linear-gradient(135deg, #2a1401 0%, #442305 100%);">
            <div class="container py-4 px-3 px-lg-5">
                <div class="text-center mb-5" data-aos="fade-up">
                    <span class="text-uppercase fw-bold small text-gold tracking-wider d-block mb-1">
                        <i class="bi bi-clock-history me-1"></i> Dining Schedule
                    </span>
                    <h2 class="display-5 font-serif fw-bold text-white">Daily Meal Hours &amp; Experiences</h2>
                    <div class="title-gold-divider mx-auto my-3"></div>
                    <p class="text-white-50 max-w-700 mx-auto">
                        Plan your gourmet journey with our daily meal schedule across breakfast, lunch, high tea, and
                        dinner.
                    </p>
                </div>

                <div class="row g-4 justify-content-center">

                    <!-- Breakfast -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="100">
                        <div class="meal-timing-box">
                            <div class="meal-icon-wrap"><i class="bi bi-cup-hot-fill"></i></div>
                            <h4 class="meal-title">Royal Breakfast</h4>
                            <div class="meal-time-badge">07:00 AM &ndash; 10:30 AM</div>
                            <p class="meal-desc">Grand international buffet with live dosa, egg, pancake &amp;
                                cold-pressed juice stations.</p>
                            <span class="meal-venue"><i class="bi bi-geo-alt me-1"></i> The Emperor's Pavilion</span>
                        </div>
                    </div>

                    <!-- Lunch -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="200">
                        <div class="meal-timing-box">
                            <div class="meal-icon-wrap"><i class="bi bi-sun-fill"></i></div>
                            <h4 class="meal-title">Imperial Lunch</h4>
                            <div class="meal-time-badge">12:30 PM &ndash; 03:30 PM</div>
                            <p class="meal-desc">Executive thalis, gourmet business lunch combos, and à la carte Awadhi
                                specialties.</p>
                            <span class="meal-venue"><i class="bi bi-geo-alt me-1"></i> The Royal Zafran</span>
                        </div>
                    </div>

                    <!-- High Tea -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="300">
                        <div class="meal-timing-box">
                            <div class="meal-icon-wrap"><i class="bi bi-flower2"></i></div>
                            <h4 class="meal-title">Royal High Tea</h4>
                            <div class="meal-time-badge">04:00 PM &ndash; 06:30 PM</div>
                            <p class="meal-desc">Classic British tiered scones, Indian street-delight tidbits &amp;
                                hand-plucked tea blends.</p>
                            <span class="meal-venue"><i class="bi bi-geo-alt me-1"></i> Chanakya Lounge</span>
                        </div>
                    </div>

                    <!-- Dinner -->
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="400">
                        <div class="meal-timing-box">
                            <div class="meal-icon-wrap"><i class="bi bi-moon-stars-fill"></i></div>
                            <h4 class="meal-title">Grand Dinner</h4>
                            <div class="meal-time-badge">07:00 PM &ndash; 11:30 PM</div>
                            <p class="meal-desc">Atmospheric candlelit dining, live classical sitar music, slow-braised
                                curries &amp; fine wine.</p>
                            <span class="meal-venue"><i class="bi bi-geo-alt me-1"></i> All Venues Open</span>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <!-- ==========================================
         5. INTERACTIVE MENU HIGHLIGHTS (TABS)
         ========================================== -->
        <section id="menuShowcase" class="py-5" style="background-color: #faf8f5;">
            <div class="container py-4 px-3 px-lg-5">
                <div class="text-center mb-5" data-aos="fade-up">
                    <span class="text-uppercase fw-bold small text-gold tracking-wider d-block mb-1">
                        <i class="bi bi-card-checklist me-1"></i> Curated Gastronomy
                    </span>
                    <h2 class="display-5 font-serif fw-bold" style="color: #442305;">Chef's Signature Menu</h2>
                    <div class="title-gold-divider mx-auto my-3"></div>
                    <p class="text-muted max-w-700 mx-auto">
                        Select a category below to explore signature dishes crafted daily by our master culinarians.
                    </p>

                    <!-- Category Filter Buttons (Authentic Indian Cuisine) -->
                    <div class="d-flex justify-content-center flex-wrap gap-2 mt-4" id="diningMenuFilterTabs">
                        <button type="button" class="btn btn-menu-filter active" onclick="filterMenuCategory('kebabs', this)">
                            <i class="bi bi-fire me-1"></i> Tandoori Starters &amp; Kebabs
                        </button>
                        <button type="button" class="btn btn-menu-filter" onclick="filterMenuCategory('mains', this)">
                            <i class="bi bi-egg-fried me-1"></i> Royal Indian Curries
                        </button>
                        <button type="button" class="btn btn-menu-filter" onclick="filterMenuCategory('biryani', this)">
                            <i class="bi bi-stars me-1"></i> Dum Biryani &amp; Rice
                        </button>
                        <button type="button" class="btn btn-menu-filter" onclick="filterMenuCategory('breads', this)">
                            <i class="bi bi-circle me-1"></i> Tandoori Breads &amp; Naan
                        </button>
                        <button type="button" class="btn btn-menu-filter" onclick="filterMenuCategory('desserts', this)">
                            <i class="bi bi-cake2-fill me-1"></i> Traditional Mithai &amp; Desserts
                        </button>
                        <button type="button" class="btn btn-menu-filter" onclick="filterMenuCategory('beverages', this)">
                            <i class="bi bi-cup-straw me-1"></i> Chai, Lassi &amp; Beverages
                        </button>
                    </div>
                </div>

                <!-- Menu Items Grid with Real Indian Food Imagery -->
                <div class="row g-4" id="menuItemsContainer">

                    <!-- ==========================================
                         1. TANDOORI STARTERS & KEBABS
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-paneer-tikka.jpg" alt="Tandoori Paneer Tikka" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Tandoori Paneer Tikka</h5>
                                    <span class="dish-price">&#8377;850</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-award-fill text-warning"></i> Clay Tandoor</span>
                                </div>
                                <p class="dish-desc">Fresh cottage cheese cubes marinated in Kashmiri red chili, hung curd &amp; carom seeds, skewered with bell peppers and roasted in charcoal tandoor.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up" data-aos-delay="100">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-malai-tikka.jpg" alt="Murgh Malai Tikka" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Murgh Malai Tikka</h5>
                                    <span class="dish-price">&#8377;980</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-heart-fill text-warning"></i> Chef's Special</span>
                                </div>
                                <p class="dish-desc">Tender boneless chicken morsels steeped in malai cream, grated cheese, green cardamom, and white pepper, roasted to a melt-in-mouth finish.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up" data-aos-delay="200">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-mutton-seekh.jpg" alt="Mutton Seekh Kebab" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Mutton Seekh Kebab</h5>
                                    <span class="dish-price">&#8377;1,150</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-fire text-warning"></i> Charcoal Charred</span>
                                </div>
                                <p class="dish-desc">Minced spiced lamb infused with roasted cumin, mint, coriander and onions, skewered and flame-grilled over burning charcoal, served with mint chutney.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up" data-aos-delay="300">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-hara-bhara.jpg" alt="Hara Bhara Kebab" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Hara Bhara Kebab</h5>
                                    <span class="dish-price">&#8377;720</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-patch-check-fill text-warning"></i> Palace Classic</span>
                                </div>
                                <p class="dish-desc">Crisp pan-griddled patties made with fresh spinach, green peas, mashed potatoes, and crushed roasted spices, crowned with whole cashew nut.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up" data-aos-delay="400">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-galouti-kebab.jpg" alt="Royal Awadhi Galouti Kebab" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Royal Galouti Kebab</h5>
                                    <span class="dish-price">&#8377;1,250</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-chef-sig"><i class="bi bi-crown-fill text-warning"></i> Royal Awadhi</span>
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                </div>
                                <p class="dish-desc">Silky melt-in-mouth lamb patties blended with 160 royal potli herbs, served over miniature saffron sheermal with silver vark.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col" data-menu-cat="kebabs" data-aos="fade-up" data-aos-delay="500">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-gulab-jamun.jpg" alt="Shahi Punjabi Samosa Platter" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Shahi Punjabi Samosa Platter</h5>
                                    <span class="dish-price">&#8377;420</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-shield-star-fill text-warning"></i> Crispy Royal Snack</span>
                                </div>
                                <p class="dish-desc">Handmade crisp golden pastry cones stuffed with spiced cashew, green peas, and roasted cumin potatoes, served with fresh mint and sweet tamarind chutneys.</p>
                            </div>
                        </div>
                    </div>

                    <!-- ==========================================
                         2. ROYAL INDIAN CURRIES & MAINS (5-STAR FINE DINING)
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-butter-chicken.jpg" alt="Butter Chicken (Murgh Makhani)" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Old Delhi Butter Chicken</h5>
                                    <span class="dish-price">&#8377;1,100</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-crown-fill text-warning"></i> Chef Sanjeev Special</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-warning"></i> Mild &amp; Velvety</span>
                                    <span class="badge-vessel"><i class="bi bi-shield-shaded"></i> Copper Handi</span>
                                </div>
                                <p class="dish-desc">Tandoor-charred spring chicken simmered in a slow-reduced vine tomato, cashew &amp; churned butter makhani gravy enriched with roasted kasuri methi.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Butter Garlic Naan &amp; Jeera Pulao</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-dal-makhani.jpg" alt="Dal Makhani (Bukhara Style)" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Dal Makhani (24-Hour Bukhara)</h5>
                                    <span class="dish-price">&#8377;690</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-trophy-fill text-warning"></i> ITC Bukhara Legacy</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-warning"></i> Charcoal Braised</span>
                                    <span class="badge-vessel"><i class="bi bi-shield-shaded"></i> Earthen Sigdi</span>
                                </div>
                                <p class="dish-desc">Whole black urad lentils &amp; rajma simmered over charcoal embers for 24 continuous hours, finished with fresh dairy cream &amp; white makhan.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Laccha Paratha &amp; Burani Raita</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-paneer-curry.jpg" alt="Paneer Lababdar" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Shahi Paneer Lababdar</h5>
                                    <span class="dish-price">&#8377;850</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-gem text-warning"></i> Palace Awadhi Recipe</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-warning"></i> Saffron Rich</span>
                                </div>
                                <p class="dish-desc">Handcrafted organic malai paneer steeped in a rich, buttery onion-cashew-tomato gravy, finished with micro herbs and saffron cream.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Kashmiri Zafrani Sheermal</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-nalli-nihari.jpg" alt="Imperial Nalli Nihari" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Imperial Awadhi Nalli Nihari</h5>
                                    <span class="dish-price">&#8377;1,450</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-award-fill text-warning"></i> Royal Court Heritage</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-danger"></i> Slow Potli Stew</span>
                                    <span class="badge-vessel"><i class="bi bi-shield-shaded"></i> Brass Degchi</span>
                                </div>
                                <p class="dish-desc">Prime tender lamb shanks braised overnight in a velvety spiced bone marrow reduction with ginger juliennes, green cardamom, and fresh coriander.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Tandoori Khameeri Roti &amp; Saffron Rice</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-murgh-rara.jpg" alt="Royal Murgh Rara Lucknowi" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Royal Murgh Rara Lucknowi</h5>
                                    <span class="dish-price">&#8377;1,180</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-shield-star text-warning"></i> Minced Keema &amp; Boti</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-danger"></i> Rich &amp; Robust</span>
                                </div>
                                <p class="dish-desc">Succulent chicken pieces simmered alongside aromatic hand-pounded spiced chicken keema in a slow-roasted onion-tomato brown gravy.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Butter Garlic Naan &amp; Sirka Pyaaz</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-malai-kofta.jpg" alt="Palace Malai Kofta Zafrani" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Palace Malai Kofta Zafrani</h5>
                                    <span class="dish-price">&#8377;880</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-stars text-warning"></i> Mawa &amp; Dry Fruit</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-warning"></i> Velvety Cashew</span>
                                </div>
                                <p class="dish-desc">Silken paneer and khoya dumplings stuffed with pistachios and raisins, presented in a fragrant golden saffron cashew velouté.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Kashmiri Zafrani Sheermal &amp; Jeera Rice</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-kadhai-paneer.jpg" alt="Kadhai Paneer Peshawari" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Kadhai Paneer Peshawari</h5>
                                    <span class="dish-price">&#8377;820</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-fire text-warning"></i> Pounded Khada Masala</span>
                                    <span class="badge-vessel"><i class="bi bi-shield-shaded"></i> Cast Iron Wok</span>
                                </div>
                                <p class="dish-desc">Cottage cheese chunks tossed in an iron wok with crisp bell peppers, shallots, freshly roasted whole coriander seeds, and Kashmiri dry chilies.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Amritsari Aloo Pyaaz Kulcha</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="mains">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-mutton-curry.jpg" alt="Kashmiri Mutton Rogan Josh" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Kashmiri Mutton Rogan Josh</h5>
                                    <span class="dish-price">&#8377;1,250</span>
                                </div>
                                <div class="d-flex flex-wrap gap-1 align-items-center mb-2">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-flower1 text-warning"></i> Authentic Wazwan</span>
                                    <span class="badge-spice"><i class="bi bi-fire text-danger"></i> Ratan Jot &amp; Fennel</span>
                                </div>
                                <p class="dish-desc">Slow-braised tender mountain lamb infused with natural ratan jot root, ground Kashmiri chillies, sweet fennel, and sun-dried ginger extract.</p>
                                <div class="dish-pairing-note">
                                    <i class="bi bi-sparkles text-warning"></i> Pair with: <em>Steamed Royal Basmati &amp; Butter Naan</em>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ==========================================
                         3. DUM BIRYANI & FRAGRANT RICE
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="biryani">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-royal-biryani.jpg" alt="Dum Pukht Gosht Biryani" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Dum Pukht Gosht Biryani</h5>
                                    <span class="dish-price">&#8377;1,350</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-crown-fill text-warning"></i> Handi Sealed</span>
                                </div>
                                <p class="dish-desc">Aged long-grain Basmati rice layered with spiced marinated tender mutton, saffron milk, fried barista onions &amp; mint, sealed with wheat dough.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="biryani">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-chicken-biryani.jpg" alt="Lucknowi Murgh Dum Biryani" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Lucknowi Murgh Dum Biryani</h5>
                                    <span class="dish-price">&#8377;1,150</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-nonveg"><i class="bi bi-circle-fill"></i> Non-Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-stars text-warning"></i> Awadhi Dum</span>
                                </div>
                                <p class="dish-desc">Succulent chicken morsels cooked with fragrant rice, green cardamom, sweet kewra essence, and golden desi ghee in traditional clay pot.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="biryani">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-veg-biryani.jpg" alt="Subz Chilman Biryani" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Subz Chilman Biryani</h5>
                                    <span class="dish-price">&#8377;890</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-shield-check text-warning"></i> Chef Signature</span>
                                </div>
                                <p class="dish-desc">Seasonal farm vegetables, paneer cubes, and dry fruits dum-cooked with saffron Basmati rice under a golden puff pastry lid, served with burani raita.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="biryani">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-jeera-rice.jpg" alt="Shahi Jeera Pulao" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Shahi Jeera &amp; Matar Pulao</h5>
                                    <span class="dish-price">&#8377;420</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-check2 text-warning"></i> Aromatic</span>
                                </div>
                                <p class="dish-desc">Aged Basmati rice tempered with aromatic royal cumin seeds (shahi jeera), fresh green garden peas, and clarified cow's desi ghee.</p>
                            </div>
                        </div>
                    </div>

                    <!-- ==========================================
                         4. TANDOORI BREADS & NAAN
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="breads">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-garlic-naan.jpg" alt="Butter Garlic Naan" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Butter Garlic Naan</h5>
                                    <span class="dish-price">&#8377;220</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-star text-warning"></i> Tandoor Fresh</span>
                                </div>
                                <p class="dish-desc">Hand-stretched leavened refined flour bread baked in red-hot clay tandoor, brushed with melted garlic butter and freshly chopped cilantro.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="breads">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-laccha-paratha.jpg" alt="Laccha Paratha" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Laccha Paratha (Desi Ghee)</h5>
                                    <span class="dish-price">&#8377;190</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-layers text-warning"></i> Multi-Layered</span>
                                </div>
                                <p class="dish-desc">Crisp, spiral multi-layered whole wheat flatbread rolled with pure desi ghee and roasted to a golden, flaky crust in tandoor.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="breads">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-sheermal.jpg" alt="Kashmiri Zafrani Sheermal" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Kashmiri Zafrani Sheermal</h5>
                                    <span class="dish-price">&#8377;290</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-gem text-warning"></i> Saffron Leavened</span>
                                </div>
                                <p class="dish-desc">Traditional sweet saffron-flavored royal flatbread kneaded with milk and warm ghee, baked till glowing golden.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="breads">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-cheese-naan.jpg" alt="Amritsari Aloo Pyaaz Kulcha" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Amritsari Aloo Pyaaz Kulcha</h5>
                                    <span class="dish-price">&#8377;260</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-pin-map text-warning"></i> Amritsari Special</span>
                                </div>
                                <p class="dish-desc">Flaky tandoori kulcha stuffed with spiced mashed potatoes, finely chopped onions, pomegranate seeds (anardana), and green chilies.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="breads">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-truffle-paneer.jpg" alt="Tandoori Roti" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Tandoori Roti (Whole Wheat)</h5>
                                    <span class="dish-price">&#8377;120</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-sun text-warning"></i> Healthy &amp; Fresh</span>
                                </div>
                                <p class="dish-desc">Traditional stone-ground whole wheat roti baked crisp against clay tandoor walls, served plain or brushed with yellow butter.</p>
                            </div>
                        </div>
                    </div>

                    <!-- ==========================================
                         5. TRADITIONAL MITHAI & DESSERTS
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="desserts">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-royal-dessert.jpg" alt="Shahi Tukda with 24K Gold Leaf" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Shahi Tukda with 24K Gold</h5>
                                    <span class="dish-price">&#8377;490</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-chef-sig"><i class="bi bi-crown-fill text-warning"></i> 24K Gold Leaf</span>
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                </div>
                                <p class="dish-desc">Crisp desi-ghee fried brioche soaked in cardamom saffron syrup, topped with thick reduced malai rabdi, pistachios &amp; edible 24K gold vark.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="desserts">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-royal-dessert.jpg" alt="Kesar Pista Matka Kulfi" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Kesar Pista Matka Kulfi</h5>
                                    <span class="dish-price">&#8377;420</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                    <span class="badge-chef-sig"><i class="bi bi-snow text-warning"></i> Chilled Classic</span>
                                </div>
                                <p class="dish-desc">Slow-reduced dense buffalo milk kulfi infused with Kashmiri saffron strands, whole crushed green pistachios, and roasted almond flakes in clay matka.</p>
                            </div>
                        </div>
                    </div>

                    <!-- ==========================================
                         6. CHAI, LASSI & BEVERAGES
                         ========================================== -->
                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="beverages">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-mango-lassi.jpg" alt="Kesari Mango Lassi" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Kesari Mango Lassi (Kulhad)</h5>
                                    <span class="dish-price">&#8377;290</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-mocktail"><i class="bi bi-cup-straw"></i> Chilled Drink</span>
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Alphonso Pure</span>
                                </div>
                                <p class="dish-desc">Thick hand-churned fresh curd blended with pure Alphonso mango pulp, saffron strands, and crushed green cardamom, served in earthen kulhad.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="beverages">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-masala-chai.jpg" alt="Royal Masala Chai & High Tea" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Royal Masala Chai &amp; High Tea</h5>
                                    <span class="dish-price">&#8377;320</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-chef-sig"><i class="bi bi-cup-hot-fill text-warning"></i> Kadak Chai</span>
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Assam Brew</span>
                                </div>
                                <p class="dish-desc">Full-bodied Assam single estate CTC tea boiled with fresh ginger, green cardamom, cloves, and whole milk, served with bakery shrewsbury biscuits.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="beverages">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-filter-coffee.jpg" alt="South Indian Filter Coffee" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">South Indian Filter Coffee</h5>
                                    <span class="dish-price">&#8377;260</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-chef-sig"><i class="bi bi-cup-hot text-warning"></i> Chicory Roast</span>
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Traditional Brass</span>
                                </div>
                                <p class="dish-desc">Dark roasted Chikmagalur coffee decoction brewed in traditional brass drip filter, frothed with hot creamy milk in authentic brass davarah.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 menu-item-col d-none" data-menu-cat="beverages">
                        <div class="menu-dish-card">
                            <div class="menu-dish-thumb">
                                <img src="images/food-royal-hightea.jpg" alt="Imperial Saffron Mint Mojito" class="menu-dish-img">
                            </div>
                            <div class="menu-dish-content">
                                <div class="d-flex justify-content-between align-items-baseline mb-1">
                                    <h5 class="dish-title">Imperial Saffron Mint Mojito</h5>
                                    <span class="dish-price">&#8377;390</span>
                                </div>
                                <div class="d-flex gap-2 align-items-center mb-1">
                                    <span class="badge-mocktail"><i class="bi bi-cup-straw"></i> Refreshing</span>
                                    <span class="badge-veg"><i class="bi bi-circle-fill"></i> Pure Veg</span>
                                </div>
                                <p class="dish-desc">Muddled organic mint leaves, Persian saffron reduction, fresh lime juice, crushed ice, and sparkling mineral soda garnished with edible silver vark.</p>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="text-center mt-5">
                    <button type="button" class="btn btn-navbar-theme px-5 py-3 fw-bold fs-6 shadow-sm"
                        onclick="openTableReservationModal('The Royal Zafran')">
                        <i class="bi bi-calendar2-check me-2"></i> Reserve Your Dining Experience
                    </button>
                </div>
            </div>
        </section>

        <!-- ==========================================
         6. INTERACTIVE TABLE RESERVATION MODAL
         ========================================== -->
        <div class="modal fade" id="tableReservationModal" tabindex="-1" aria-labelledby="tableReservationModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content rounded-4 border-0 shadow-lg overflow-hidden">
                    <div class="modal-header text-white p-4"
                        style="background: linear-gradient(135deg, #442305 0%, #B88E68 100%);">
                        <div>
                            <span
                                class="badge bg-dark text-gold border border-gold px-2 py-1 small mb-1 text-uppercase">Online
                                Table Booking</span>
                            <h4 class="modal-title font-serif fw-bold text-white mb-0" id="tableReservationModalLabel">
                                Reserve A Table</h4>
                        </div>
                        <button type="button" class="btn-close btn-close-white shadow-none" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>

                    <div class="modal-body p-4 bg-white">

                        <!-- Table Booking Form -->
                        <form id="tableReservationForm" onsubmit="handleTableReservationSubmit(event)">

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-shop me-1 text-gold"></i>
                                        Select Restaurant *</label>
                                    <select class="form-select" id="reserveVenueSelect" required>
                                        <option value="The Royal Zafran">The Royal Zafran (Indian Fine Dining)</option>
                                        <option value="The Emperor's Pavilion">The Emperor's Pavilion (All-Day Dining)
                                        </option>
                                        <option value="Chanakya Lounge & Bar">Chanakya Lounge &amp; Bar (Cocktails &amp;
                                            High Tea)</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i
                                            class="bi bi-people-fill me-1 text-gold"></i> Party Size *</label>
                                    <select class="form-select" id="reserveGuestsCount" required>
                                        <option value="1 Guest">1 Guest</option>
                                        <option value="2 Guests" selected>2 Guests</option>
                                        <option value="3 Guests">3 Guests</option>
                                        <option value="4 Guests">4 Guests</option>
                                        <option value="5-8 Guests">5&ndash;8 Guests (Family Table)</option>
                                        <option value="9+ Guests">9+ Guests (Private Dining Salon)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i
                                            class="bi bi-calendar-event me-1 text-gold"></i> Reservation Date *</label>
                                    <input type="date" class="form-control" id="reserveDate" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-clock me-1 text-gold"></i>
                                        Preferred Time Slot *</label>
                                    <select class="form-select" id="reserveTimeSlot" required>
                                        <option value="12:30 PM">12:30 PM (Lunch)</option>
                                        <option value="01:30 PM">01:30 PM (Lunch)</option>
                                        <option value="02:30 PM">02:30 PM (Lunch)</option>
                                        <option value="04:30 PM">04:30 PM (High Tea)</option>
                                        <option value="07:00 PM" selected>07:00 PM (Dinner)</option>
                                        <option value="08:00 PM">08:00 PM (Dinner)</option>
                                        <option value="09:00 PM">09:00 PM (Dinner)</option>
                                        <option value="10:00 PM">10:00 PM (Late Dinner)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-12">
                                    <label class="form-label fw-semibold"><i class="bi bi-person me-1 text-gold"></i>
                                        Guest Full Name *</label>
                                    <input type="text" class="form-control" id="reserveGuestName"
                                        placeholder="Full name as per ID" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-envelope me-1 text-gold"></i>
                                        Email Address *</label>
                                    <input type="email" class="form-control" id="reserveGuestEmail"
                                        placeholder="name@example.com" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-telephone me-1 text-gold"></i>
                                        Mobile Number *</label>
                                    <input type="tel" class="form-control" id="reserveGuestPhone"
                                        placeholder="+91 98765 43210" required>
                                </div>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-stars me-1 text-gold"></i>
                                        Special Occasion</label>
                                    <select class="form-select" id="reserveOccasion">
                                        <option value="None" selected>Casual Dining</option>
                                        <option value="Birthday">Birthday Celebration</option>
                                        <option value="Anniversary">Anniversary</option>
                                        <option value="Business">Business Dinner</option>
                                        <option value="Romantic">Romantic Candlelight</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold"><i class="bi bi-geo me-1 text-gold"></i>
                                        Seating Preference</label>
                                    <select class="form-select" id="reserveSeating">
                                        <option value="Indoor Royal Hall" selected>Indoor Royal Hall</option>
                                        <option value="Window City View">Window City View Table</option>
                                        <option value="Alfresco Terrace">Alfresco Garden Terrace</option>
                                        <option value="Private Dining Salon">Private Dining Salon</option>
                                    </select>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label fw-semibold"><i
                                            class="bi bi-chat-left-text me-1 text-gold"></i> Dietary Preferences &amp;
                                        Special Requests</label>
                                    <textarea class="form-control" id="reserveSpecialNotes" rows="2"
                                        placeholder="e.g. Jain food, nut allergy, cake arrangement, quiet table..."></textarea>
                                </div>
                            </div>

                            <div class="p-3 rounded-3 mb-4 small"
                                style="background: #faf8f5; border: 1px dashed #B88E68;">
                                <i class="bi bi-info-circle text-gold me-1"></i>
                                <strong>Table Hold Policy:</strong> Reservations are held for 15 minutes beyond your
                                scheduled time. No advance deposit required.
                            </div>

                            <div class="d-flex gap-3 justify-content-end">
                                <button type="button" class="btn btn-outline-dark px-4 py-2"
                                    data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-navbar-theme px-4 py-2 fw-bold">
                                    <i class="bi bi-check-circle me-1"></i> Confirm Table Reservation
                                </button>
                            </div>
                        </form>

                        <!-- Table Confirmation Voucher (Revealed upon submit) -->
                        <div id="tableConfirmationVoucher" class="d-none text-center p-4 rounded-3 border"
                            style="background: #faf8f5; border-color: #B88E68 !important;">
                            <span
                                class="badge bg-success text-white px-3 py-2 text-uppercase fw-bold rounded-pill mb-3">
                                <i class="bi bi-check2-circle me-1"></i> Table Confirmed &amp; Reserved
                            </span>
                            <h4 class="font-serif fw-bold display-6 mb-2" style="color: #442305;">Royal Table Reserved
                            </h4>
                            <p class="text-muted small mb-4">We are pleased to confirm your dining reservation. A
                                confirmation SMS &amp; email have been sent.</p>

                            <div class="bg-white p-3 rounded-3 border text-start mb-4 shadow-sm">
                                <div class="row g-2 small">
                                    <div class="col-6">
                                        <span class="text-muted text-uppercase d-block"
                                            style="font-size: 0.7rem;">Reservation Ref #</span>
                                        <strong class="fs-6" style="color: #B88E68;"
                                            id="tblConfRef">HM-TBL-89210</strong>
                                    </div>
                                    <div class="col-6">
                                        <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Guest
                                            Name</span>
                                        <strong class="fs-6 text-dark" id="tblConfGuest">Mr. Guest</strong>
                                    </div>
                                    <div class="col-6 mt-2">
                                        <span class="text-muted text-uppercase d-block"
                                            style="font-size: 0.7rem;">Restaurant</span>
                                        <strong class="text-dark" id="tblConfVenue">The Royal Zafran</strong>
                                    </div>
                                    <div class="col-6 mt-2">
                                        <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Date
                                            &amp; Time</span>
                                        <strong class="text-dark" id="tblConfDateTime">Today &bull; 07:00 PM</strong>
                                    </div>
                                    <div class="col-6 mt-2">
                                        <span class="text-muted text-uppercase d-block" style="font-size: 0.7rem;">Party
                                            Size</span>
                                        <strong class="text-dark" id="tblConfGuests">2 Guests</strong>
                                    </div>
                                    <div class="col-6 mt-2">
                                        <span class="text-muted text-uppercase d-block"
                                            style="font-size: 0.7rem;">Seating</span>
                                        <strong class="text-dark" id="tblConfSeating">Indoor Royal Hall</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex gap-2 justify-content-center">
                                <button type="button" class="btn btn-outline-dark px-4 py-2 small fw-bold"
                                    onclick="window.print()">
                                    <i class="bi bi-printer me-1"></i> Print Pass
                                </button>
                                <button type="button" class="btn btn-navbar-theme px-4 py-2 small fw-bold"
                                    data-bs-dismiss="modal">
                                    Close Window
                                </button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Dining Javascript Engine -->
        <script src="js/dining.js"></script>

    </asp:Content>