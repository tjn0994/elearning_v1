class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def after_update_path_for _resource
    if current_user.admin?
      return redirect_to admins_users_path
    elsif current_user.teacher?
      return redirect_to teachers_courses_path
    end
  end
end
