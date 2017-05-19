class Teachers::UserRegisterCoursesController < DashboardController
  def index
    @search = UserCourse.by_author(current_user.id).joins(:user, :course).ransack(params[:q])
    @user_courses = @search.result.page(params[:page])
      .per Settings.per_page.teachers.user_register_course
    @statuses = UserCourse.statuses
    @courses = Course.by_author(current_user.id)
    if request.xhr?
      respond_to do |format|
        format.js{}
      end
    end
  end
end
