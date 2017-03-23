class StripeController < ApplicationController
  protect_from_forgery :except => :webhooks
  skip_before_action :check_subscribtion

  def webhooks
    data_json = JSON.parse request.body.read

    if data_json['type'] == 'customer.subscription.updated'
      subscriber = Subscriber.find_by_stripe_id(data_json['data']['object']['customer'])
      subscriber.end_date = Time.at(data_json['data']['object']['current_period_end']).to_datetime
      subscriber.subscribed = true
      subscriber.save
    elsif data_json['type'] == 'customer.subscription.deleted'
      subscriber = Subscriber.find_by_stripe_id(data_json['data']['object']['customer'])
      subscriber.end_date = nil
      subscriber.subscribed = false
      subscriber.save
    end

    render nothing: true
  end

end