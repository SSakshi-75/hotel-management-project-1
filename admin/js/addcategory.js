/* ==========================================
   ADD CATEGORY ADMIN JAVASCRIPT
   Location: admin/js/addcategory.js
   ========================================== */

function resetCategoryForm() {
    var nameInput = document.getElementById('txtCategoryName');
    var statusSelect = document.getElementById('ddlIsActive');

    if (nameInput) nameInput.value = '';
    if (statusSelect) statusSelect.value = '1';
}

// Auto dismiss status confirmation alert without needing to click close
document.addEventListener('DOMContentLoaded', function () {
    var statusAlert = document.querySelector('[id$="pnlStatusMsg"]') || document.querySelector('.alert.alert-dismissible');
    if (statusAlert) {
        setTimeout(function () {
            statusAlert.style.transition = 'opacity 0.6s ease, transform 0.6s ease, max-height 0.6s ease, margin 0.6s ease, padding 0.6s ease';
            statusAlert.style.opacity = '0';
            statusAlert.style.transform = 'translateY(-8px)';
            statusAlert.style.maxHeight = '0px';
            statusAlert.style.paddingTop = '0px';
            statusAlert.style.paddingBottom = '0px';
            statusAlert.style.marginTop = '0px';
            statusAlert.style.marginBottom = '0px';
            statusAlert.style.overflow = 'hidden';
            setTimeout(function () {
                if (statusAlert.parentNode) {
                    statusAlert.style.display = 'none';
                }
            }, 600);
        }, 2000);
    }
});
