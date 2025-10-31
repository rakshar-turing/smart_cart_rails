class AdaptiveQuantityService
  # Analyze user's past purchases or cart patterns to suggest quantity adjustments
  def initialize(user)
    @user = user
  end

  def suggest_quantity_adjustments(cart)
    return [] unless @user && cart

    cart.cart_items.map do |item|
      past_quantity = past_purchase_quantity(item.product_id)
      next unless past_quantity && past_quantity > item.quantity

      {
        product_id: item.product_id,
        current_quantity: item.quantity,
        suggested_quantity: past_quantity,
        message: "You usually buy #{past_quantity} of this item — add another?"
      }
    end.compact
  end

  private

  # Stubbed behavior: In a real app, would query past orders or user history
  def past_purchase_quantity(product_id)
    # Example heuristic: if product_id is even, suggest increasing by 1
    if product_id.even?
      2
    elsif product_id % 3 == 0
      3
    else
      nil
    end
  end
end
