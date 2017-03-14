class RenameProductTableToTagsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table :products, :tags
    rename_column :tags, :product_name, :tag_name
    rename_column :likes, :product_name, :tag_name
  end
end