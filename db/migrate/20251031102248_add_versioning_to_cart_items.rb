class AddVersioningToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :product_version, :string
    add_column :cart_items, :is_discontinued, :boolean, default: false
  end
end
