class CreateProduct < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :user_id
      t.string :product_name
    end
  end
end
