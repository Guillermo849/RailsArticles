class UserPolicy < ApplicationPolicy
  def show?
    is_owner? || admin?
  end

  def edit?
    is_owner? || admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def delete?
    is_owner? || admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
