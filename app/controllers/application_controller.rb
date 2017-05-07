class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #skip_before_filter  :verify_authenticity_token
  layout :layout

  include ApplicationHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_notifications, if: :user_signed_in?

  rescue_from CanCan::AccessDenied do
    flash[:alert] = "sdsadasdsa"
    redirect_to root_path
  end

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
    members_users_path
  end

  def layout
    if current_user.present? && is_a?(Devise::RegistrationsController)
      "dashboard"
    elsif is_a?(Devise::SessionsController) || is_a?(Devise::PasswordsController) ||
      (current_user.blank? && is_a?(Devise::RegistrationsController))
      "devise"
    else
      "application"
    end
  end

  def create_activity_for_user
    create_activity User.name, @user, @_action_name
  end

  def load_notifications
    @notifications = current_user.notifications
      .by_notification(Notification.activity_types[:notice]).recent
    @count_unread_notification =  @notifications.unread.count
  end

  def set_boolean str, type
    case str
    when "true"
      "#{type}_on"
    when "false"
      "#{type}_off"
    end
  end

  def after_sign_in_path_for _resource
    if current_user.admin?
      admins_users_path
    elsif current_user.teacher?
      teachers_courses_path
    else
      "/home"
    end
  end

  JsonResponse::STATUS_CODE.keys.each do |status|
    define_method "response_#{status}" do |message = "", content = {}|
      render json: JsonResponse.send(status, message, content)
    end
  end

  def authenticate_admin!
    return if current_user.admin?
    flash[:error] = "Bạn không có quyền truy cập trang này"
    redirect_to root_path
  end
end
