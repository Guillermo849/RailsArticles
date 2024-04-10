# frozen_string_literal: true

class ArticlesController < ApplicationController
  def create
    if @user = User.find(params[:user_id])
      @article = Article.new(article_params)
      if @article.save
        flash[:success] = 'New users successfully created'
        redirect_to users_url
      else
        flash.now[:danger] = 'User creation failed'
        render :new
      end

    else
      flash.now[:danger] = 'User creation failed'
      render :new
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
