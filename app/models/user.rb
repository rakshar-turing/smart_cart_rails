class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin manager customer].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def manager?
    role == 'manager'
  end

  def customer?
    role == 'customer'
  end
end
