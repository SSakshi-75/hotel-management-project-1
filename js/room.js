/* ==========================================
   ROOM PAGE INTERACTIVE JAVASCRIPT LOGIC
   ========================================== */

function filterRooms(category, btnElement) {
    var buttons = document.querySelectorAll('.room-filter-btn');
    buttons.forEach(function (btn) {
        btn.classList.remove('active');
    });
    if (btnElement) {
        btnElement.classList.add('active');
    }

    var roomItems = document.querySelectorAll('.room-item-col');
    roomItems.forEach(function (item) {
        if (category === 'all' || item.getAttribute('data-category') === category) {
            item.style.display = 'block';
            item.classList.add('filter-fade-enter');
        } else {
            item.style.display = 'none';
            item.classList.remove('filter-fade-enter');
        }
    });
}

function openBookingModal(roomName, price) {
    var nameEl = document.getElementById('modalSelectedRoomName');
    var priceEl = document.getElementById('modalSelectedRoomPrice');
    if (nameEl) nameEl.innerText = roomName;
    if (priceEl) priceEl.innerText = '₹ ' + price + ' / night';
}

function handleReservationSubmit(e) {
    e.preventDefault();
    alert('Thank you! Your room reservation inquiry has been received. Our concierge team will contact you shortly.');
    var modalEl = document.getElementById('roomBookingModal');
    if (modalEl && window.bootstrap) {
        var modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) {
            modal.hide();
        }
    }
}

function scrollToRooms() {
    var grid = document.getElementById('all-rooms-grid');
    if (grid) {
        grid.scrollIntoView({ behavior: 'smooth' });
    }
}
