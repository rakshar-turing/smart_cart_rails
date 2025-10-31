# spec/services/intent_aware_cart_service_spec.rb
require 'rails_helper'

RSpec.describe IntentAwareCartService, type: :service do
  let(:user) { create(:user) }
  let(:cart) { create(:cart) }
  let!(:shampoo) { Product.create!(name: "Shampoo", price: 10.0) }
  let!(:conditioner) { Product.create!(name: "Conditioner", price: 12.0) }

  context "when complementary items are present" do
    it "returns matching combo pack suggestion" do
      cart.cart_items.create!(product: shampoo, quantity: 1)
      cart.cart_items.create!(product: conditioner, quantity: 1)

      service = described_class.new(cart)
      result = service.suggestions

      expect(result).to include(
        a_hash_including(suggestion: "Hair-Care Combo Pack")
      )
    end
  end

  context "when no intent patterns match" do
    it "returns empty array" do
      unrelated_product = Product.create!(name: "Book", price: 5)
      cart.cart_items.create!(product: unrelated_product, quantity: 1)

      service = described_class.new(cart)
      expect(service.suggestions).to eq([])
    end
  end
end
