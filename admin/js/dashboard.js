/**
 * Hotel Management System - Executive Admin Dashboard JavaScript
 * Client-side Interactivity & Management Functions
 */

document.addEventListener('DOMContentLoaded', function () {
    initSidebar();
    initLiveClock();
    initBookingTableFilters();
    initRoomMatrixFilters();
    initGlobalSearchShortcut();
});

// ==========================================
// 1. SIDEBAR TOGGLE & MOBILE DRAWER
// ==========================================
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

    if (closeBtn) {
        closeBtn.addEventListener('click', closeSidebar);
    }

    if (overlay) {
        overlay.addEventListener('click', closeSidebar);
    }

    window.addEventListener('resize', function () {
        if (window.innerWidth >= 992) {
            closeSidebar();
        }
    });
}

// ==========================================
// 2. LIVE CLOCK (IST)
// ==========================================
function initLiveClock() {
    var clockElem = document.getElementById('liveClockDisplay');
    if (!clockElem) return;

    function updateTime() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        var ampm = hours >= 12 ? 'PM' : 'AM';

        hours = hours % 12;
        hours = hours ? hours : 12; // 0 becomes 12
        var hStr = hours < 10 ? '0' + hours : hours;
        var mStr = minutes < 10 ? '0' + minutes : minutes;
        var sStr = seconds < 10 ? '0' + seconds : seconds;

        clockElem.textContent = hStr + ':' + mStr + ':' + sStr + ' ' + ampm + ' IST';
    }

    updateTime();
    setInterval(updateTime, 1000);
}

// ==========================================
// 3. BOOKINGS TABLE SEARCH & STATUS FILTER
// ==========================================
function initBookingTableFilters() {
    var searchInput = document.getElementById('tableSearchInput');
    var filterBtns = document.querySelectorAll('.booking-filter-btn');
    var tableRows = document.querySelectorAll('#recentBookingsTable tbody tr:not(#emptyBookingsRow):not(#noBookingsRow)');
    var emptyRow = document.getElementById('emptyBookingsRow');
    var noResultsRow = document.getElementById('noBookingsRow');

    var currentFilter = 'all';
    var currentSearch = '';

    function applyFilters() {
        if (tableRows.length === 0) {
            if (emptyRow) emptyRow.style.display = '';
            if (noResultsRow) noResultsRow.style.display = 'none';
            return;
        }

        var visibleCount = 0;
        tableRows.forEach(function (row) {
            var rowStatus = (row.getAttribute('data-status') || '').toLowerCase();
            var rowText = row.textContent.toLowerCase();

            var matchesStatus = (currentFilter === 'all' || rowStatus === currentFilter);
            var matchesSearch = (currentSearch === '' || rowText.includes(currentSearch));

            if (matchesStatus && matchesSearch) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        if (emptyRow) emptyRow.style.display = 'none';
        if (noResultsRow) {
            noResultsRow.style.display = visibleCount === 0 ? '' : 'none';
        }
    }

    if (searchInput) {
        searchInput.addEventListener('input', function (e) {
            currentSearch = e.target.value.trim().toLowerCase();
            applyFilters();
        });
    }

    filterBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            filterBtns.forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            currentFilter = btn.getAttribute('data-filter').toLowerCase();
            applyFilters();
        });
    });
}

