/* ==========================================
   DINING MENU MANAGEMENT ADMIN JAVASCRIPT
   Location: admin/js/menu.js
   ========================================== */

// Auto-Dismiss Script for Messages (2s for success, 3s for error)
(function () {
    function setupAutoDismiss(elemId, delayMs) {
        var elem = document.getElementById(elemId);
        if (elem) {
            setTimeout(function () {
                elem.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
                elem.style.opacity = '0';
                elem.style.transform = 'translateY(-8px)';
                setTimeout(function () {
                    elem.style.display = 'none';
                }, 400);
            }, delayMs);
        }
    }
    function triggerDismiss() {
        var successPnl = document.querySelector('[id$="pnlSuccessMessage"]');
        var errorPnl = document.querySelector('[id$="pnlErrorMessage"]');
        if (successPnl) setupAutoDismiss(successPnl.id, 2000);
        if (errorPnl) setupAutoDismiss(errorPnl.id, 3000);
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', triggerDismiss);
    } else {
        triggerDismiss();
    }
    window.addEventListener('load', triggerDismiss);
})();

var currentCategoryFilter = 'all';

function filterAdminMenu(cat, btn) {
    currentCategoryFilter = cat;
    var buttons = document.querySelectorAll('#adminMenuFilterGroup .menu-filter-btn');
    buttons.forEach(function (b) { b.classList.remove('active'); });
    if (btn) btn.classList.add('active');

    applyFilters();
}

function searchAdminDishes() {
    applyFilters();
}

function applyFilters() {
    var searchInput = document.getElementById('dishSearchInput');
    var searchQuery = (searchInput ? searchInput.value : '').trim().toLowerCase();
    var rows = document.querySelectorAll('#adminMenuTable tbody tr.menu-row');

    rows.forEach(function (row) {
        var rowCat = row.getAttribute('data-cat') || '';
        var dishName = (row.querySelector('.dish-name-text') ? row.querySelector('.dish-name-text').textContent : '').toLowerCase();

        var matchesCat = (currentCategoryFilter === 'all' || rowCat === currentCategoryFilter);
        var matchesSearch = (searchQuery === '' || dishName.indexOf(searchQuery) !== -1);

        if (matchesCat && matchesSearch) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function toggleNewMenuCategory(sel) {
    var txt = document.getElementById('txtNewCategory');
    if (!txt) return;
    if (sel.value === '__NEW__' || sel.value === 'NEW') {
        txt.style.display = 'block';
        txt.focus();
    } else {
        txt.style.display = 'none';
    }
}

window.addEventListener('DOMContentLoaded', function () {
    var sel = document.getElementById('ddlCategory');
    if (sel && (sel.value === '__NEW__' || sel.value === 'NEW')) {
        var txt = document.getElementById('txtNewCategory');
        if (txt) txt.style.display = 'block';
    }

    // Auto-sync current dish image preview in Edit mode
    var hdn = document.querySelector('[id$="hdnCurrentDishImageUrl"]');
    var pnl = document.querySelector('[id$="pnlExistingImageInfo"]');
    var txt = document.querySelector('[id$="txtCurrentImageUrl"]');
    var img = document.querySelector('[id$="imgCurrentDishThumb"]');
    if (hdn && hdn.value && hdn.value.trim() !== '') {
        if (pnl) pnl.style.display = 'block';
        if (txt) txt.value = hdn.value.trim();
        if (img) {
            var raw = hdn.value.trim();
            var relPath = raw.indexOf('~/') === 0 ? raw.substring(2) : (raw.indexOf('/') === 0 ? raw.substring(1) : raw);
            img.src = '../' + relPath;
        }
    }
});
