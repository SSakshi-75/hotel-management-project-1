/**
 * Admin Master Page Navigation & Dropdowns JavaScript
 * Location: admin/js/adminmaster.js
 */


// ==========================================
// SIDEBAR SUBMENU
// ==========================================

function toggleSubmenu(elem, evt) {

    if (evt) {
        if (evt.preventDefault) evt.preventDefault();
        if (evt.stopPropagation) evt.stopPropagation();
    }

    if (!elem) return false;

    var parentItem = elem.closest
        ? elem.closest('.has-submenu')
        : elem.parentElement;

    if (parentItem) {

        var isOpen = parentItem.classList.contains('open');


        // Close all other open submenus
        var allItems =
            document.querySelectorAll(
                '.sidebar-nav-list .has-submenu'
            );

        for (var i = 0; i < allItems.length; i++) {

            if (allItems[i] !== parentItem) {

                allItems[i].classList.remove('open');

                var otherSub =
                    allItems[i].querySelector('.sidebar-submenu');

                if (otherSub) {
                    otherSub.style.display = 'none';
                }
            }
        }


        // Current submenu
        var currentSub =
            parentItem.querySelector('.sidebar-submenu');


        if (isOpen) {

            parentItem.classList.remove('open');

            if (currentSub) {
                currentSub.style.display = 'none';
            }

        } else {

            parentItem.classList.add('open');

            if (currentSub) {
                currentSub.style.display = 'block';
            }
        }
    }

    return false;
}

window.toggleSubmenu = toggleSubmenu;



// ==========================================
// MOBILE SIDEBAR
// ==========================================

document.addEventListener(
    'DOMContentLoaded',
    function () {

        var sidebar =
            document.getElementById('adminSidebar');

        var overlay =
            document.getElementById('sidebarOverlay');

        var toggleBtn =
            document.getElementById('btnSidebarToggle');

        var closeBtn =
            document.getElementById('btnSidebarClose');


        function openMobileSidebar(e) {

            if (e) {
                if (e.preventDefault) e.preventDefault();
                if (e.stopPropagation) e.stopPropagation();
            }

            if (sidebar) {
                sidebar.classList.add('open');
            }

            if (overlay) {
                overlay.classList.add('active');
            }

            document.body.style.overflow =
                window.innerWidth < 992
                    ? 'hidden'
                    : '';

            return false;
        }


        function closeMobileSidebar(e) {

            if (e) {
                if (e.preventDefault) e.preventDefault();
                if (e.stopPropagation) e.stopPropagation();
            }

            if (sidebar) {
                sidebar.classList.remove('open');
            }

            if (overlay) {
                overlay.classList.remove('active');
            }

            document.body.style.overflow = '';

            return false;
        }


        if (toggleBtn) {

            toggleBtn.addEventListener(
                'click',
                function (e) {

                    if (
                        sidebar &&
                        sidebar.classList.contains('open')
                    ) {
                        closeMobileSidebar(e);
                    } else {
                        openMobileSidebar(e);
                    }
                }
            );
        }


        if (closeBtn) {
            closeBtn.addEventListener(
                'click',
                closeMobileSidebar
            );
        }


        if (overlay) {
            overlay.addEventListener(
                'click',
                closeMobileSidebar
            );
        }


        window.addEventListener(
            'resize',
            function () {

                if (window.innerWidth >= 992) {
                    closeMobileSidebar();
                }
            }
        );

    }
);



// ==========================================
// SIGNALR REAL-TIME ADMIN NOTIFICATIONS
// ==========================================

$(function () {

    // Check SignalR
    if (!$.connection ||
        !$.connection.notificationHub) {

        console.error(
            "NotificationHub not found."
        );

        return;
    }


    // ==========================================
    // SIGNALR HUB CONNECTION
    // ==========================================

    var notificationHub =
        $.connection.notificationHub;



    // ==========================================
    // RECEIVE NOTIFICATION FROM SERVER
    // ==========================================

    notificationHub.client.receiveNotification =
        function (message) {

            console.log(
                "New Notification:",
                message
            );


            // Get elements
            var badge =
                document.getElementById(
                    "notifBadge"
                );

            var countText =
                document.getElementById(
                    "notifCountText"
                );

            var notificationList =
                document.getElementById(
                    "notificationList"
                );

            var noNotifications =
                document.getElementById(
                    "noNotifications"
                );


            // ==========================================
            // Hide No Notification Message
            // ==========================================

            if (noNotifications) {

                noNotifications.style.display =
                    "none";
            }


            // ==========================================
            // Get Current Notification Count
            // ==========================================

            var currentCount = 0;


            if (
                badge &&
                badge.innerText
            ) {

                currentCount =
                    parseInt(
                        badge.innerText
                    ) || 0;
            }


            currentCount++;



            // ==========================================
            // UPDATE BELL BADGE
            // ==========================================

            if (badge) {

                badge.innerText =
                    currentCount;

                badge.classList.remove(
                    "d-none"
                );
            }



            // ==========================================
            // UPDATE "X NEW"
            // ==========================================

            if (countText) {

                countText.innerText =
                    currentCount +
                    " New";
            }



            // ==========================================
            // CREATE NOTIFICATION ITEM
            // ==========================================

            if (notificationList) {

                var notificationItem =
                    document.createElement(
                        "div"
                    );


                notificationItem.className =
                    "p-3 border-bottom notification-item";


                notificationItem.innerHTML =

                    '<div class="d-flex align-items-start gap-2">' +

                    '<i class="bi bi-bell-fill text-warning"></i>' +

                    '<div>' +

                    '<div class="small fw-semibold text-dark">' +
                    message +
                    '</div>' +

                    '<div class="text-muted" style="font-size:0.7rem;">' +
                    'Just now' +
                    '</div>' +

                    '</div>' +

                    '</div>';


                // Add newest notification at TOP
                notificationList.insertBefore(
                    notificationItem,
                    notificationList.firstChild
                );
            }

        };



    // ==========================================
    // START SIGNALR CONNECTION
    // ==========================================

    $.connection.hub.start()

        .done(function () {

            console.log(
                "SignalR connected successfully."
            );

        })

        .fail(function (error) {

            console.error(
                "SignalR connection failed:",
                error
            );

        });

});