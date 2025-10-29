FactoryBot.define do
  factory :shared_cart do
    cart
    token { SecureRandom.urlsafe_base64(8) }
    expires_at { 7.days.from_now }
  end
end