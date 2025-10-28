require "rails_helper"

RSpec.describe "Products", type: :request do
  let!(:product) { Product.create!(name: "Phone", price: 500) }

  it "renders the index page" do
    get "/products"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Phone")
  end

  it "renders the show page" do
    get "/products/#{product.id}"
    expect(response.body).to include("Phone")
  end
end
