# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: %i[index show]

  def index
    @products = policy_scope(Product)
  end

  def show
    @product = Product.find(params[:id])
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      redirect_to @product, notice: 'Product created.'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
