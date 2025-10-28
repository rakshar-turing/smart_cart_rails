# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
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
