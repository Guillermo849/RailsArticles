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
end
