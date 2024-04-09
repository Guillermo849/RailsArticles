# frozen

class UsersController < ApplicationController
  before_action :set_user, only: %i[delete show]

  def index
    @user = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def show
  rescue ActiveRecord::RecordNotFound
    flash[:error] = 'User not found'
    redirect_to users_url
  end

  def delete
    if @user.destroy
      redirect_to users_url
    else
      flash[:error] = "User couldn't be delteted"
    end
  end

  def create
    @user = User.new(params.require(:user).permit(:first_name, :surname, :age))
    if @user.save
      flash[:success] = "New to-do item successfully added!"
      redirect_to users_url
    else
      flash.now[:error] = "To-do item creation failed"
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
