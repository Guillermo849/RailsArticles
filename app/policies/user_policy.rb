class UserPolicy < ApplicationPolicy
  def show?
    is_owner? || user.admin?
  end

  def edit?
    is_owner? || user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def delete?
    is_owner? || user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end
end
