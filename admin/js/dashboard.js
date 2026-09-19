/**
 * Hotel Management System - Executive Admin Dashboard JavaScript
 * Charts, Live Clock, Sidebar Controls & Interactivity
 */

document.addEventListener('DOMContentLoaded', function () {
    checkLoginConfirmation();
    initSidebar();
    initLiveClockAndDate();
    initFullscreenToggle();
    initBookingsChart();
    initRoomStatusDonutChart();
});

// ==========================================
// 1. SIDEBAR TOGGLE (DESKTOP & MOBILE)
// ==========================================
// Global Accordion Submenu Toggle Function
window.toggleSubmenu = function (elem) {
    if (!elem) return false;
    var parentItem = elem.closest ? elem.closest('.has-submenu') : elem.parentElement;
    if (parentItem) {
        var isOpen = parentItem.classList.contains('open');
        
        var allItems = document.querySelectorAll('.sidebar-nav-list .has-submenu');
        for (var i = 0; i < allItems.length; i++) {
            allItems[i].classList.remove('open');
            var sub = allItems[i].querySelector('.sidebar-submenu');
            if (sub) sub.style.display = 'none';
        }

        if (!isOpen) {
            parentItem.classList.add('open');
            var currentSub = parentItem.querySelector('.sidebar-submenu');
            if (currentSub) currentSub.style.display = 'block';
        }
    }
    return false;
};

function initSidebar() {
    var sidebar = document.getElementById('adminSidebar');
    var toggleBtn = document.getElementById('sidebarToggleBtn');
    var closeBtn = document.getElementById('sidebarCloseBtn');
    var overlay = document.getElementById('sidebarOverlay');

    function openSidebar() {
        if (sidebar) sidebar.classList.add('open');
        if (overlay) overlay.classList.add('active');
        document.body.style.overflow = window.innerWidth < 992 ? 'hidden' : '';
    }

    function closeSidebar() {
        if (sidebar) sidebar.classList.remove('open');
        if (overlay) overlay.classList.remove('active');
        document.body.style.overflow = '';
    }

    if (toggleBtn) {
        toggleBtn.addEventListener('click', function () {
            if (sidebar && sidebar.classList.contains('open')) {
                closeSidebar();
            } else {
                openSidebar();
            }
        });
    }

    if (closeBtn) closeBtn.addEventListener('click', closeSidebar);
    if (overlay) overlay.addEventListener('click', closeSidebar);

    window.addEventListener('resize', function () {
        if (window.innerWidth >= 992) closeSidebar();
    });

    document.addEventListener('click', function (e) {
        var subToggle = e.target.closest('.submenu-toggle');
        if (subToggle) {
            e.preventDefault();
            e.stopPropagation();
            window.toggleSubmenu(subToggle);
        }
    });

    highlightActiveSidebarMenu();
}

// ==========================================
// 2. LIVE DATE & TIME IN HERO PANEL
// ==========================================
function initLiveClockAndDate() {
    var dateElem = document.getElementById('heroDateText');
    var timeElem = document.getElementById('heroTimeText');

    function updateDateTime() {
        var now = new Date();

        // Format Date: e.g. "Tue, 16 Sep 2025"
        var days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

        var dayName = days[now.getDay()];
        var monthName = months[now.getMonth()];
        var dayNum = now.getDate();
        var year = now.getFullYear();

        if (dateElem) {
            dateElem.textContent = dayName + ', ' + dayNum + ' ' + monthName + ' ' + year;
        }

        // Format Time: e.g. "11:42 AM"
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var ampm = hours >= 12 ? 'PM' : 'AM';

        hours = hours % 12;
        hours = hours ? hours : 12;
        var minStr = minutes < 10 ? '0' + minutes : minutes;

        if (timeElem) {
            timeElem.textContent = hours + ':' + minStr + ' ' + ampm;
        }
    }

    updateDateTime();
    setInterval(updateDateTime, 1000);
}

// ==========================================
// 3. FULLSCREEN TOGGLE
// ==========================================
function initFullscreenToggle() {
    var btn = document.getElementById('fullscreenToggleBtn');
    if (!btn) return;

    btn.addEventListener('click', function () {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(function () { });
        } else {
            if (document.exitFullscreen) {
                document.exitFullscreen().catch(function () { });
            }
        }
    });
}

