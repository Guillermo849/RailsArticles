# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy show edit update]

  def index
    @user = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notification] = 'User successfully updated'
      redirect_to users_path
    else
      flash.now[:alert] = 'User update failed'
      render :edit
    end
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:notification] = 'User successfully deleted'
      redirect_to users_url
    else
      flash[:alert] = "User couldn't be deleted"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notification] = 'New users successfully created'
      redirect_to users_url
    else
      flash.now[:alert] = 'User creation failed'
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found'
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:first_name, :surname, :age)
  end
end
