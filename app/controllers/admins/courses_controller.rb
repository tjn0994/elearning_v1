class Admins::CoursesController < DashboardController
  before_action :authenticate_admin!

  def index
    @search = Course.ransack(params[:q])
    @courses = @search.result.page(params[:page])
      .per Settings.per_page.admins.course
    @statuses = Course.statuses
  end

  def show
    @course = Course.find_by id: params[:id]
    respond_to do |format|
      format.html{render partial: "details_information", local: {course: @course}}
    end
  end
end
