/**
 * Hotel Management System - Admin Login Scripts
 */

function toggleAdminPasswordVisibility(inputId, btn) {
    var input = document.getElementById(inputId);
    if (!input) return;
    var icon = btn.querySelector('i');
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

function handleAdminLoginSubmit() {
    var userInput = document.getElementById('adminEmail') || document.getElementById('adminUsername');
    var passInput = document.getElementById('adminPassword');
    var alertBox = document.getElementById('adminAlertMsg');
    var alertText = document.getElementById('adminAlertText');
    var btn = document.getElementById('btnAdminSubmit');

    var user = userInput ? userInput.value.trim() : "";
    var pass = passInput ? passInput.value.trim() : "";

    if (user === "" || pass === "") {
        if (alertText) alertText.innerText = "Please enter both Email/Staff ID and Password.";
        if (alertBox) alertBox.classList.remove('d-none');
        if (userInput && user === "") userInput.focus();
        else if (passInput && pass === "") passInput.focus();
        return;
    }

    if (alertBox) alertBox.classList.add('d-none');

    // Professional loading state
    if (btn) {
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span> Authenticating Console...';
    }

    setTimeout(function () {
        window.location.href = "Dashboard.aspx";
    }, 550);
}

// Enter key submission
document.addEventListener('DOMContentLoaded', function () {
    var userInput = document.getElementById('adminEmail') || document.getElementById('adminUsername');
    var passInput = document.getElementById('adminPassword');

    function onEnter(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            handleAdminLoginSubmit();
        }
    }

    if (userInput) userInput.addEventListener('keydown', onEnter);
    if (passInput) passInput.addEventListener('keydown', onEnter);
});
