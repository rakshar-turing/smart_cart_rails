class SharedCartPolicy < ApplicationPolicy
  def create?
    true # anyone can create a shared cart link
  end

  def show?
    true # anyone can view a shared cart link
  end
end
