class CreateSharedCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :shared_carts do |t|
      t.references :cart, null: false, foreign_key: true
      t.string :token, null: false, index: { unique: true }
      t.datetime :expires_at
      t.timestamps
    end
  end
end

