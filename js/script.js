(function ($) {
  "use strict";

  var initPreloader = function () {
    $(document).ready(function () {
      var Body = $('body');
      Body.addClass('preloader-site');
    });
    $(window).on('load', function () {
      $('.preloader').fadeOut();
      $('body').removeClass('preloader-site');
    });
  }

  // init Chocolat light box
  var initChocolat = function () {
    Chocolat(document.querySelectorAll('.image-link'), {
      imageSize: 'contain',
      loop: true,
    })
  }

  $(document).ready(function () {
    // Isotope Initialization
    var $container = $('.isotope-container').isotope({
      itemSelector: '.item',
      layoutMode: 'masonry',
    });

    // Filter items on button click
    $('.filter-button').click(function () {
      var filterValue = $(this).attr('data-filter');
      if (filterValue === '*') {
        $container.isotope({ filter: '*' });
      } else {
        $container.isotope({ filter: filterValue });
      }
      $('.filter-button').removeClass('active');
      $(this).addClass('active');
    });

    // Video Modal
    var $videoSrc;
    $('.play-btn').click(function () {
      $videoSrc = $(this).data("src");
    });

    $('#myModal').on('shown.bs.modal', function (e) {
      $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
    })

    $('#myModal').on('hide.bs.modal', function (e) {
      $("#video").attr('src', $videoSrc);
    })

    // Swiper Initialization
    var sliderSwiper = new Swiper(".slider", {
      effect: "fade",
    });

    var roomSwiper = new Swiper(".room-swiper", {
      slidesPerView: 3,
      spaceBetween: 20,
      pagination: {
        el: ".room-pagination",
        clickable: true,
      },
      breakpoints: {
        0: {
          slidesPerView: 1,
        },
        1024: {
          slidesPerView: 2,
        },
        1280: {
          slidesPerView: 3,
        },
      },
    });

    var gallerySwiper = new Swiper(".gallery-swiper", {
      effect: "fade",
      navigation: {
        nextEl: ".main-slider-button-next",
        prevEl: ".main-slider-button-prev",
      },
    });

    var thumbSlider = new Swiper(".product-thumbnail-slider", {
      autoplay: true,
      loop: true,
      spaceBetween: 8,
      slidesPerView: 4,
      freeMode: true,
      watchSlidesProgress: true,
    });

    var largeSlider = new Swiper(".product-large-slider", {
      autoplay: true,
      loop: true,
      spaceBetween: 10,
      effect: 'fade',
      thumbs: {
        swiper: thumbSlider,
      },
    });

    // Preloader
    initPreloader();

    // Chocolat
    initChocolat();

    // Animate on Scroll
    AOS.init({
      duration: 1000,
      once: true,
    });

    // DateTimePicker (with safety check)
    if (typeof DateTimePickerComponent !== 'undefined' && DateTimePickerComponent.DatePicker) {
      if (document.getElementById('select-arrival-date')) {
        new DateTimePickerComponent.DatePicker('select-arrival-date');
      }
      if (document.getElementById('select-departure-date')) {
        new DateTimePickerComponent.DatePicker('select-departure-date');
      }
    }

    // Default Check-in (Today) & Check-out (Tomorrow) for Booking Bar
    var today = new Date();
    var tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);

    var formatDate = function (d) {
      var month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;
      return [year, month, day].join('-');
    };

    if ($('#checkInDate').length && !$('#checkInDate').val()) {
      $('#checkInDate').val(formatDate(today));
    }
    if ($('#checkOutDate').length && !$('#checkOutDate').val()) {
      $('#checkOutDate').val(formatDate(tomorrow));
    }

    // Gallery Eye Icon Click -> Open Image Lightbox Modal
    $(document).on('click', '.gallery-lightbox-trigger', function (e) {
      e.preventDefault();
      var imgSrc = $(this).attr('data-img-src');
      var imgTitle = $(this).attr('data-title') || 'Hotel Management Luxury Gallery';
      if (imgSrc && document.getElementById('galleryLightboxModal')) {
        $('#galleryModalPreviewImg').attr('src', imgSrc);
        $('#galleryModalCaption').text(imgTitle);
        var galleryModal = new bootstrap.Modal(document.getElementById('galleryLightboxModal'));
        galleryModal.show();
      }
    });

    // Sticky Navbar & Back-to-Top scroll behavior
    $(window).on('scroll', function () {
      if ($(this).scrollTop() > 50) {
        $('#primary-header').addClass('scrolled');
        $('#backToTop').addClass('active');
      } else {
        $('#primary-header').removeClass('scrolled');
        $('#backToTop').removeClass('active');
      }
    });

    $('#backToTop').on('click', function () {
      $('html, body').animate({ scrollTop: 0 }, 500);
    });
  });
})(jQuery);
