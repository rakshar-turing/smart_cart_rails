class AddStockAndLowStockToProducts < ActiveRecord::Migration[7.1]
  def up
    add_column :products, :stock, :integer, default: 0, null: false
    add_column :products, :low_stock_threshold, :integer, default: 5, null: false
    add_column :products, :low_stock_notified_at, :datetime
    add_column :products, :webhook_url, :string
    add_column :products, :notified, :boolean ,default: false
    add_index :products, :stock
  end

  def down
    remove_column :products, :stock, :integer, default: 0, null: false
    remove_column :products, :low_stock_threshold, :integer, default: 5, null: false
    remove_column :products, :low_stock_notified_at, :datetime
    remove_column :products, :webhook_url, :string
    remove_column :products, :notified, :boolean ,default: false
    remove_index :products, :stock
  end
end
