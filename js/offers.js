/* ==========================================
   OFFERS PAGE FILTER JAVASCRIPT LOGIC
   ========================================== */
function filterOffers(category, btn) {
    category = (category || 'all').toLowerCase();

    // Update active state on buttons (support both room-filter-btn and offer-filter-btn)
    var buttons = document.querySelectorAll('.room-filter-btn, .offer-filter-btn');
    buttons.forEach(function (b) {
        b.classList.remove('active');
    });
    if (btn) {
        btn.classList.add('active');
    }

    // Filter cards
    var cards = document.querySelectorAll('.offer-item-col');
    cards.forEach(function (card) {
        var cardCat = (card.getAttribute('data-category') || '').toLowerCase();
        var catTokens = cardCat.split(/\s+/);
        if (category === 'all' || catTokens.includes(category) || cardCat.indexOf(category) !== -1) {
            card.style.display = 'block';
            card.classList.add('animate__animated', 'animate__fadeIn');
        } else {
            card.style.display = 'none';
            card.classList.remove('animate__animated', 'animate__fadeIn');
        }
    });

    if (typeof AOS !== 'undefined') {
        setTimeout(function () { AOS.refresh(); }, 50);
    }
}
window.filterOffers = filterOffers;
