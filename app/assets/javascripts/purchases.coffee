charge =
  init: ->
    do @detectElements
    do @buyItem

  detectElements: ->
    @handler_option = {
      name: 'Buy T-Shirt'
      description: ''
      amount: 2875
      currency: 'GBP'
      billingAddress: true
      shippingAddress: true
    }

    @handler = StripeCheckout.configure(
      key: stripe_pub_key
      image: 'https://s23.postimg.org/xdexz2b8b/image.jpg'
      locale: 'auto'
      token: (token) ->
        options = {
          stripe_token: token.id
          email: token.email
          amount: charge.handler_option.amount
          description: charge.handler_option.description
        }
        $.post '/purchases', options, (data) ->
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