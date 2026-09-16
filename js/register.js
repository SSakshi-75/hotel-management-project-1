function togglePassword(inputId, btn) {
    var input = document.getElementById(inputId) ||
        (btn && btn.closest('.auth-input-wrapper') ? btn.closest('.auth-input-wrapper').querySelector('input') : null);
    if (!input) return;
    var icon = btn ? btn.querySelector('i') : null;
    if (input.type === 'password') {
        input.type = 'text';
        if (icon) {
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        }
    } else {
        input.type = 'password';
        if (icon) {
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    }
}

function validateTerms(source, args) {
    var chk = document.getElementById('chkTerms');
    args.IsValid = chk && chk.checked;
}