// ==========================================
// 4. CHART.JS: BOOKINGS OVERVIEW (SPLINE AREA)
// ==========================================
function initBookingsChart() {
    var canvas = document.getElementById('bookingsOverviewChart');
    if (!canvas || typeof Chart === 'undefined') return;

    var ctx = canvas.getContext('2d');

    // Create golden gradient fill
    var gradient = ctx.createLinearGradient(0, 0, 0, 240);
    gradient.addColorStop(0, 'rgba(184, 142, 104, 0.45)');
    gradient.addColorStop(0.7, 'rgba(184, 142, 104, 0.15)');
    gradient.addColorStop(1, 'rgba(184, 142, 104, 0.0)');

    // Generate dynamic date labels for the last 7 days
    var dayLabels = [];
    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    for (var i = 6; i >= 0; i--) {
        var d = new Date();
        d.setDate(d.getDate() - i);
        dayLabels.push(months[d.getMonth()] + ' ' + d.getDate());
    }

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: dayLabels,
            datasets: [{
                label: 'Bookings',
                data: [0, 0, 0, 0, 0, 0, 0],
                borderColor: '#B88E68',
                borderWidth: 2.5,
                backgroundColor: gradient,
                fill: true,
                tension: 0.45,
                pointRadius: 4,
                pointHoverRadius: 6,
                pointBackgroundColor: '#B88E68',
                pointBorderColor: '#ffffff',
                pointBorderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: '#0f172a',
                    titleColor: '#ffffff',
                    bodyColor: '#e2e8f0',
                    padding: 10,
                    cornerRadius: 8,
                    callbacks: {
                        label: function (context) {
                            return ' ' + context.parsed.y + ' Bookings';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: {
                        font: { family: 'Plus Jakarta Sans', size: 11 },
                        color: '#94a3b8'
                    }
                },
                y: {
                    min: 0,
                    max: 10,
                    ticks: {
                        stepSize: 2,
                        font: { family: 'Plus Jakarta Sans', size: 11 },
                        color: '#94a3b8'
                    },
                    grid: {
                        color: '#f1f5f9',
                        drawBorder: false
                    }
                }
            }
        }
    });
}

// ==========================================
// 5. CHART.JS: ROOM STATUS (DOUGHNUT)
// ==========================================
function initRoomStatusDonutChart() {
    var canvas = document.getElementById('roomStatusDonutChart');
    if (!canvas || typeof Chart === 'undefined') return;

    var ctx = canvas.getContext('2d');

    // Clean neutral empty-state ring when no room records are present
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['No Active Rooms'],
            datasets: [{
                data: [1],
                backgroundColor: ['#e2e8f0'],
                borderWidth: 0,
                hoverOffset: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '76%',
            plugins: {
                legend: { display: false },
                tooltip: {
                    enabled: false
                }
            }
        }
    });
}

// ==========================================
// 6. TOAST FEEDBACK FOR QUICK ACTIONS & MENUS
// ==========================================
function showAdminToast(title, message, iconClass) {
    iconClass = iconClass || 'bi-info-circle-fill text-gold';
    var container = document.getElementById('adminToastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'adminToastContainer';
        container.style.position = 'fixed';
        container.style.bottom = '24px';
        container.style.right = '24px';
        container.style.zIndex = '9999';
        document.body.appendChild(container);
    }

    var toast = document.createElement('div');
    toast.className = 'toast show align-items-center mb-2 bg-white shadow-lg border rounded-3';
    toast.style.minWidth = '280px';
    toast.innerHTML = `
        <div class="d-flex p-3 align-items-center">
            <div class="me-3 fs-5">
                <i class="bi ${iconClass}"></i>
            </div>
            <div class="flex-grow-1">
                <strong class="d-block text-dark small mb-0">${title}</strong>
                <span class="text-muted" style="font-size: 0.75rem;">${message}</span>
            </div>
            <button type="button" class="btn-close ms-2 m-auto" onclick="this.closest('.toast').remove()"></button>
        </div>
    `;

    container.appendChild(toast);

    setTimeout(function () {
        if (toast && toast.parentNode) {
            toast.remove();
        }
    }, 4000);
}

window.handleMenuClick = function (featureName, elem) {
    if (elem) {
        document.querySelectorAll('.sidebar-nav-list .nav-link').forEach(function (l) {
            l.classList.remove('active');
        });
        elem.classList.add('active');
    }
    showAdminToast(
        featureName + ' Module',
        'Viewing ' + featureName + '. Real-time synchronization active.',
        'bi-layers text-primary'
    );
};

window.triggerQuickAction = function (actionType) {
    switch (actionType) {
        case 'new-reservation':
            showAdminToast('New Reservation', 'Opening reservation wizard for guests.', 'bi-calendar-plus text-warning');
            break;
        case 'block-room':
            showAdminToast('Room Maintenance', 'Maintenance block mode active.', 'bi-door-closed text-primary');
            break;
        case 'export-report':
            showAdminToast('Export Report', 'Generating revenue and occupancy report...', 'bi-bar-chart-line text-success');
            break;
        default:
            showAdminToast('Action Triggered', 'Processing administrative command.', 'bi-check-circle text-success');
    }
};

