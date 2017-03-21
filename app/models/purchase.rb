class Purchase < ActiveRecord::Base

  #params - email, amount, description. token
  def self.buy_item(params={})
    begin
      stripe_charge = Stripe::Charge.create(
        amount: params[:amount],
        currency: 'gbp',
        source: params[:stripe_token],
        receipt_email: params[:email],
        description: params[:description]
      )
      if stripe_charge
        Purchase.create(charge_id: stripe_charge.id, email: params[:email], item: params[:description])
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

