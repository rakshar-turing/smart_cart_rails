class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= "active"
  end
end
