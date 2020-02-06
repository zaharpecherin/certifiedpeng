//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.cookieMessage
//= require_tree .

$(document).on('turbolinks:load', function(){
    setTimeout(function(){
        $( ".stripe-button-el" ).prop( "disabled", true );
    }, 500);

    $.cookieMessage({
        'mainMessage':'This website uses cookies. By using this website you consent to our use of these cookies. For more information visit our <a href="https://www.certifiedpeng.com/terms#cookies">Privacy Policy</a>. '
    });
});


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
