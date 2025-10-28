# spec/requests/products_spec.rb
require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { create(:user, :customer) } # or :admin, as needed
  let!(:product) { create(:product, name: "Phone") }

  before { sign_in user }

  it "renders the index page" do
    get products_path
    expect(response).to have_http_status(:ok)
  end

  it "renders the show page" do
    get product_path(product)
    expect(response.body).to include("Phone")
  end
end
