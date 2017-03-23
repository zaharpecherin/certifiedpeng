// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
    $( ".stripe-button-el" ).prop( "disabled", true );
    setTimeout(function(){
        $( ".stripe-button-el" ).prop( "disabled", true );
    }, 500);
});

$(document).on('click', '.link-tr', function(e) {
    var link = e.currentTarget.dataset.link;
    window.location = link;
});

$(document).on('change', '#terms_acepted',  function(e) {
    if ($(this).is(':checked')) {
        $( ".sign-up-button" ).prop( "disabled", false );
    }
    else{
        $( ".sign-up-button" ).prop( "disabled", true );
    }
});

$(document).on('change', '#terms-pay_acepted',  function(e) {
    if ($(this).is(':checked')) {
        $( ".stripe-button-el" ).prop( "disabled", false );
    }
    else{
        $( ".stripe-button-el" ).prop( "disabled", true );
    }
});

