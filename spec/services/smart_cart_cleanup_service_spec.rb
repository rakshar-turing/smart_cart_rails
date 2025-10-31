require 'rails_helper'

RSpec.describe SmartCartCleanupService do
  let(:user) { create(:user) }
  let(:cart) { Cart.create!(user: user, status: "active") }

  describe "when cart has outdated items" do
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

    it "upgrades them to latest models" do
      allow(SmartCartCatalog).to receive(:replacement_for).and_return("Phone X")
      allow(SmartCartCatalog).to receive(:latest_version_for).and_return("2.0")

      updates = SmartCartCleanupService.new(cart).perform

      expect(updates).to include({ old: "Phone", new: "Phone X" })
      expect(cart_item.reload.product_version).to eq("2.0")
      expect(cart_item.is_discontinued).to be(false)
    end
  end

  describe "when cart has no outdated items" do
    let!(:product) { Product.create!(name: "Laptop", price: 1000, product_version: "1.0", is_discontinued: false) }
    let!(:cart_item) do
      cart.cart_items.create!(
        product: product,
        quantity: 1,
        product_version: "1.0",
        is_discontinued: false
      )
    end

    it "returns empty updates array" do
      allow(SmartCartCatalog).to receive(:replacement_for).and_return(nil)

      updates = SmartCartCleanupService.new(cart).perform
      expect(updates).to be_empty
    end
  end
end
