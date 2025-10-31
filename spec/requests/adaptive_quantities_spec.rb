# spec/requests/adaptive_quantities_spec.rb
require 'rails_helper'

RSpec.describe "AdaptiveQuantities", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart) }

  let!(:product1) { Product.create!(name: "Shampoo", price: 100) }
  let!(:product2) { Product.create!(name: "Conditioner", price: 120) }

  before do
    cart.cart_items.create!(product: product1, quantity: 1) # id = 1 (odd)
    cart.cart_items.create!(product: product2, quantity: 1) # id = 2 (even)
  end

  describe "GET /carts/:id/quantity_suggestions" do
    context "when suggestions exist" do
      it "returns relevant quantity recommendations" do
        get quantity_suggestions_cart_path(cart.id)
        expect(response).to have_http_status(:ok)

        data = JSON.parse(response.body)
        expect(data["suggestions"]).not_to be_empty
        expect(data["suggestions"].first["message"]).to include("You usually buy 2 of this item")
      end
    end

    context "when no suggestions exist" do
      it "returns message with no suggestions" do
        empty_cart = Cart.create!(user: user, status: "active")
        get quantity_suggestions_cart_path(empty_cart.id)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("No quantity adjustments suggested.")
      end
    end
  end
end
