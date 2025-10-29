class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  skip_after_action :verify_authorized, only: :low_stock

  def low_stock
    @products = Product.where("stock < low_stock_threshold")
    authorize Product
    render :low_stock
  end

  private

  def authorize_admin!
    render plain: "Forbidden", status: :forbidden unless current_user.admin?
  end
end
