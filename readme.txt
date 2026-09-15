================================================================================
                    THE ROYAL PALACE HOTEL & RESORT
               Enterprise Hotel Management System (ASP.NET)
================================================================================

PROJECT OVERVIEW
--------------------------------------------------------------------------------
The Royal Palace Hotel Management System is a full-featured, enterprise-grade 
web application built using ASP.NET Web Forms (C#) and SQL Server. It delivers 
an opulent, responsive user interface for luxury guests alongside a robust 
admin portal for managing reservations, rooms, dining inquiries, and user 
accounts.

Key Highlights:
- Royal Gold & Deep Mahogany UI Theme (#B88E68 / #442305)
- Interactive 5-Column Room & Rate Plan Selector with Sticky "YOUR STAY" Summary
- Secure PBKDF2 / SHA-256 Hashed Guest & Admin Authentication
- Real-time Date & Price Calculations (Nights x Rates + 18% GST)
- Admin Management Dashboard with Real-time Operational Metrics
- Responsive Bootstrap 5 + Swiper.js + AOS Motion Design

================================================================================
TECHNOLOGY STACK
================================================================================
Backend Framework   : ASP.NET Web Forms (.NET Framework 4.8 / C#)
Database            : Microsoft SQL Server (MDF / LocalDB)
Frontend Framework  : HTML5, CSS3, JavaScript (ES6+), jQuery
Styling & Grid      : Bootstrap 5.3, Custom Luxury CSS Architecture
Icons & Assets      : Bootstrap Icons, FontAwesome 6, Google Fonts (Playfair Display)
Animations & Sliders: Swiper.js 9, AOS (Animate on Scroll)
Server Requirements : IIS / IIS Express, .NET Framework 4.8 runtime

================================================================================
PROJECT ARCHITECTURE & FILE STRUCTURE
================================================================================
Hotel-Management-Project-1/
│
├── MasterPage.master          # Global Master Page (Luxury Header, Brand Logo, 
│                              # Nav Menu, Footer Links & Newsletter)
├── MasterPage.master.cs       # Master Page Code-Behind
├── Web.config                 # Database Connection Strings & App Settings
├── style.css                  # Core Brand Styling & Color System
│
├── PUBLIC GUEST PORTAL
│   ├── index.aspx             # Hero Banner Slider, Rooms Preview, Dining Highlights
│   ├── Room.aspx              # Interactive Room Category & Rate Plan Booking System
│   ├── RoomDetails.aspx       # Comprehensive Room Specifications & Booking Form
│   ├── Dining.aspx            # Gourmet Fine Dining, Menus & Table Reservations
│   ├── About.aspx             # Royal Heritage Story, Legacy & Awards
│   ├── Offers.aspx            # Seasonal Packages, Promo Codes & Special Rates
│   ├── Amenities.aspx         # Spa, Infinity Pool, Banquet & Butler Services
│   ├── Contact.aspx           # Interactive Contact Form & Location Map
│   ├── Login.aspx             # Guest User Authentication & Portal Access
│   └── Register.aspx          # New Guest Registration with Input Validation
│
├── ADMIN MANAGEMENT PORTAL
│   └── admin/
│       ├── Login.aspx         # Secure Admin Authentication Panel
│       ├── Login.aspx.cs      # Admin Login Controller with Hashed Verification
│       ├── Dashboard.aspx     # Operational Dashboard (Bookings, Revenue, Users)
│       ├── js/
│       │   ├── dashboard.js   # Admin Chart & Metric Renderers
│       │   └── login.js       # Admin Login Form Interactivity
│       └── css/
│           └── admin.css      # Dark Luxury Dashboard Styles
│
└── ASSETS & STORAGE
    ├── images/                # Transparent Logos, Room Thumbs & Banners
    ├── js/                    # Client-side Scripts & Date Utility Handlers
    └── App_Data/              # Local SQL Server MDF Database Instance

================================================================================
CORE FEATURES & MODULES
================================================================================

1. GUEST PORTAL & LUXURY EXPERIENCE
   -----------------------------------------------------------------------------
   * Hero Carousel Banner : Dynamic slider featuring high-resolution resort views 
                            and quick search filters.
   * Rooms & Rates Page   : Interactive filtering by category (Suites, Deluxe, 
                            Executive). Multi-rate selection (Member Rate vs 
                            Standard Rate).
   * Sticky "YOUR STAY"   : Dynamic sidebar tracking Check-In/Check-Out dates, 
     Summary Card           number of guests, room base rate, 18% GST tax, and 
                            grand total in real time.
   * Fine Dining Portal   : Interactive restaurant reservations, downloadable 
                            gourmet menus, and seating preferences.
   * Guest Registration   : Client and server-side validated sign-up flow with 
                            secure password hashing.

2. SECURE AUTHENTICATION & SECURITY
   -----------------------------------------------------------------------------
   * Password Security    : PBKDF2 / SHA-256 cryptographic salt & hash storage.
   * Parameterized SQL    : Protection against SQL Injection using SqlCommand 
                            parameters across all ASP.NET code-behind files.
   * Session Management   : Isolated ASP.NET Session variables for Guests and 
                            Admins (`Session["UserEmail"]`, `Session["AdminUser"]`).
   * SSL & SSL Badging    : Visual 256-bit SSL trust indicators across reservation 
                            workflows.

3. ADMIN DASHBOARD & CONTROLS
   -----------------------------------------------------------------------------
   * Operational Metrics  : Total Bookings, Monthly Revenue, Occupancy Rate, and 
                            Active Guests.
   * Reservation Table    : Live grid listing recent reservations with status 
                            indicators (Confirmed, Pending, Cancelled).
   * Transparent Branding : Integrated dark-themed logo matching admin navbar.

================================================================================
DATABASE SETUP & INSTALLATION
================================================================================

1. PREREQUISITES
   - Microsoft Visual Studio 2019 / 2022 (with ASP.NET & Web Development workload)
   - .NET Framework 4.8 SDK
   - IIS Express or Local IIS Server
   - Microsoft SQL Server / Express Edition

2. RUNNING THE APPLICATION IN VISUAL STUDIO
   Step 1 : Clone / Open `Hotel-Management-Project-1` directory in Visual Studio.
   Step 2 : Ensure SQL Server Express / LocalDB instance is running.
   Step 3 : Verify Connection String in `Web.config`:
            <add name="HotelDB" 
                 connectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\HotelDB.mdf;Integrated Security=True" 
                 providerName="System.Data.SqlClient" />
   Step 4 : Press `F5` or click `IIS Express` to start debugging on `http://localhost:54858`.

3. DEFAULT ADMIN ACCESS
   - Admin Access     : Configured via secure Admin Portal
   - Account Security : Managed via encrypted credentials in `HotelDB.mdf`

================================================================================
VERIFICATION & QUALITY ASSURANCE
================================================================================
- Cross-Browser Compatibility : Tested on Chrome, Firefox, Edge, and Safari.
- Responsive Design Breakdown : Mobile (320px - 767px), Tablet (768px - 1024px), 
                                Desktop (1025px+).
- W3C HTML5 Verification      : Valid semantic markup and clean ARIA attributes.
- ASP.NET Runtime Verification: Clean compilation with 0 syntax or runtime errors.

================================================================================
DEVELOPER NOTE & MAINTENANCE
================================================================================
Maintained by: Senior Engineering Team
Project Code : SSakshi-75/hotel-management-project-1
Version      : 5.0.0 (Production Release)
Last Updated : September 2026
================================================================================
