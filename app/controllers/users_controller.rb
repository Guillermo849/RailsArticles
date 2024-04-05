class UsersController < ApplicationController
  def index
    @users = Users.all
  end

  def new
    @users = Users.new
    render :new
  end

  def create
    @user = Users.new(params.require(:users).permit(:first_name, :surname, :age))
    if @user.save
      flash[:success] = "New to-do item successfully added!"
      redirect_to users_url
    else
      flash.now[:error] = "To-do item creation failed"
      render :new
    end
  end
end
