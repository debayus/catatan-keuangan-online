( function( $ ) {

"use strict";

// *** On ready *** //
$( document ).on( "ready" , function() {
	responsiveClasses();
	dataCustomOptions();
	fullscreenSection();
	imageBG();
	fitVideos();
	BGVideoYTPlayer();
	lightboxImage();
	lightboxGallery();
	lightboxIframe();
	scrollToAnchor();
	bannerParallaxImageBG();
	sectionParallaxImageBG();
	sliderClients();
	sliderBoxesFeatures1();
	sliderBoxesFeatures2();
	sliderBoxesFeatures3();
	counterStats();
	sliderTestimonials();
	formCTASubscribe2();
	scrollTopIcon();
});

// *** On load *** //
$( window ).on( "load" , function() {
	parallaxStellar();
	scrollProgress();
});

// *** On resize *** //
$( window ).on( "resize" , function() {
	responsiveClasses();
	fullscreenSection();
	parallaxStellar();
});

// *** On scroll *** //
$( window ).on( "scroll" , function() {
	scrollTopIcon();
	scrollProgress();
});

// *** On Scroll In On load *** //
$( window ).on( "load" , function() {
	$( window ).on( "scroll" , function() {

	});
});


// *** jQuery noConflict *** //
var $ = jQuery.noConflict();


// *** General Variables *** //
var $window = $( window ),
	$this = $( this ),
	$body = $( "body" );

// *** Data Custom Options *** //
function dataCustomOptions() { $("*[data-pattern-overlay-darkness-opacity]").each(function () { var a = $(this).data("pattern-overlay-darkness-opacity"); $(this).css("background-color", convertHex("#000000", a)) }), $("*[data-pattern-overlay-background-image]").each(function () { "none" == $(this).data("pattern-overlay-background-image") ? $(this).css("background-image", "none") : "yes" == $(this).data("pattern-overlay-background-image") && $(this).css("background-image") }), $("*[data-remove-pattern-overlay]").each(function () { "yes" == $(this).data("remove-pattern-overlay") && $(this).css("background", "none") }), $("*[data-bg-color]").each(function () { var a = $(this).data("bg-color"); $(this).css("background-color", a) }), $("*[data-bg-color-opacity]").each(function () { var a = $(this).data("bg-color-opacity"), t = $(this).css("background-color").replace("rgb", "rgba").replace(")", ", " + a + ")"); $(this).css("background-color", t) }), $("*[data-bg-img]").each(function () { var a = $(this).data("bg-img"); $(this).css("background-image", "url('" + a + "')") }), $("*[data-parallax-bg-img]").each(function () { var a = $(this).data("parallax-bg-img"); $(this).css("background-image", "url('./images/files/parallax-bg/" + a + "')") }) }


// Custom banner height
$( ".banner-parallax" ).each(function() {
	var customBannerHeight = $( this ).data( "banner-height" ),
		boxContent = $( this ).find( ".row > [class*='col-']" );
	$( this ).css( "min-height" , customBannerHeight );
	$( boxContent ).css( "min-height" , customBannerHeight );
});



// *** Responsive Classes *** //
function responsiveClasses() {
	var jRes = jRespond([
		{
			label: "smallest",
			enter: 0,
			exit: 479
		},{
			label: "handheld",
			enter: 480,
			exit: 767
		},{
			label: "tablet",
			enter: 768,
			exit: 991
		},{
			label: "laptop",
			enter: 992,
			exit: 1199
		},{
			label: "desktop",
			enter: 1200,
			exit: 10000
		}
	]);
	jRes.addFunc([
		{
			breakpoint: "desktop",
			enter: function() { $body.addClass( "device-lg" ); },
			exit: function() { $body.removeClass( "device-lg" ); }
		},{
			breakpoint: "laptop",
			enter: function() { $body.addClass( "device-md" ); },
			exit: function() { $body.removeClass( "device-md" ); }
		},{
			breakpoint: "tablet",
			enter: function() { $body.addClass( "device-sm" ); },
			exit: function() { $body.removeClass( "device-sm" ); }
		},{
			breakpoint: "handheld",
			enter: function() { $body.addClass( "device-xs" ); },
			exit: function() { $body.removeClass( "device-xs" ); }
		},{
			breakpoint: "smallest",
			enter: function() { $body.addClass( "device-xxs" ); },
			exit: function() { $body.removeClass( "device-xxs" ); }
		}
	]);
}


// *** Fullscreen Section *** //
function fullscreenSection() {
	$( ".fullscreen, #home-header, #home-banner" ).css( "height", $( window ).height() );
	$( "#banner.fullscreen" ).css( "height", $( window ).height() );
}


// *** RTL Case *** //
var HTMLDir = $( "html" ).css( "direction" ),
	owlRtl;

// If page is RTL
if ( HTMLDir == "rtl" ) { 
	// Owl Carousel
	owlRtl = true 
} else { 
	owlRtl = false 
}


// *** Image Background *** //
function imageBG() {
	$( ".img-bg" ).each(function() {
		var $this = $( this ),
			imgSrc = $this.find( "img" ).attr( "src" );

		if ( $this.parent( ".section-image" ).length ) {
			$this.css( "background-image", "url('" + imgSrc + "')"  );
		} else {
			$this.prepend( "<div class='bg-element'></div>" );
			var bgElement = $this.find( ".bg-element" );
			bgElement.css( "background-image", "url('" + imgSrc + "')"  );
		}
		$this.find( "img" ).css({ "opacity" : 0 , "visibility" : "hidden" });		
	});
}


// *** Stellar Parallax *** //
function parallaxStellar() {
	$(function() {
		if ( $body.hasClass( "device-lg" ) || $body.hasClass( "device-md" ) || $body.hasClass( "device-sm" ) ) {
			$.stellar({
				horizontalScrolling: false, // don't change this option
				// verticalScrolling: false,
				verticalOffset: 0,
		    	responsive: true, // false
			});
        }
	});
}


// *** Fit Videos *** //
function fitVideos() {
	$( "#full-container" ).fitVids();
}


// *** Background Videos *** //
function BGVideoYTPlayer() {
	$(".video-background").each( function() {
		$( this ).YTPlayer({
			mute: false,
			autoPlay: true,
			opacity: 1,
			containment: ".video-background",
			showControls: false,
			startAt: 0,
			addRaster: true,
			showYTLogo: false,
			stopMovieOnBlur: false
		});
	});
}


// *** Lightbox Iframe *** //
function lightboxIframe() {
	$( ".lightbox-iframe" ).magnificPopup({
		type: 'iframe',
		mainClass: 'mfp-fade',
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false
	});	
}


// *** Lightbox Image *** //
function lightboxImage() {
	$( ".lightbox-img" ).magnificPopup({
		type: 'image',
		gallery:{
			enabled: false
		},
		mainClass: 'mfp-fade',
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false
	});	
}


// *** Lightbox Gallery *** //
function lightboxGallery() {
	$( ".lightbox-gallery" ).magnificPopup({
		type: 'image',
		gallery:{
			enabled: true
		},
		mainClass: 'mfp-fade',
		removalDelay: 160,
		preloader: false,
		fixedContentPos: false
	});	
}


// *** Scroll Top Icon *** //
function scrollTopIcon() {
	var windowScroll = $( window ).scrollTop();
	if ( $( window ).scrollTop() > 800 ) {
		$( ".scroll-top-icon" ).addClass( "show" );
	} else {
		$( ".scroll-top-icon" ).removeClass( "show" );
	}
}

$( ".scroll-top" ).on( "click" , function(e) {
	e.preventDefault();
    $( "html, body" ).animate({
        scrollTop: 0
    }, 1200, "easeInOutExpo" ); //1200 easeInOutExpo
});


// *** Scroll Progress *** //
function scrollProgress() {
    var docheight = $(document).height();
    var winheight = $(window).height();
    var height = docheight - winheight;
    var scroll = $(document).scrollTop();
    var scrollperc = scroll/(height/100);
    $("#scroll-progress .scroll-progress").width(scrollperc+'%');
    $(".scroll-percent").text(scrollperc.toFixed(0)+'%');	
}


// *** Scroll To Anchor *** //
function scrollToAnchor() {
   	var stickyBar = $( ".header-bar.sticky" ),
   		stickyBarHeight = stickyBar.height(),
	    offsetDifference = ( ! stickyBar ) ? 0 : stickyBarHeight;

    $(  ".scroll-to" ).on( "click", function( e ) {
        e.preventDefault();
        var $anchor = $( this );

        // scroll to specific anchor
        $(  "html, body" ).stop().animate({
            scrollTop: $( $anchor.attr( "href" ) ).offset().top - offsetDifference
        } , 1200 , "easeInOutExpo" );
    });    
}


// *** Banner Parallax Image BG *** //
function bannerParallaxImageBG() {
	var bannerParallax = $( ".banner-parallax" ),
		imgSrc = bannerParallax.children( "img:first-child" ).attr( "src" );

	bannerParallax.prepend( "<div class='bg-element'></div>" );
	var bgElement = bannerParallax.find( "> .bg-element" );
	bgElement.css( "background-image", "url('" + imgSrc + "')"  ).attr( "data-stellar-background-ratio" , 0.2 );
}


// *** Section Parallax Image BG *** //
function sectionParallaxImageBG() {
	$( ".parallax-section" ).each( function() {
		var parallaxSection = $( this ),
			imgSrc = parallaxSection.children( "img:first-child" ).attr( "src" );

		parallaxSection.prepend( "<div class='bg-element'></div>" );
		var bgElement = parallaxSection.find( "> .bg-element" );
		bgElement.css( "background-image", "url('" + imgSrc + "')"  ).attr( "data-stellar-background-ratio" , 0.2 );
	} );
}


// *** Slider Clients *** //
function sliderClients() {
	var sliderClients = $(".slider-clients > .owl-carousel");
	sliderClients.owlCarousel({
		items: 6,
		rtl: owlRtl,
		autoplay: 3000,
		autoplaySpeed: 500, // Sliding autoplay speed
		autoplayTimeout: 3000, // Autoplay interval timeout.
		dragEndSpeed: 350, // Sliding speed by mouse drag
		autoplayHoverPause: true, // Stop autoplay on mouse hover
		loop: true,
		slideBy: 1, // Number of item are slided for each one transition
		margin: 30, // space between each item. Very useful!
		stagePadding: 0, // This used to see part of left an right items as preview style
		nav: false, // show prev and next buttons
		dots: false, // Show dots navigation
		navText: ["<i class=\"fa fa-angle-left\"></i>", "<i class=\"fa fa-angle-right\"></i>"], // prev and next buttons content
		responsive: {
			0: {
				items: 2
			},
			480: {
				items: 3
			},
			768: {
				items: 4
			},
			992: {
				items: 5
			},
			1200: {
				items: 6
			}
		},
		autoHeight: false,
		autoWidth: false,
		// animateOut: 'goDownOut',
		// animateIn: 'goDownIn',
		navRewind: true,
		center: false, // It's used to make the carousel start from the centered item
		dotsEach: 1, // Number of items per dot
		dotData: false,
		lazyLoad: false, // img tag needs class="owl-lazy" and data-src="url-to-img" or/and data-src-retina="url-to-highres-img"
		smartSpeed: 600, // Sliding speed when hover next or prev nav
		fluidSpeed: 5000,
		navSpeed: 400,
		// fallbackEasing: "ease-in-out",
		dotsSpeed: 400 // Sliding speed by using dots
	});
}


// *** Slider Boxes Features 1 *** //
function sliderBoxesFeatures1() {
	var sliderBoxesFeatures1 = $( ".slider-boxes-features-1 > .owl-carousel" );

	sliderBoxesFeatures1.on("initialized.owl.carousel",function(s){var e=s.item.index,d=$(".slider-boxes-features-1 > .owl-carousel .owl-item");$body.hasClass("device-lg")||$body.hasClass("device-md")?d.eq(e+1).addClass("highlighted"):($body.hasClass("device-sm")||$body.hasClass("device-xs")||$body.hasClass("device-xxs"))&&d.eq(e).addClass("highlighted")}),sliderBoxesFeatures1.on("resized.owl.carousel",function(s){var e=s.item.index,d=$(".slider-boxes-features-1 > .owl-carousel .owl-item");$body.hasClass("device-lg")||$body.hasClass("device-md")?(d.removeClass("highlighted"),d.eq(e+1).addClass("highlighted")):($body.hasClass("device-sm")||$body.hasClass("device-xs")||$body.hasClass("device-xxs"))&&(d.removeClass("highlighted"),d.eq(e).addClass("highlighted"))}),$(".slider-boxes-features-1 > .owl-carousel").on("translate.owl.carousel",function(s){var e=s.item.index,d=$(".slider-boxes-features-1 > .owl-carousel .owl-item");$body.hasClass("device-lg")||$body.hasClass("device-md")?(d.removeClass("highlighted"),d.eq(e+1).addClass("highlighted")):($body.hasClass("device-sm")||$body.hasClass("device-xs")||$body.hasClass("device-xxs"))&&(d.removeClass("highlighted"),d.eq(e).addClass("highlighted"))});	

	sliderBoxesFeatures1.owlCarousel({
		// items: 3,
		rtl: owlRtl,
		autoplay: false,
		autoplaySpeed: 500, // Sliding autoplay speed
		autoplayTimeout: 5000, // Autoplay interval timeout.
		dragEndSpeed: 350, // Sliding speed by mouse drag
		autoplayHoverPause: true, // Stop autoplay on mouse hover
		loop: false,
		slideBy: 1, // Number of item are slided for each one transition
		margin: 20, // space between each item. Very useful!
		stagePadding: 0, // This used to see part of left an right items as preview style
		nav: false, // show prev and next buttons
		dots: false, // Show dots navigation
		navText: ["<i class=\"fa fa-angle-left\"></i>","<i class=\"fa fa-angle-right\"></i>"], // prev and next buttons content
		responsive : {
			0 : {
		        items : 1
		    },
		    480 : {
		        items : 1
		    },
		    600 : {
		        items : 2
		    },
		    768 : {
		        items : 2
		    },
		    1024 : {
		        items : 3
		    }
		},
		autoHeight: true,
		autoWidth: false,
		// animateOut: 'goDownOut',
	    // animateIn: 'goDownIn',
		navRewind: true,
		center: false, // It's used to make the carousel start from the centered item
		dotsEach: 1, // Number of items per dot
		dotData: false,
		lazyLoad: false, // img tag needs class="owl-lazy" and data-src="url-to-img" or/and data-src-retina="url-to-highres-img"
		smartSpeed: 600, // Sliding speed when hover next or prev nav
		fluidSpeed: 5000,
		navSpeed: 400,
		// fallbackEasing: "ease-in-out",
		dotsSpeed: 400 // Sliding speed by using dots
	});
}


// *** Slider Boxes Features 2 *** //
function sliderBoxesFeatures2() {
	var sliderBoxesFeatures2 = $( ".slider-boxes-features-2 > .owl-carousel" );

	sliderBoxesFeatures2.on("initialized.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-2 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? d.eq(e + 1).addClass("highlighted") : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && d.eq(e).addClass("highlighted") }), sliderBoxesFeatures2.on("resized.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-2 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? (d.removeClass("highlighted"), d.eq(e + 1).addClass("highlighted")) : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) }), $(".slider-boxes-features-2 > .owl-carousel").on("translate.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-2 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? (d.removeClass("highlighted"), d.eq(e + 1).addClass("highlighted")) : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) });	

	sliderBoxesFeatures2.owlCarousel({
		// items: 3,
		rtl: owlRtl,
		autoplay: false,
		autoplaySpeed: 500, // Sliding autoplay speed
		autoplayTimeout: 5000, // Autoplay interval timeout.
		dragEndSpeed: 350, // Sliding speed by mouse drag
		autoplayHoverPause: true, // Stop autoplay on mouse hover
		loop: false,
		slideBy: 1, // Number of item are slided for each one transition
		margin: 20, // space between each item. Very useful!
		stagePadding: 0, // This used to see part of left an right items as preview style
		nav: false, // show prev and next buttons
		dots: false, // Show dots navigation
		navText: ["<i class=\"fa fa-angle-left\"></i>","<i class=\"fa fa-angle-right\"></i>"], // prev and next buttons content
		responsive : {
			0 : {
		        items : 2
		    },
		    480 : {
		        items : 3
		    },
		    600 : {
		        items : 4
		    },
		    768 : {
		        items : 4
		    },
		    1024 : {
		        items : 3
		    }
		},
		autoHeight: true,
		autoWidth: false,
		// animateOut: 'goDownOut',
	    // animateIn: 'goDownIn',
		navRewind: true,
		center: false, // It's used to make the carousel start from the centered item
		dotsEach: 1, // Number of items per dot
		dotData: false,
		lazyLoad: false, // img tag needs class="owl-lazy" and data-src="url-to-img" or/and data-src-retina="url-to-highres-img"
		smartSpeed: 600, // Sliding speed when hover next or prev nav
		fluidSpeed: 5000,
		navSpeed: 400,
		// fallbackEasing: "ease-in-out",
		dotsSpeed: 400 // Sliding speed by using dots
	});
}


// *** Slider Boxes Features 3 *** //
function sliderBoxesFeatures3() {
	var sliderBoxesFeatures3 = $( ".slider-boxes-features-3 > .owl-carousel" );

	sliderBoxesFeatures3.on("initialized.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-3 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? d.eq(e).addClass("highlighted") : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && d.eq(e).addClass("highlighted") }), sliderBoxesFeatures3.on("resized.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-3 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) }), $(".slider-boxes-features-3 > .owl-carousel").on("translate.owl.carousel", function (s) { var e = s.item.index, d = $(".slider-boxes-features-3 > .owl-carousel .owl-item"); $body.hasClass("device-lg") || $body.hasClass("device-md") ? (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) : ($body.hasClass("device-sm") || $body.hasClass("device-xs") || $body.hasClass("device-xxs")) && (d.removeClass("highlighted"), d.eq(e).addClass("highlighted")) });	

	sliderBoxesFeatures3.owlCarousel({
		// items: 3,
		rtl: owlRtl,
		autoplay: false,
		autoplaySpeed: 500, // Sliding autoplay speed
		autoplayTimeout: 5000, // Autoplay interval timeout.
		dragEndSpeed: 350, // Sliding speed by mouse drag
		autoplayHoverPause: true, // Stop autoplay on mouse hover
		loop: false,
		slideBy: 1, // Number of item are slided for each one transition
		margin: 20, // space between each item. Very useful!
		stagePadding: 0, // This used to see part of left an right items as preview style
		nav: false, // show prev and next buttons
		dots: false, // Show dots navigation
		navText: ["<i class=\"fa fa-angle-left\"></i>","<i class=\"fa fa-angle-right\"></i>"], // prev and next buttons content
		responsive : {
			0: {
				items: 2
			},
			480: {
				items: 3
			},
			600: {
				items: 4
			},
			768: {
				items: 4
			},
			1024: {
				items: 3
			}
		},
		autoHeight: true,
		autoWidth: false,
		// animateOut: 'goDownOut',
	    // animateIn: 'goDownIn',
		navRewind: true,
		center: false, // It's used to make the carousel start from the centered item
		dotsEach: 1, // Number of items per dot
		dotData: false,
		lazyLoad: false, // img tag needs class="owl-lazy" and data-src="url-to-img" or/and data-src-retina="url-to-highres-img"
		smartSpeed: 600, // Sliding speed when hover next or prev nav
		fluidSpeed: 5000,
		navSpeed: 400,
		// fallbackEasing: "ease-in-out",
		dotsSpeed: 400 // Sliding speed by using dots
	});
}


