# spec/requests/cart_intents_spec.rb
require 'rails_helper'

RSpec.describe "CartIntents", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart) }
  let!(:shampoo) { Product.create!(name: "Shampoo", price: 10.0) }
  let!(:conditioner) { Product.create!(name: "Conditioner", price: 12.0) }

  describe "GET /carts/:id/intent_suggestions" do
    context "when relevant suggestions exist" do
      it "returns relevant intent-based recommendations" do
        cart.cart_items.create!(product: shampoo, quantity: 1)
        cart.cart_items.create!(product: conditioner, quantity: 1)

        get intent_suggestions_cart_path(cart)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["suggestions"].first["suggestion"])
          .to eq("Hair-Care Combo Pack")
      end
    end

    context "when no relevant suggestions exist" do
      it "returns a no suggestions message" do
        unrelated_product = Product.create!(name: "Pen", price: 2)
        cart.cart_items.create!(product: unrelated_product, quantity: 1)

        get intent_suggestions_cart_path(cart)

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("No relevant suggestions found.")
      end
    end
  end
end
