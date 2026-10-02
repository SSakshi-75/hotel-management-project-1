/* ==========================================
   DINING MENU MANAGEMENT ADMIN JAVASCRIPT
   Location: admin/js/menu.js
   ========================================== */

// Auto-Dismiss Script for Messages (3.5s for success, 4.5s for error)
(function () {
    function setupAutoDismiss(elemId, delayMs) {
        var elem = document.getElementById(elemId);
        if (elem) {
            setTimeout(function () {
                elem.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
                elem.style.opacity = '0';
                elem.style.transform = 'translateY(-10px)';
                setTimeout(function () {
                    elem.style.display = 'none';
                }, 600);
            }, delayMs);
        }
    }
    function triggerDismiss() {
        var successPnl = document.querySelector('[id$="pnlSuccessMessage"]');
        var errorPnl = document.querySelector('[id$="pnlErrorMessage"]');
        if (successPnl) setupAutoDismiss(successPnl.id, 3500);
        if (errorPnl) setupAutoDismiss(errorPnl.id, 4500);
    }
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', triggerDismiss);
    } else {
        triggerDismiss();
    }
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
});