// *** Counter Stats *** //
function counterStats() { $(".counter-stats").each(function () { var t = $(this), i = t.text(), a = i.toString().replace(/(\d)/g, "<span class='digit'><span class='digit-value'>$1</span></span>"); t.html(a + "<div class='main'>" + i + "</span>"), t.find(".digit").each(function () { var t = $(this), i = t.find(".digit-value").text(); t.append("<div class='counter-animator' data-value='" + i + "'><ul><li>0</li><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li></ul></div>") }) }), $(".counter-stats").each(function (i) { var a = $(this); new Waypoint({ element: a, handler: function (t) { setTimeout(function () { setTimeout(function () { 1 < $(window).width() && a.find(".counter-animator").each(function () { var t = $(this), i = 10 * t.data("value"); t.find("ul").css({ transform: "translateY(-" + i + "%)", "-webkit-transform": "translateY(-" + i + "%)", "-moz-transform": "translateY(-" + i + "%)", "-ms-transform": "translateY(-" + i + "%)", "-o-transform": "translateY(-" + i + "%)" }) }) }, 0 * i) }, 0) }, offset: "100%" }) }) }

// *** Slider Testimonials *** //
function sliderTestimonials() {
	var sliderTestimonials = $( ".slider-testimonials > .owl-carousel" );	

	sliderTestimonials.owlCarousel({
		// items: 3,
		rtl: owlRtl,
		autoplay: false,
		autoplaySpeed: 500, // Sliding autoplay speed
		autoplayTimeout: 5000, // Autoplay interval timeout.
		dragEndSpeed: 350, // Sliding speed by mouse drag
		autoplayHoverPause: true, // Stop autoplay on mouse hover
		loop: false,
		slideBy: 1, // Number of item are slided for each one transition
		margin: 20, // space between each item. Very useful!
		stagePadding: 0, // This used to see part of left an right items as preview style
		nav: false, // show prev and next buttons
		dots: false, // Show dots navigation
		navText: ["<i class=\"fa fa-angle-left\"></i>","<i class=\"fa fa-angle-right\"></i>"], // prev and next buttons content
		responsive : {
			0 : {
		        items : 1
		    },
		    480 : {
		        items : 1
		    },
		    // 600 : {
		    //     items : 2
		    // },
		    768 : {
		        items : 2
		    },
		    1024 : {
		        items : 3
		    }
		},
		autoHeight: true,
		autoWidth: false,
		// animateOut: 'goDownOut',
	    // animateIn: 'goDownIn',
		navRewind: true,
		center: false, // It's used to make the carousel start from the centered item
		dotsEach: 1, // Number of items per dot
		dotData: false,
		lazyLoad: false, // img tag needs class="owl-lazy" and data-src="url-to-img" or/and data-src-retina="url-to-highres-img"
		smartSpeed: 600, // Sliding speed when hover next or prev nav
		fluidSpeed: 5000,
		navSpeed: 400,
		// fallbackEasing: "ease-in-out",
		dotsSpeed: 400 // Sliding speed by using dots
	});
}


