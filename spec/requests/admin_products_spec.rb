require "rails_helper"

RSpec.describe "Admin::Products", type: :request do
  let(:admin) { create(:user, :admin) }
  let!(:low_product) { create(:product, name: "Low", stock: 1, low_stock_threshold: 5) }
  let!(:ok_product)  { create(:product, name: "OK", stock: 10, low_stock_threshold: 5) }

  describe "GET /admin/products/low_stock" do
    context "as admin" do
      it "shows only low stock products" do
        sign_in admin
        get low_stock_admin_products_path

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("Low")
        expect(response.body).not_to include("OK")
      end
    end

    context "as regular user" do
      it "returns forbidden" do
        user = create(:user)
        sign_in user
        get low_stock_admin_products_path
        expect(response).to have_http_status(:forbidden)
      end
    end

    context "as guest" do
      it "redirects to sign in" do
        get low_stock_admin_products_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
