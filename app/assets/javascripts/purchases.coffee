charge =
  init: ->
    do @detectElements
    do @buyItem

  detectElements: ->
    @handler_option = {
      name: 'Buy T-Shirt'
      description: ''
      amount: 2500
      currency: 'GBP'
      billingAddress: true
      shippingAddress: true
    }

    @handler = StripeCheckout.configure(
      key: stripe_pub_key
      image: 'https://stripe.com/img/documentation/checkout/marketplace.png'
      locale: 'auto'
      token: (token) ->
        options = {
          stripe_token: token.id
          email: token.email
          amount: charge.handler_option.amount
          description: charge.handler_option.description
        }
        $.post '/purchases', options, (data) ->
        # location href
    )


  buyItem: ->
    $('.buy-item').on 'click', (e) ->
      e.preventDefault()
      charge.handler_option.description = $(this).data('item')
      charge.handler.open(charge.handler_option)

    window.addEventListener 'popstate', ->
      charge.handler.close()
      return

$(document).on 'turbolinks:load', ->
  charge.init() if typeof(StripeCheckout) is 'object'