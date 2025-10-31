class AddSmartCartFieldsToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_discontinued, :boolean
    add_column :products, :product_version, :string
  end
end
