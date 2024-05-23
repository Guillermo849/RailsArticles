# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[destroy show edit update]

  def index
    @users = policy_scope(User)
  end

  def new
    authorize current_user
    @user = User.new
    render :new
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "You aren't an admin"
    redirect_to users_path
  end

  def edit; end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:success] = 'User successfully updated'
      redirect_to users_path
    else
      flash.now[:danger] = 'User update failed'
      render :edit
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = "Cannot access the user #{@user.first_name}"
    redirect_to users_path
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = 'User successfully deleted'
      redirect_to users_url
    else
      flash[:danger] = "User couldn't be deleted"
    end
  end

  # TODO: Refactor create after pundit implementation
  def create
    authorize current_user
    @user = User.new(new_user_params)
    if @user.save
      flash[:success] = 'New users successfully created'
      redirect_to users_url
    else
      flash.now[:danger] = 'User creation failed'
      render :new
    end
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'Cannot create the user'
    redirect_to users_path
  end

  private

  def users
    policy_scope(User)
  end

  def set_user
    @user = users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :surname, :age, :admin)
  end

  def new_user_params
    params.require(:user).permit(:first_name, :surname, :age, :admin, :email, :password)
  end

  rescue_from Pundit::NotAuthorizedError, ActiveRecord::RecordNotFound do |exception|
    render xml: exception, status: 404
  end
end
