class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  after_save :enqueue_low_stock_check, if: :saved_change_to_stock?
  has_many :cart_items

  scope :active, -> { where(is_discontinued: false) }

  def self.latest_version_for(name)
    where(name: name, is_discontinued: false).order(created_at: :desc).first&.product_version || "1.0"
  end

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

  def low_stock?
    stock.present? && stock <= low_stock_threshold
  end

  def enqueue_low_stock_check
    # If stocked low, enqueue the job to perform notification & webhook handling
    if low_stock?
      SendLowStockNotificationJob.perform_later(id)
    end
  end
end
