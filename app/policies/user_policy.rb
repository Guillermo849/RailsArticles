class UserPolicy < ApplicationPolicy
  attr_reader :user, :current_user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def show?
    is_owner? or current_user.admin?
  end

  def edit?
    is_owner? or current_user.admin?
  end

  def new?
    current_user.admin?
  end

  def delete?
    is_owner? or current_user.admin?
  end

  private

  def is_owner?
    user == current_user
  end
end
