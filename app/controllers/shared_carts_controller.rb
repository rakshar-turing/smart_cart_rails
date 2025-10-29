class SharedCartsController < ApplicationController
  skip_after_action :verify_authorized, only: [:create, :show]
  before_action :set_shared_cart, only: [:show]

  def create
    cart = Cart.find_by(id: params[:cart_id])
    return render json: { error: 'Cart not found' }, status: :not_found unless cart

    shared_cart = SharedCart.new(cart: cart)

    if shared_cart.save
      render json: { link: shared_cart_url(shared_cart.token) }, status: :created
    else
      render json: { errors: shared_cart.errors.full_messages }, status: :unprocessable_content
    end
  end

  def show
    authorize @shared_cart

    if @shared_cart.expired?
      render json: { error: "Link expired" }, status: :gone
    else
      render json: { cart: @shared_cart.cart }, status: :ok
    end
  end

  private

  def set_shared_cart
    @shared_cart = SharedCart.find_by!(token: params[:token])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end
end
