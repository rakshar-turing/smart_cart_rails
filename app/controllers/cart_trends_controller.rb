class CartTrendsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def trending_items
    cart = Cart.find_by(id: params[:id])
    return render json: { error: "Cart not found" }, status: :not_found unless cart

    begin
      trending = Product
        .joins(:cart_items)
        .where("cart_items.created_at >= ?", 1.week.ago)
        .group("products.id")
        .order(Arel.sql("COUNT(cart_items.id) DESC"))
        .limit(5)
        .select("products.*, COUNT(cart_items.id) AS purchases")

      render json: {
        trending: trending.map do |p|
          {
            id: p.id,
            name: p.name,
            price: p.price,
            purchases: p.try(:purchases).to_i
          }
        end
      }
    rescue => e
      render json: {
        error: e.message,
        backtrace: e.backtrace.take(10)
      }, status: :internal_server_error
    end
  end
end
