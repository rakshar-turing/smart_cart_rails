class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def formatted_price
    "$#{'%.2f' % price}"
  end

  def similar_products(limit = 4)
    if category.present?
      Product.where(category: category)
             .where.not(id: id)
             .limit(limit)
    else
      # fallback: use last word of name for similarity (e.g., "Mug")
      keyword = name.to_s.split.last
      return Product.none unless keyword.present?

      Product.where("name ILIKE ?", "%#{keyword}%")
             .where.not(id: id)
             .limit(limit)
    end
  end
end
