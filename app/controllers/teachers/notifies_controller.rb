class Teachers::NotifiesController < DashboardController
   before_action :authenticate_user!

  def index
    @notifies = current_user.notifications.load_notify.page(params[:page])
      .per Settings.per_page.admins.activity
    @notifies.update_all(read: true)
  end
end
