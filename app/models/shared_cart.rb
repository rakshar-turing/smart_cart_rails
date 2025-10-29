class SharedCart < ApplicationRecord
  belongs_to :cart
  before_validation :generate_token, on: :create
  validates :token, presence: true, uniqueness: true
  validates :cart, presence: true

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(8)
    self.expires_at ||= 24.hours.from_now
  end
end
