class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: true, foreign_key: true  # user who owns the cart
      t.string :status, default: "active", null: false   # e.g., active, checked_out, abandoned
      t.decimal :total_price, precision: 10, scale: 2, default: 0.0
      t.timestamps
    end
  end
end

