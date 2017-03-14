class Subscriber < ActiveRecord::Base
  belongs_to :user

  def self.subscribe(user, stripe_token)
    begin
      subscription = user.subscriber || user.create_subscriber

      if subscription.stripe_id
        stripe_customer = Stripe::Customer.retrieve(subscription.stripe_id)
        stripe_customer.source = stripe_token
        stripe_customer.save
      else
        stripe_customer = Stripe::Customer.create(
          card: stripe_token,
          email: user.email,
          description: "Customer userID - #{user.id}"
        )
      end

      if stripe_customer
        stripe_subscription = Stripe::Subscription.create(
          customer: stripe_customer.id,
          plan: 'monthyplan'
        )

        if stripe_subscription && stripe_subscription.id
          subscription.update_attributes(end_date: Time.at(stripe_subscription.current_period_end), stripe_id: stripe_customer.id, subscribed: true)
        end
      end
      return 'success'
    rescue Stripe::CardError => e
      return e
    rescue Stripe::InvalidRequestError => e
      return e
    rescue => e
      return e
    end
  end
end
