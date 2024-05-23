class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :null_session

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, ActiveRecord::RecordNotFound do |exception|
    flash[:alert] = "You don't have access"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :surname, :age, :email, :password)
    end
  end
end
