/* ==========================================
   MASTER PAGE UTILITIES & PRELOADER LOGIC
   ========================================== */
(function () {
    function dismissPreloader() {
        var p = document.querySelector('.preloader');
        if (p && p.style.display !== 'none') {
            p.style.transition = 'opacity 0.4s ease, visibility 0.4s ease';
            p.style.opacity = '0';
            setTimeout(function () {
                p.style.display = 'none';
                document.body.classList.remove('preloader-site');
            }, 400);
        }
    }
    if (document.readyState === 'complete' || document.readyState === 'interactive') {
        setTimeout(dismissPreloader, 250);
    } else {
        document.addEventListener('DOMContentLoaded', function () {
            setTimeout(dismissPreloader, 300);
        });
        window.addEventListener('load', function () {
            dismissPreloader();
        });
        setTimeout(dismissPreloader, 600);
    }
})();

document.addEventListener("DOMContentLoaded", function () {
    var currentPath = window.location.pathname.split("/").pop().toLowerCase();
    if (!currentPath || currentPath === "" || currentPath === "/") {
        currentPath = "index.aspx";
    }
    var navLinks = document.querySelectorAll(".navbar-nav .nav-link");
    navLinks.forEach(function (link) {
        link.classList.remove("active");
        var href = link.getAttribute("href");
        if (href) {
            var linkPath = href.split("/").pop().toLowerCase();
            if (linkPath === currentPath) {
                link.classList.add("active");
            }
        }
    });
});
