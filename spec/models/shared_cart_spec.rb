require 'rails_helper'

RSpec.describe SharedCart, type: :model do
  let(:cart) { create(:cart) }

  it "generates a token automatically" do
    shared_cart = create(:shared_cart, cart: cart)
    expect(shared_cart.token).to be_present
  end

  it "ensures token uniqueness" do
    token = SecureRandom.urlsafe_base64(8)
    create(:shared_cart, token: token)
    dup = build(:shared_cart, token: token)
    expect(dup.valid?).to be false
  end

  it "detects expired state correctly" do
    expired_cart = create(:shared_cart, expires_at: 1.day.ago)
    active_cart  = create(:shared_cart, expires_at: 1.day.from_now)
    expect(expired_cart).to be_expired
    expect(active_cart).not_to be_expired
  end
end