// ==========================================
// 7. LOGIN SUCCESS CONFIRMATION (ON-PAGE, NO POPUP)
// ==========================================
function checkLoginConfirmation() {
    try {
        var isLoginSuccess = sessionStorage.getItem('adminLoginSuccess');
        if (isLoginSuccess === 'true') {
            sessionStorage.removeItem('adminLoginSuccess');
            var banner = document.getElementById('loginSuccessBanner');
            if (banner) {
                banner.classList.remove('d-none');
                banner.classList.add('d-flex');

                // Auto dismiss gently after 5 seconds
                setTimeout(function () {
                    if (banner && banner.parentNode) {
                        banner.classList.remove('show');
                        setTimeout(function () { banner.remove(); }, 350);
                    }
                }, 5000);
            }
        }
    } catch (e) { }
}

// Auto highlight active sidebar navigation link based on URL and SessionStorage
function highlightActiveSidebarMenu() {
    var path = (window.location.pathname + window.location.search).toLowerCase();
    var href = window.location.href.toLowerCase();
    var links = document.querySelectorAll('.sidebar-nav-list .nav-link, .sidebar-submenu .submenu-link');
    var activeMatched = false;

    // Clear active class on all links first
    links.forEach(function (l) { l.classList.remove('active'); });

    links.forEach(function (link) {
        var linkHref = (link.getAttribute('href') || '').toLowerCase();
        var dataPage = (link.getAttribute('data-page') || '').toLowerCase();

        if (linkHref && linkHref !== 'javascript:void(0)') {
            var cleanHref = linkHref.replace('../', '').replace('./', '');
            var pageBase = cleanHref.replace('.aspx', '');

            if (
                !activeMatched && (
                    path.endsWith('/' + cleanHref) ||
                    path.indexOf('/' + cleanHref) !== -1 ||
                    href.indexOf('/' + cleanHref) !== -1 ||
                    (pageBase && (path.indexOf('/' + pageBase) !== -1 || href.indexOf('/' + pageBase) !== -1)) ||
                    (dataPage && (path.indexOf(dataPage) !== -1 || href.indexOf(dataPage) !== -1))
                )
            ) {
                link.classList.add('active');
                activeMatched = true;

                // Auto expand parent submenu without highlighting parent button
                var parentSub = link.closest('.has-submenu');
                if (parentSub) {
                    parentSub.classList.add('open');
                }
            }
        }
    });

    if (!activeMatched) {
        var dashLink = document.querySelector('.sidebar-nav-list .nav-link[data-page="dashboard.aspx"]');
        if (dashLink) {
            dashLink.classList.add('active');
        }
    }
}

// Store clicked menu item in sessionStorage and manage single active state
document.addEventListener('click', function (e) {
    var link = e.target.closest('.sidebar-nav-list .nav-link, .sidebar-submenu .submenu-link');
    if (link) {
        var page = link.getAttribute('data-page') || link.getAttribute('href');
        if (page && page !== 'javascript:void(0)') {
            sessionStorage.setItem('adminActiveMenu', page.toLowerCase());
        }
        document.querySelectorAll('.sidebar-nav-list .nav-link, .sidebar-submenu .submenu-link').forEach(function (l) {
            l.classList.remove('active');
        });
        link.classList.add('active');
    }
});

// ==========================================
// 8. REGISTERED GUESTS & LOGIN DIRECTORY FILTERS
// ==========================================
function toggleDatabaseGuests() {
    var panel = document.getElementById('databaseGuestsPanel');
    if (panel) {
        panel.scrollIntoView({ behavior: 'smooth' });
    }
}

function filterRegisteredGuests() {
    var input = document.getElementById('userSearchInput');
    var table = document.querySelector('[id$="gvUsers"]');
    if (!input || !table) return;

    var query = input.value.trim().toLowerCase();
    var rows = table.querySelectorAll('tr');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (row.querySelector('th')) continue;
        var text = row.textContent.toLowerCase();
        row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
    }
}

function filterLoginDirectory() {
    var input = document.getElementById('loginSearchInput');
    var table = document.querySelector('[id$="gvLogins"]');
    if (!input || !table) return;

    var query = input.value.trim().toLowerCase();
    var rows = table.querySelectorAll('tr');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        if (row.querySelector('th')) continue;
        var text = row.textContent.toLowerCase();
        row.style.display = (query === '' || text.includes(query)) ? '' : 'none';
    }
}