// *** Scroll To *** //
$(  ".scroll-to" ).on(  "click", function( e ) {
    e.preventDefault();
    var $anchor = $(this);      

    // scroll to specific anchor
    $(  "html, body" ).stop().animate({
        scrollTop: $( $anchor.attr( "href" ) ).offset().top
    } , 1200 , "easeInOutExpo" );
});    


// *** Form CTA Subscribe 2 *** //
var csNotifications = $( ".cs-notifications" );

function formCTASubscribe2() {
	$("#form-cta-subscribe-2").validate({
		// rules
		rules: {
			cs2Name: {
				required: true,
				minlength: 3
			},
			cs2Email: {
				required: true,
				email: true
			},
			cs2PhoneNum: {
				required: true,
				number: true,
				minlength: 12,
				maxlength: 12
			}
		}
	});

	var errorMsgData = csNotifications.data("error-msg"),
		errorMsgDefault = 'Please Follow Error Messages and Complete as Required',
		errorMsg = (errorMsgData) ? (errorMsgData) : errorMsgDefault;

	// Submit event
	$("#form-cta-subscribe-2").on("submit", function (event) {
		if (event.isDefaultPrevented()) {
			var errorContent = '<i class="cs-error-icon fas fa-times"></i>' +
				errorMsg;
			cs2SubmitMSG(false, errorContent);
			cs2Error();
		} else {
			event.preventDefault();
			cs2SubmitForm();
		}
	});
}

