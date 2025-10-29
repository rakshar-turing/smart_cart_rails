require 'rails_helper'

RSpec.describe "SharedCarts", type: :request do
  let(:user) { create(:user) }
  let!(:cart) { create(:cart, user: user) }

  before { sign_in user }

  describe "POST /shared_carts" do
    it "creates and returns a shareable link" do
      post "/shared_carts", params: { cart_id: cart.id }
      expect(response).to have_http_status(:created)
      data = JSON.parse(response.body)
      expect(data["link"]).to match(/shared_carts/)
    end
  end

  describe "GET /shared_carts/:token" do
    let(:shared_cart) { create(:shared_cart, cart: cart, expires_at: 2.days.from_now) }

    it "shows shared cart details" do
      get "/shared_carts/#{shared_cart.token}"
      expect(response).to have_http_status(:ok)
      data = JSON.parse(response.body)
      expect(data["cart"]["id"]).to eq(cart.id)
    end

    it "returns error for expired link" do
      shared_cart.update!(expires_at: 1.day.ago)
      get "/shared_carts/#{shared_cart.token}"
      expect(response).to have_http_status(:gone)
    end

    it "returns 404 for invalid token" do
      get "/shared_carts/invalidtoken"
      expect(response).to have_http_status(:not_found)
    end
  end
end
