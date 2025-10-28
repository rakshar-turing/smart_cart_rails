# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    role { 'customer' }

    trait :admin do
      role { 'admin' }
    end

    trait :manager do
      role { 'manager' }
    end

    trait :customer do
      role { 'customer' }
    end
  end
end