// ==========================================
// 4. ROOM MATRIX STATUS FILTERS
// ==========================================
function initRoomMatrixFilters() {
    var roomFilterBtns = document.querySelectorAll('.room-filter-btn');
    var roomCards = document.querySelectorAll('#roomStatusGrid .room-col-item');

    roomFilterBtns.forEach(function (btn) {
        btn.addEventListener('click', function () {
            roomFilterBtns.forEach(function (b) { b.classList.remove('active'); });
            btn.classList.add('active');
            var filter = btn.getAttribute('data-room-filter');

            roomCards.forEach(function (card) {
                var status = card.getAttribute('data-room-status');
                if (filter === 'all' || status === filter) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
}

// ==========================================
// 5. GLOBAL SEARCH SHORTCUT (⌘K or Ctrl+K)
// ==========================================
function initGlobalSearchShortcut() {
    var searchInput = document.getElementById('adminGlobalSearch');
    if (!searchInput) return;

    document.addEventListener('keydown', function (e) {
        if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === 'k') {
            e.preventDefault();
            searchInput.focus();
        }
    });

    // When global search receives input, sync with table search
    searchInput.addEventListener('input', function (e) {
        var tableSearch = document.getElementById('tableSearchInput');
        if (tableSearch) {
            tableSearch.value = e.target.value;
            tableSearch.dispatchEvent(new Event('input'));
        }
    });
}

// ==========================================
// 6. QUICK ACTIONS & TOAST FEEDBACK
// ==========================================
function showLuxuryToast(title, message, iconClass) {
    iconClass = iconClass || 'bi-info-circle-fill text-gold';
    var container = document.getElementById('adminToastContainer');
    if (!container) {
        container = document.createElement('div');
        container.id = 'adminToastContainer';
        container.className = 'admin-toast-container';
        document.body.appendChild(container);
    }

    var toast = document.createElement('div');
    toast.className = 'toast show luxury-toast align-items-center mb-2';
    toast.setAttribute('role', 'alert');
    toast.innerHTML = `
        <div class="d-flex p-3">
            <div class="me-3 fs-5">
                <i class="bi ${iconClass}"></i>
            </div>
            <div class="toast-body p-0 flex-grow-1">
                <strong class="d-block text-gold mb-1">${title}</strong>
                <span class="small text-light">${message}</span>
            </div>
            <button type="button" class="btn-close btn-close-white ms-2 m-auto" aria-label="Close" onclick="this.closest('.toast').remove()"></button>
        </div>
    `;

    container.appendChild(toast);

    setTimeout(function () {
        if (toast && toast.parentNode) {
            toast.classList.remove('show');
            setTimeout(function () { toast.remove(); }, 300);
        }
    }, 4500);
}

// Global helper for menu clicks
window.handleMenuClick = function (featureName) {
    showLuxuryToast(
        featureName + ' Console',
        'Viewing operational module: ' + featureName + '. Live sync active with central database.',
        'bi-layers-fill text-gold'
    );
};

// Global helper for Quick Actions
window.triggerQuickAction = function (actionType) {
    switch (actionType) {
        case 'new-reservation':
            showLuxuryToast(
                'New Reservation Engine',
                'Opening VIP Reservation wizard for Chanakyapuri property.',
                'bi-calendar-plus text-gold'
            );
            break;
        case 'quick-checkin':
            showLuxuryToast(
                'Front Desk Express Check-in',
                'Ready for biometric & keycard dispensing. Select incoming reservation below.',
                'bi-person-check-fill text-success'
            );
            break;
        case 'block-room':
            showLuxuryToast(
                'Room Inventory Control',
                'Maintenance hold modal initiated for selected suites.',
                'bi-shield-exclamation text-warning'
            );
            break;
        case 'export-report':
            showLuxuryToast(
                'Exporting Daily Briefing',
                'Generating Executive Revenue & Occupancy Report (PDF)...',
                'bi-file-earmark-pdf-fill text-danger'
            );
            break;
        default:
            showLuxuryToast('Action Triggered', 'Processing administrative instruction.', 'bi-check-circle');
    }
};

window.checkInGuest = function (guestName, roomNo) {
    showLuxuryToast(
        'Check-In Successful',
        guestName + ' successfully assigned to Room ' + roomNo + '. Welcome amenities dispatched.',
        'bi-check-circle-fill text-success'
    );
};

window.viewFolio = function (bookingId) {
    showLuxuryToast(
        'Guest Folio ' + bookingId,
        'Opening billing details, incidentals, and dining tabs.',
        'bi-receipt text-gold'
    );
};
