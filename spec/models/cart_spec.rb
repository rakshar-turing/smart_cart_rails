require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    let(:user) { create(:user) }
    it 'belongs to a user' do
      cart = Cart.create!(user: user, status: 'active')
      expect(cart.user).to eq(user)
    end

    it 'has many cart_items and deletes them when destroyed' do
      user = User.create!(email: 'items@example.com', password: 'password')
      cart = Cart.create!(user: user, status: 'active')
      product1 = Product.create!(name: 'Item 1', price: 10)
      product2 = Product.create!(name: 'Item 2', price: 20)
      item1 = CartItem.create!(cart: cart, product: product1, quantity: 2)
      item2 = CartItem.create!(cart: cart, product: product2, quantity: 1)

      expect(cart.cart_items).to include(item1, item2)
      cart.destroy
      expect(CartItem.where(id: [item1.id, item2.id])).to be_empty
    end
  end

  describe 'validations' do
    it 'is invalid without a user_id' do
      cart = Cart.new(status: 'active')
      expect(cart.valid?).to be_falsey
      expect(cart.errors[:user]).to include("must exist")
    end
  end

  describe 'callbacks' do
    let(:user) { create(:user) }
    it 'defaults to "active" status when none is provided' do
      cart = Cart.create!(user: user) # no status passed
      expect(cart.status).to eq('active')
    end    
  end
end
