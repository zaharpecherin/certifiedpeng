class CreateSubscribers < ActiveRecord::Migration[5.0]
  def change
    create_table :subscribers do |t|
      t.integer :user_id
      t.string :stripe_id
      t.boolean :subscribed
      t.datetime :end_date
      t.timestamps
    end
  end
end
