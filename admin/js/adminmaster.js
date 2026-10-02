/**
 * Admin Master Page Navigation & Dropdowns JavaScript
 * Location: admin/js/adminmaster.js
 */

function toggleSubmenu(elem, evt) {
    if (evt) {
        if (evt.preventDefault) evt.preventDefault();
        if (evt.stopPropagation) evt.stopPropagation();
    }
    if (!elem) return false;
    var parentItem = elem.closest ? elem.closest('.has-submenu') : elem.parentElement;
    if (parentItem) {
        var isOpen = parentItem.classList.contains('open');

        // Close all other open submenus
        var allItems = document.querySelectorAll('.sidebar-nav-list .has-submenu');
        for (var i = 0; i < allItems.length; i++) {
            if (allItems[i] !== parentItem) {
                allItems[i].classList.remove('open');
                var otherSub = allItems[i].querySelector('.sidebar-submenu');
                if (otherSub) otherSub.style.display = 'none';
            }
        }

        var currentSub = parentItem.querySelector('.sidebar-submenu');
        if (isOpen) {
            parentItem.classList.remove('open');
            if (currentSub) currentSub.style.display = 'none';
        } else {
            parentItem.classList.add('open');
            if (currentSub) currentSub.style.display = 'block';
        }
    }
    return false;
}
window.toggleSubmenu = toggleSubmenu;

// Global dropdown click listener for topbar profile & notifications
document.addEventListener('click', function (e) {
    var dropToggle = e.target.closest('[data-bs-toggle="dropdown"]');
    if (dropToggle) {
        e.preventDefault();
        e.stopPropagation();
        var menu = dropToggle.nextElementSibling || (dropToggle.parentElement ? dropToggle.parentElement.querySelector('.dropdown-menu') : null);
        if (menu) {
            var isShown = menu.classList.contains('show');
            document.querySelectorAll('.dropdown-menu.show').forEach(function (m) {
                m.classList.remove('show');
            });
            if (!isShown) {
                menu.classList.add('show');
            }
        }
        return;
    }

    if (!e.target.closest('.dropdown')) {
        document.querySelectorAll('.dropdown-menu.show').forEach(function (m) {
            m.classList.remove('show');
        });
    }
});
