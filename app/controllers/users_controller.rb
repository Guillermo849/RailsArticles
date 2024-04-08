class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def new
    @user = User.new
    render :new
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
end
