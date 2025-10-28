# db/seeds.rb
puts "Seeding sample products..."

Product.create!(name: "Apple", price: 1.20)
Product.create!(name: "Banana", price: 0.80)
Product.create!(name: "Orange", price: 1.00)

puts "✅ Seed complete!"
