/* ==========================================
   PHOTO GALLERY MANAGEMENT ADMIN JAVASCRIPT
   Location: admin/js/gallery.js
   ========================================== */

var currentActiveCategory = 'ALL';

function toggleSelectAllPhotos(master) {
    var checkboxes = document.querySelectorAll('.photo-row-chk input[type="checkbox"]');
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = master.checked;
    }
}

function filterGalleryTable() {
    var searchInput = document.getElementById('txtGallerySearch');
    var filter = searchInput ? searchInput.value.toLowerCase().trim() : '';
    var rows = document.querySelectorAll('#gvAdminGallery tr.gallery-photo-row');

    for (var i = 0; i < rows.length; i++) {
        var row = rows[i];
        var text = row.textContent.toLowerCase();
        var category = (row.getAttribute('data-category') || '').toUpperCase();

        var matchesSearch = (filter === '' || text.indexOf(filter) !== -1);
        var matchesCategory = (currentActiveCategory === 'ALL' || category.indexOf(currentActiveCategory) !== -1);

        row.style.display = (matchesSearch && matchesCategory) ? '' : 'none';
    }
}

function setGalleryCategoryFilter(category, button) {
    currentActiveCategory = category.toUpperCase();

    var buttons = document.querySelectorAll('.filter-pill-btn');
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].classList.remove('active');
    }

    if (button) {
        button.classList.add('active');
    }

    filterGalleryTable();
}

function confirmBulkDeletePhotos() {
    var checked = document.querySelectorAll('.photo-row-chk input[type="checkbox"]:checked');
    if (checked.length === 0) {
        alert('Please select at least one photo checkbox from the table to delete.');
        return false;
    }
    return confirm('Are you sure you want to permanently delete ' + checked.length + ' selected photo(s)?');
}

// Auto-Dismiss Script for Confirmation and Error Messages
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
