/**
 * Dining & Table Reservation Engine - Hotel Management
 * Taj-inspired Luxury Gastronomy Interactivity
 */

document.addEventListener('DOMContentLoaded', function () {
    // Set default and min date for table reservation to today
    const reserveDateInput = document.getElementById('reserveDate');
    if (reserveDateInput) {
        const today = new Date().toISOString().split('T')[0];
        reserveDateInput.min = today;
        if (!reserveDateInput.value) {
            reserveDateInput.value = today;
        }
    }
});

/**
 * Open the table reservation modal and pre-select venue
 * @param {string} venueName - Optional restaurant name to pre-select
 */
function openTableReservationModal(venueName) {
    window.location.href = 'TableReservation.aspx';
}

/**
 * Filter menu items by category tab
 * @param {string} category - 'kebabs', 'mains', 'breads', 'desserts', 'beverages'
 * @param {HTMLElement} btn - The clicked button element
 */
function filterMenuCategory(category, btn) {
    // Update active state on tab buttons
    const tabsContainer = document.getElementById('diningMenuFilterTabs');
    if (tabsContainer) {
        const buttons = tabsContainer.querySelectorAll('.btn-menu-filter');
        buttons.forEach(function (b) {
            b.classList.remove('active');
        });
    }
    if (btn) {
        btn.classList.add('active');
    }

    // Toggle items visibility
    const menuCols = document.querySelectorAll('.menu-item-col');
    menuCols.forEach(function (col) {
        const itemCat = col.getAttribute('data-menu-cat');
        if (itemCat === category) {
            col.classList.remove('d-none');
            // Re-trigger simple fade animation
            col.style.animation = 'fadeInUp 0.4s ease forwards';
        } else {
            col.classList.add('d-none');
        }
    });
}

/**
 * Handle table reservation form submission
 * Validates inputs, creates instant confirmation ref, and renders confirmation voucher
 * @param {Event} e - Form submission event
 */
function handleTableReservationSubmit(e) {
    e.preventDefault();

    const venue = document.getElementById('reserveVenueSelect').value;
    const guests = document.getElementById('reserveGuestsCount').value;
    const dateVal = document.getElementById('reserveDate').value;
    const timeSlot = document.getElementById('reserveTimeSlot').value;
    const guestName = document.getElementById('reserveGuestName').value.trim();
    const guestEmail = document.getElementById('reserveGuestEmail').value.trim();
    const guestPhone = document.getElementById('reserveGuestPhone').value.trim();
    const seating = document.getElementById('reserveSeating').value;
    const occasion = document.getElementById('reserveOccasion').value;

    if (!guestName || !guestEmail || !guestPhone || !dateVal) {
        alert('Please fill in all mandatory reservation fields.');
        return;
    }

    // Format date for readable display
    let formattedDate = dateVal;
    try {
        const d = new Date(dateVal + 'T00:00:00');
        formattedDate = d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    } catch (err) {
        formattedDate = dateVal;
    }

    // Generate unique reference number (HM-TBL-XXXXXX)
    const refNum = 'HM-TBL-' + Math.floor(100000 + Math.random() * 900000);

    // Populate confirmation pass voucher
    const refEl = document.getElementById('tblConfRef');
    const guestEl = document.getElementById('tblConfGuest');
    const venueEl = document.getElementById('tblConfVenue');
    const dateTimeEl = document.getElementById('tblConfDateTime');
    const guestsEl = document.getElementById('tblConfGuests');
    const seatingEl = document.getElementById('tblConfSeating');

    if (refEl) refEl.textContent = refNum;
    if (guestEl) guestEl.textContent = guestName;
    if (venueEl) venueEl.textContent = venue;
    if (dateTimeEl) dateTimeEl.textContent = formattedDate + ' • ' + timeSlot;
    if (guestsEl) guestsEl.textContent = guests;
    if (seatingEl) seatingEl.textContent = seating + (occasion !== 'None' ? ' (' + occasion + ')' : '');

    // Hide form and reveal confirmation voucher
    const formEl = document.getElementById('tableReservationForm');
    const voucherEl = document.getElementById('tableConfirmationVoucher');
    if (formEl) formEl.classList.add('d-none');
    if (voucherEl) voucherEl.classList.remove('d-none');
}
