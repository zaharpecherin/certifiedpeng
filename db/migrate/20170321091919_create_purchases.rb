class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.string :charge_id
      t.string :email
      t.string :item
      t.timestamps
    end
  end
end
