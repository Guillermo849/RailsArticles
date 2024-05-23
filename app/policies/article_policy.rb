class ArticlePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end

    private

    attr_reader :user, :scope
  end

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
