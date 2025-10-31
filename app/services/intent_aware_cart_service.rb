class IntentAwareCartService
  def initialize(cart)
    @cart = cart
  end

  def suggestions
    items = @cart.cart_items.includes(:product).map { |i| i.product.name.downcase }
    suggestions = []

    intent_rules.each do |base_item, data|
      if (data[:pairs_with] - items).empty? && items.include?(base_item)
        suggestions << {
          base_items: data[:pairs_with].unshift(base_item).uniq,
          suggestion: data[:suggest]
        }
      end
    end

    suggestions.uniq
  end

  private

  def intent_rules
    {
      "shampoo" => { pairs_with: ["conditioner"], suggest: "Hair-Care Combo Pack" },
      "conditioner" => { pairs_with: ["shampoo"], suggest: "Hair-Care Combo Pack" },
      "laptop" => { pairs_with: ["mouse", "sleeve"], suggest: "Laptop Essentials Bundle" },
      "phone" => { pairs_with: ["earphones"], suggest: "Smartphone Accessories Pack" }
    }
  end
end
