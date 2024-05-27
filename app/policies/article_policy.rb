class ArticlePolicy < ApplicationPolicy
  def show?
    is_owner? || admin
  end

  def edit?
    is_owner? || admin
  end

  def delete?
    is_owner? || admin
  end

  class Scope < Scope
    def resolve
      return scope.all if admin

      scope.where(user_id: user.id)
    end
  end
end
