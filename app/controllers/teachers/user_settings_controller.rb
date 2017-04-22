class Teachers::UserSettingsController < DashboardController
  def show
    @user_setting = current_user.user_setting
    if request.xhr?
      if params[:notify_setting].present?
        current_user.user_setting.update notification_setting: set_boolean(params[:notify_setting], "notify")
      elsif params[:email_setting].present?
        current_user.user_setting.update email_setting: set_boolean(params[:email_setting], "email")
      end
      respond_to do |format|
        format.json{}
      end
    end
  end
end
