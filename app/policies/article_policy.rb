class ArticlePolicy < ApplicationPolicy
  def show?
    is_owner? || user.admin?
  end

  def edit?
    is_owner? || user.admin?
  end

  def delete?
    is_owner? || user.admin?
  end
end