function cs2SubmitForm() {
	// Initiate Variables With Form Content
	var name = $("#cs2Name").val();
	var email = $("#cs2Email").val();
	var phoneNum = $("#cs2PhoneNum").val();

	$.ajax({
		type: "POST",
		url: "./php/cs2-process.php",
		data: "cs2Name=" + name + "&cs2Email=" + email + "&cs2PhoneNum=" + phoneNum,
		success: function (text) {
			if (text == "success") {
				cs2Success();
			} else {
				cs2Error();
				cs2SubmitMSG(false, text);
			}
		}
	});
}

function cs2Success(){var i=csNotifications.data("success-msg"),s=i||"Thank you for your submission :)";$("#form-cta-subscribe-2")[0].reset(),cs2SubmitMSG(!0,'<i class="cs-success-icon fas fa-check"></i>'+s),$(".cs-notifications-content").addClass("sent"),csNotifications.css("opacity",0),csNotifications.slideDown(300).animate({opacity:1},300).delay(5e3).slideUp(400),$("#form-cta-subscribe-2").hasClass("redirected")&&setTimeout(function(){window.location.href="thank-you-page.html"},3e3)}function cs2Error(){csNotifications.css("opacity",0),csNotifications.slideDown(300).animate({opacity:1},300),$(".cs-notifications-content").removeClass("sent")}function cs2SubmitMSG(i,s){var n;n="shake animated",csNotifications.delay(300).addClass(n).one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",function(){$(this).removeClass("shake bounce animated")}),csNotifications.children(".cs-notifications-content").html(s)}


// *** Replace all SVG images with inline SVG *** //
jQuery('img.svg').each(function(){
    var $img = jQuery(this);
    var imgID = $img.attr('id');
    var imgClass = $img.attr('class');
    var imgURL = $img.attr('src');

    jQuery.get(imgURL, function(data) {
        // Get the SVG tag, ignore the rest
        var $svg = jQuery(data).find('svg');

        // Add replaced image's ID to the new SVG
        if(typeof imgID !== 'undefined') {
            $svg = $svg.attr('id', imgID);
        }
        // Add replaced image's classes to the new SVG
        if(typeof imgClass !== 'undefined') {
            $svg = $svg.attr('class', imgClass+' replaced-svg');
        }

        // Remove any invalid XML tags as per http://validator.w3.org
        $svg = $svg.removeAttr('xmlns:a');

        // Replace image with new SVG
        $img.replaceWith($svg);

    }, 'xml');

});

} )( jQuery );


function convertHex( hex , opacity ){
	// "use strict";
	// var r, g, b, result;
    hex = hex.replace( '#' , '' );
    r = parseInt( hex.substring( 0 , 2 ) , 16 );
    g = parseInt( hex.substring( 2 , 4 ) , 16 );
    b = parseInt( hex.substring( 4 , 6 ) , 16 );

    result = 'rgba('+r+', '+g+', '+b+', '+opacity+')';
    return result;
}
