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

// $(document).on('click', '.link-tr', function(e) {
//     var link = e.currentTarget.dataset.link;
//     window.location = link;
// });

$(document).on('change', '.terms-confirm',  function(e) {
    var button = $('.sign-up-button');
    if ($(this).attr("id") == 'terms-pay_acepted') {
        button = $('.stripe-button-el');
    }
    if ($(this).is(':checked')) {
        button.prop( "disabled", false );
    }
    else{
        button.prop( "disabled", true );
    }
});