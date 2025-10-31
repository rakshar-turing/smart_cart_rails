# app/services/smart_cart_cleanup_service.rb
class SmartCartCleanupService
  def initialize(cart)
    @cart = cart
  end

  def perform
    updates = []

    @cart.cart_items.includes(:product).each do |item|
      product = item.product
      next unless product

      if product_outdated_or_discontinued?(product)
        replacement = SmartCartCatalog.replacement_for(product.name)
        next unless replacement

        new_product = Product.find_by(name: replacement)
        next unless new_product

        updates << {
          old: product.name,
          new: new_product.name
        }

        item.update!(
          product_id: new_product.id,
          product_version: SmartCartCatalog.latest_version_for(new_product.name),
          is_discontinued: false
        )
      end
    end

    updates
  end

  private

  def product_outdated_or_discontinued?(product)
    product.respond_to?(:is_discontinued) && product.is_discontinued ||
      product.respond_to?(:outdated_version?) && product.outdated_version?
  end
end
