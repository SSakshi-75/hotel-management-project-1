/* ==========================================
   ROOM DETAILS PAGE JAVASCRIPT LOGIC
   ========================================== */

function swapGallery(clickedImg) {
    const headerImg = document.getElementById('headerMainImg');
    const galleryMainPhoto = document.getElementById('galleryMainPhoto');

    if (headerImg && galleryMainPhoto) {
        const tempSrc = galleryMainPhoto.src;
        galleryMainPhoto.src = clickedImg.src;
        headerImg.src = clickedImg.src;
        clickedImg.src = tempSrc;
    }
}

function openReserveModal() {
    var modalEl = document.getElementById('inquiryModal');
    if (modalEl) {
        var modal = new bootstrap.Modal(modalEl);
        modal.show();
    }
}

function handleInquirySubmit(e) {
    e.preventDefault();
    alert("Thank you! Our concierge team will contact you shortly to confirm room availability.");
    var modalEl = document.getElementById('inquiryModal');
    if (modalEl) {
        var modal = bootstrap.Modal.getInstance(modalEl);
        if (modal) modal.hide();
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const urlParams = new URLSearchParams(window.location.search);
    const roomName = urlParams.get('title') || urlParams.get('room');
    const roomPrice = urlParams.get('price');
    const roomImg = urlParams.get('img');

    if (roomName) {
        const roomTitleEl = document.getElementById('roomTitle');
        if (roomTitleEl) roomTitleEl.textContent = roomName;
    }
    if (roomPrice) {
        const roomPriceEl = document.getElementById('roomPrice');
        const ctaPriceEl = document.getElementById('ctaPrice');
        if (roomPriceEl) roomPriceEl.innerHTML = '&#8377; ' + roomPrice;
        if (ctaPriceEl) ctaPriceEl.innerHTML = '&#8377; ' + roomPrice;
    }
    if (roomImg) {
        const headerMainImg = document.getElementById('headerMainImg');
        const galleryMainPhoto = document.getElementById('galleryMainPhoto');
        if (headerMainImg) headerMainImg.src = roomImg;
        if (galleryMainPhoto) galleryMainPhoto.src = roomImg;
    }

    // Update Book Now button to pass room and price to BookNow.aspx
    var bookNowBtn = document.querySelector('.btn-book-now');
    if (bookNowBtn && roomName) {
        var q = '?room=' + encodeURIComponent(roomName);
        if (roomPrice) q += '&price=' + encodeURIComponent(roomPrice);
        bookNowBtn.href = 'BookNow.aspx' + q;
    }
});
