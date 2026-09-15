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
    var pass = passInput ? passInput.value : "";

    if (user === "" || pass === "") {
        if (alertText) alertText.innerText = "Please enter both Email/Staff ID and Password.";
        if (alertBox) alertBox.classList.remove('d-none');
        if (userInput && user === "") userInput.focus();
        else if (passInput && pass === "") passInput.focus();
        return;
    }

    if (alertBox) alertBox.classList.add('d-none');

    // Disable button while verifying against SQL database
    if (btn) {
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status"></span><span>Verifying credentials...</span>';
    }

    fetch('Login.aspx/ValidateAdmin', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=utf-8'
        },
        body: JSON.stringify({ email: user, password: pass })
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
        var result = data.d;
        if (result === 'SUCCESS') {
            // Show on-page Confirmation Message
            var successBox = document.getElementById('adminSuccessMsg');
            if (successBox) {
                successBox.classList.remove('d-none');
                successBox.classList.add('d-flex');
            }

            if (btn) {
                btn.style.background = '#16a34a';
                btn.style.borderColor = '#15803d';
                btn.innerHTML = '<i class="bi bi-check2-circle fs-5 me-2"></i> <span>Admin Login Successfully!</span>';
            }

            try {
                sessionStorage.setItem('adminLoginSuccess', 'true');
            } catch (err) {}

            setTimeout(function () {
                window.location.href = "Dashboard.aspx";
            }, 1000);
        } else if (result === 'WRONG_PASSWORD') {
            if (btn) {
                btn.disabled = false;
                btn.innerHTML = '<i class="bi bi-box-arrow-in-right fs-5"></i> <span>Sign In to Console</span>';
            }
            if (alertText) alertText.innerText = "Incorrect password. Please enter your correct password.";
            if (alertBox) alertBox.classList.remove('d-none');
            if (passInput) { passInput.value = ''; passInput.focus(); }
        } else if (result === 'NOT_FOUND') {
            if (btn) {
                btn.disabled = false;
                btn.innerHTML = '<i class="bi bi-box-arrow-in-right fs-5"></i> <span>Sign In to Console</span>';
            }
            if (alertText) alertText.innerText = "Admin account not found. Please check your Email/Staff ID.";
            if (alertBox) alertBox.classList.remove('d-none');
            if (userInput) userInput.focus();
        } else {
            if (btn) {
                btn.disabled = false;
                btn.innerHTML = '<i class="bi bi-box-arrow-in-right fs-5"></i> <span>Sign In to Console</span>';
            }
            if (alertText) alertText.innerText = "Authentication failed. Please try again.";
            if (alertBox) alertBox.classList.remove('d-none');
        }
    })
    .catch(function (err) {
        if (btn) {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-box-arrow-in-right fs-5"></i> <span>Sign In to Console</span>';
        }
        if (alertText) alertText.innerText = "Connection error. Please try again.";
        if (alertBox) alertBox.classList.remove('d-none');
    });
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
