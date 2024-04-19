# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit; end

  def show; end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article successfully updated'
      redirect_to article_path
    else
      flash.now[:danger] = 'Article update failed'
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = 'Article successfully deleted'
      redirect_to articles_url
    else
      flash[:danger] = "Article couldn't be deleted"
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = 'New article successfully created'
      redirect_to article_url(@article.id)
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
    redirect_to articles_url
  end

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
