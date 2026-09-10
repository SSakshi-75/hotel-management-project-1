/* ==========================================
   BOOKING PAGE JAVASCRIPT LOGIC
   ========================================== */

function updateBookingSummary() {
    var select = document.getElementById('bookingRoomSelect');
    if (!select) return;
    
    var price = parseInt(select.value) || 8500;
    var roomText = select.options[select.selectedIndex].text.split(' (')[0];

    var taxes = Math.round(price * 0.12);
    var total = price + taxes;

    var roomNameEl = document.getElementById('summaryRoomName');
    var roomRateEl = document.getElementById('summaryRoomRate');
    var taxesEl = document.getElementById('summaryTaxes');
    var totalEl = document.getElementById('summaryTotal');

    if (roomNameEl) roomNameEl.textContent = roomText;
    if (roomRateEl) roomRateEl.innerHTML = '&#8377; ' + price.toLocaleString();
    if (taxesEl) taxesEl.innerHTML = '&#8377; ' + taxes.toLocaleString();
    if (totalEl) totalEl.innerHTML = '&#8377; ' + total.toLocaleString();
}

function handleOnlineBookingSubmit(e) {
    e.preventDefault();
    alert("Thank you! Your royal reservation request has been submitted successfully. Our concierge team will contact you shortly to confirm your booking.");
}

document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomPrice = urlParams.get('price');
    const roomTitle = urlParams.get('title') || urlParams.get('room');

    const select = document.getElementById('bookingRoomSelect');
    if (select && roomPrice) {
        for (let i = 0; i < select.options.length; i++) {
            if (select.options[i].value === roomPrice) {
                select.selectedIndex = i;
                break;
            }
        }
        updateBookingSummary();
    }
});
