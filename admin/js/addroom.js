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
