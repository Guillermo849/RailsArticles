class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :null_session

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :no_access_flash
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_flash

  protected

  def no_access_flash
    flash[:alert] = "You don't have access"
    redirect_to root_path
  end

  def not_found_flash
    flash[:alert] = 'Object not found'
    redirect_to root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :surname, :age, :email, :password)
    end
  end
end
