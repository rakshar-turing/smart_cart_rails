class AdaptiveQuantitiesController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  before_action :set_cart

  def suggestions
    suggestions = []

    @cart.cart_items.each do |item|
      # Simple heuristic: if quantity is odd, suggest +1
      if item.quantity.odd?
        suggestions << {
          product_id: item.product_id,
          message: "You usually buy 2 of this item — add another?"
        }
      end
    end

    if suggestions.any?
      render json: { suggestions: suggestions }, status: :ok
    else
      render json: { message: "No quantity adjustments suggested." }, status: :ok
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cart not found" }, status: :not_found
  end
end
