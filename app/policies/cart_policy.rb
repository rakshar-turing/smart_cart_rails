class CartPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def create?
    user.present?
  end

  def destroy?
    record.user == user
  end
end
