require "rails_helper"

RSpec.describe Product, type: :model do
  it "is valid with name and price" do
    expect(Product.new(name: "Test", price: 10)).to be_valid
  end

  it "is invalid without name" do
    expect(Product.new(price: 10)).not_to be_valid
  end

  it "formats price correctly" do
    product = Product.new(name: "Apple", price: 2.5)
    expect(product.formatted_price).to eq("$2.50")
  end
end
