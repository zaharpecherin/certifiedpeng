class PurchasesController < ApplicationController
  skip_before_action :check_subscribtion

  def index
    if current_user
      @purchases = current_user.get_purchases
    end
  end

  def create
    charge = Purchase.buy_item(params)
    if charge == 'success'
      flash[:notice] = 'Your payment has been successfully processed'
      redirect_to purchases_path
    else
      flash[:error] = charge
      redirect_to merchandise_path
    end
  end

end
