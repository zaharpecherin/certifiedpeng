Rails.configuration.stripe = {
    publishable_key: ENV['STRIPE_PUBLISHABLE_KEY']||'pk_test_6pEaHVuRpnmLV9xhrsq5yr2t',
    secret_key: ENV['STRIPE_SECRET_KEY']||'sk_test_8zn1uJ80QG6tpSHgVmvmlTYB'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
