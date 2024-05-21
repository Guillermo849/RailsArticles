class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def show?
    owner? or user.admin?
  end

  def edit?
    owner? or user.admin?
  end

  def delete?
    owner? or user.admin?
  end

  private

  def owner?
    user == article.user
  end
end
