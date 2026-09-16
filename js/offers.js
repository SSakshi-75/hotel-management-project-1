/* ==========================================
   OFFERS PAGE FILTER JAVASCRIPT LOGIC
   ========================================== */
function filterOffers(category, btn) {
    // Update active state on buttons
    var buttons = document.querySelectorAll('.offer-filter-btn');
    buttons.forEach(function (b) {
        b.classList.remove('active');
    });
    if (btn) {
        btn.classList.add('active');
    }

    // Filter cards
    var cards = document.querySelectorAll('.offer-item-col');
    cards.forEach(function (card) {
        var cardCat = card.getAttribute('data-category') || '';
        if (category === 'all' || cardCat.indexOf(category) !== -1) {
            card.style.display = 'block';
            card.classList.add('animate__animated', 'animate__fadeIn');
        } else {
            card.style.display = 'none';
        }
    });
}
