require 'rails_helper'

RSpec.describe "CartTrends", type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  before do
    @product1 = create(:product, name: "Headphones", price: 100)
    @product2 = create(:product, name: "Shoes", price: 200)
    create_list(:cart_item, 3, cart: cart, product: @product1)
    create_list(:cart_item, 1, cart: cart, product: @product2)
  end

  it "returns trending items by purchase count" do
    get trending_items_cart_path(cart.id)
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body["trending"].first["name"]).to eq("Headphones")
  end

  it "limits to 5 items" do
    create_list(:product, 10)
    get trending_items_cart_path(cart.id)
    body = JSON.parse(response.body)
    expect(body["trending"].length).to be <= 5
  end

  it "returns items ordered by descending purchase count" do
    get trending_items_cart_path(cart.id)
    body = JSON.parse(response.body)
    purchases = body["trending"].map { |t| t["purchases"] }
    expect(purchases).to eq(purchases.sort.reverse)
  end
  
  it "includes purchase count in response" do
    get trending_items_cart_path(cart.id)
    body = JSON.parse(response.body)
    expect(body["trending"].first).to include("id", "name", "price", "purchases")
  end
end
