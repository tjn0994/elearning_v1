class Teachers::ActivitiesController < DashboardController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities.load_active.page(params[:page])
      .per Settings.per_page.teachers.activity
  end
end
