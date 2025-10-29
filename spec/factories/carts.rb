# spec/factories/carts.rb
FactoryBot.define do
  factory :cart do
    association :user, factory: :user
    status { "active" }
    total_price { 0.0 }
  end
end
