# app/controllers/cart_cleanups_controller.rb
class CartCleanupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, raise: false
  skip_after_action :verify_authorized, raise: false
  before_action :set_cart

  def cleanup
    results = SmartCartCleanupService.new(@cart).perform

    if results.any?
      render json: { upgraded_items: results }, status: :ok
    else
      render json: { message: "All items up-to-date!" }, status: :ok
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
