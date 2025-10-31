class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :product_id, presence: true

  scope :discontinued, -> { where(is_discontinued: true) }

  def outdated_version?
    latest_version = SmartCartCatalog.latest_version_for(product_name)
    latest_version.present? && latest_version != product_version
  end
end