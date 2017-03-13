class SubscribersController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    token = params[:stripeToken]
    if params[:stripeEmail] != current_user.email
      flash[:error] = 'Email not equal with your account email, please try again!'
      redirect_to root_path
    else
      customer = Stripe::Customer.create(
          card: token,
          plan: 1,
          email: current_user.email )

      end_date = Time.at(customer.subscriptions.data[0].current_period_end)

      if customer
        Subscriber.create(user_id: current_user.id, stripe_id: customer.id, subscribed: true, end_date: end_date )

        flash[:notice] = 'Your payment has been successfully processed'
        redirect_to root_path
      else
        flash[:error] = 'Something gone wrong!'
        redirect_to root_path
      end
    end



  end
end
