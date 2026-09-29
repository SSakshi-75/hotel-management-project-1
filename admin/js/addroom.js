function previewUploadedImage(fileInput, targetInputId, previewImgId) {
    if (fileInput.files && fileInput.files[0]) {
        var file = fileInput.files[0];
        var reader = new FileReader();
        reader.onload = function (e) {
            var targetInput = document.getElementById(targetInputId);
            if (targetInput) targetInput.value = 'images/' + file.name;
            var previewImg = document.getElementById(previewImgId);
            if (previewImg) {
                previewImg.src = e.target.result;
                previewImg.style.display = 'inline-block';
            }
            if (window.showAdminToast) {
                window.showAdminToast('File Selected', file.name + ' uploaded to preview.', 'bi-image text-success');
            }
        };
        reader.readAsDataURL(file);
    }
}

function resetForm() {
    var inputs = document.querySelectorAll('#adminForm input[type="text"], #adminForm input[type="number"], #adminForm textarea');
    inputs.forEach(function (input) {
        input.value = '';
    });

    var selects = document.querySelectorAll('#adminForm select');
    selects.forEach(function (select) {
        select.selectedIndex = 0;
    });

    var checkboxes = document.querySelectorAll('#adminForm input[type="checkbox"]');
    checkboxes.forEach(function (cb) {
        cb.checked = false;
    });

    if (window.showAdminToast) {
        window.showAdminToast('Form Cleared', 'All basic room and room detail fields have been reset.', 'bi-arrow-counterclockwise text-primary');
    }
}

// Auto-dismiss success alert popup after 2 seconds
(function () {
    function setupPopupAutoDismiss() {
        var successPnl = document.querySelector('[id$="pnlSuccessMessage"]') || document.querySelector('.alert-success');
        if (successPnl) {
            var closeBtn = successPnl.querySelector('.btn-close');
            if (closeBtn) {
                closeBtn.addEventListener('click', function () {
                    dismissAlert(successPnl);
                });
            }

            setTimeout(function () {
                dismissAlert(successPnl);
            }, 2000);
        }
    }

    function dismissAlert(elem) {
        if (!elem || elem.dataset.dismissed === 'true') return;
        elem.dataset.dismissed = 'true';
        elem.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
        elem.style.opacity = '0';
        elem.style.transform = 'translateY(-8px)';
        setTimeout(function () {
            elem.style.display = 'none';
        }, 400);
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', setupPopupAutoDismiss);
    } else {
        setupPopupAutoDismiss();
    }
})();
