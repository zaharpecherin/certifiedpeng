class SubscribersController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    subscription = Subscriber.subscribe(current_user, params[:stripeToken])

    if subscription == 'success'
      flash[:notice] = 'Your payment has been successfully processed'
      redirect_to dashboard_path
    else
      flash[:error] = subscription
      redirect_to new_subscriber_path
    end
  end
end
