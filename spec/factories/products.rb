FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10..100.0) }
    stock { 10 }
    low_stock_threshold { 5 }
  end
end
