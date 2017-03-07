class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.string :url
      t.integer :ip
      t.string :product_name
      t.timestamps
    end
  end
end