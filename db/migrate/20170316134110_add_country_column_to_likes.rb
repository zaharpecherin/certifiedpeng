class AddCountryColumnToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :country, :string
  end
end
