# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @articles = policy_scope(Article)
  end

  def new
    @article = Article.new
  end

  def edit
    authorize @article
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Cannot access the article #{@article.title}"
    redirect_to user_articles_path
  end

  def show
    @article = policy_scope(Article).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Cannot access the article #{@article.title}"
    redirect_to user_articles_path
  end

  def update
    authorize @article
    if @article.update(article_params)
      flash[:success] = 'Article successfully updated'
      redirect_to user_article_path
    else
      flash.now[:danger] = 'Article update failed'
      render :edit
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Cannot access the article #{@article.title}"
    redirect_to user_articles_path
  end

  def destroy
    authorize @article
    if @article.destroy
      flash[:success] = 'Article successfully deleted'
      redirect_to user_articles_url
    else
      flash[:danger] = "Article couldn't be deleted"
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Cannot access the article #{@article.title}"
    redirect_to user_articles_path
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'New article successfully created'
      redirect_to user_article_url(current_user.id, @article.id)
    else
      flash.now[:danger] = 'Article creation failed'
      render :new
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:danger] = 'Article not found'
    redirect_to user_articles_url
  end

  def set_user
    @user = current_user
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
