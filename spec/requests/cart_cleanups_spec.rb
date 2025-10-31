require 'rails_helper'

RSpec.describe "CartCleanups", type: :request do
  describe "PATCH /carts/:id/cleanup" do
    let!(:user) { create(:user) }
    let!(:cart) { Cart.create!(user: user, status: "active") }

    let!(:old_product) { Product.create!(name: "Phone", price: 500, product_version: "1.0", is_discontinued: true) }
    let!(:new_product) { Product.create!(name: "Phone X", price: 700, product_version: "2.0", is_discontinued: false) }

    let!(:cart_item) do
      cart.cart_items.create!(
        product: old_product,
        quantity: 1,
        product_version: "1.0",
        is_discontinued: true
      )
    end

    it "returns a list of upgraded items" do
      allow(SmartCartCatalog).to receive(:replacement_for).and_return("Phone X")
      allow(SmartCartCatalog).to receive(:latest_version_for).and_return("2.0")

      patch cleanup_cart_path(cart), as: :json

      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body["upgraded_items"]).to include({ "old" => "Phone", "new" => "Phone X" })
    end

    it "returns message if no updates needed" do
      allow(SmartCartCatalog).to receive(:replacement_for).and_return(nil)

      patch cleanup_cart_path(cart), as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("All items up-to-date!")
    end
  end
end
