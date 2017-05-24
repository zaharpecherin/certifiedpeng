class PurchasesController < ApplicationController

  def index
    if current_user
      @purchases = current_user.get_purchases
    else
      redirect_to root_path
    end
  end

  def confirm_purchase; end

  def create
    charge = Purchase.buy_item(params)
    if charge == 'success'
      flash[:notice] = 'Your payment has been successfully processed'
      redirect_to confirm_purchase_purchases_path
    else
      flash[:error] = charge
      redirect_to merchandise_path
    end
  end

end
