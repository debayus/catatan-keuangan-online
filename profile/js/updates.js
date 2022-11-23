( function( $ ) {

"use strict";

// *** On ready *** //
$( document ).on( "ready" , function() {
	superfishMenu();
	bannerSlider();
	bannerSliderBG();
	optimizeBanSliderBG();
	featuredPorductsSlider();
	ourProductsTabs();
	brandsSlider();
	deadlineTimer();
	itemClickCounter();
	offersSliderSync();
});

// *** On load *** //
$( window ).on( "load" , function() {
	WOWAnimation();
	bannerSliderBG();
});

// *** On resize *** //
$( window ).on( "resize" , function() {
	optimizeBanSliderBG();
});

// *** On scroll *** //
$( window ).on( "scroll" , function() {

});


// *** jQuery noConflict *** //
var $ = jQuery.noConflict();



// *** Code Starts Here... *** //




} )( jQuery );


