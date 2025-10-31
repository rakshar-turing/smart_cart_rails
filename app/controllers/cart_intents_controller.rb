class CartIntentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, raise: false
  skip_after_action :verify_authorized, raise: false
  
  def suggestions
    cart = Cart.find(params[:id])
    suggestions = IntentAwareCartService.new(cart).suggestions

    if suggestions.any?
      render json: { suggestions: suggestions }, status: :ok
    else
      render json: { message: "No relevant suggestions found." }, status: :ok
    end
  end
end
