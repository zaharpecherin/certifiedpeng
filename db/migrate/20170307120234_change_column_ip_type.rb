class ChangeColumnIpType < ActiveRecord::Migration[5.0]
  def change
    change_column :likes, :ip, :string
  end
end
