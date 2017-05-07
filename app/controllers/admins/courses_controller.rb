class Admins::CoursesController < DashboardController
  before_action :authenticate_admin!

  def index
    @courses = Course.recent.page(params[:page])
      .per Settings.per_page.admins.course
  end

  def show
    @course = Course.find_by id: params[:id]
    respond_to do |format|
      format.html{render partial: "details_information", local: {course: @course}}
    end
  end
end
