# app/policies/product_policy.rb
class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.present? ? scope.all : scope.none
    end
  end
  
  def index?
    user.present? # allow all logged-in users
  end

  def show?
    user.present? # allow all logged-in users
  end

  def new?
    user.admin? || user.manager?
  end

  def create?
    user.admin? || user.manager?
  end

  def edit?
    user.admin? || user.manager?
  end

  def update?
    user.admin? || user.manager?
  end
end
