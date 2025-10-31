class AddPurchaseCountToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :purchase_count, :integer
  end
end
