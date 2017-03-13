Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY']||'pk_test_m5h4GyqOsPVSBxWAzIqbM1MP',
    secret_key: ENV['STRIPE_SECRET_KEY']||'sk_test_rSJlabP3o0Iaf4JxFirzQ7RD'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

