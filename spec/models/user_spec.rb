require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'defaults to customer role' do
    user = create(:user)
    expect(user.role).to eq('customer')
  end

  it 'validates role inclusion' do
    expect { create(:user, role: 'invalid') }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe '#admin?' do
    it 'returns true for admin role' do
      expect(build(:user, :admin).admin?).to be true
    end
  end
end
