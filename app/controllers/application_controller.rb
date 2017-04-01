class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout

  before_action :configure_permitted_parameters, if: :devise_controller?



  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :password, :password_confirmation, :current_password
    end
  end

  def after_sign_in_path_for _resource
    students_users_path
  end

  def layout
    is_a?(Devise::SessionsController) ? false : "application"
  end
end
