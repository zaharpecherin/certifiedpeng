class AddEditedColumnToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :edited, :boolean, default: false
  end
end
