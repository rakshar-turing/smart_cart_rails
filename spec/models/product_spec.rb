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

  describe '#similar_products' do
    let!(:phone1) { create(:product, name: 'iPhone 15', category: 'Phones') }
    let!(:phone2) { create(:product, name: 'Pixel 8', category: 'Phones') }
    let!(:laptop) { create(:product, name: 'MacBook Air', category: 'Laptops') }

    it 'returns products from the same category' do
      expect(phone1.similar_products).to include(phone2)
      expect(phone1.similar_products).not_to include(laptop)
    end

    it 'limits the number of results' do
      create_list(:product, 5, category: 'Phones')
      expect(phone1.similar_products(3).count).to eq(3)
    end

    it 'uses name matching if no category present' do
      item = create(:product, name: 'Red Mug', category: nil)
      similar = create(:product, name: 'Blue Mug', category: nil)
      expect(item.similar_products).to include(similar)
    end
  end
end
