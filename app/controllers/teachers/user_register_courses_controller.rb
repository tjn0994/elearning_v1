class Teachers::UserRegisterCoursesController < DashboardController
  def index
    @user_courses = UserCourse.by_not_active.by_author(current_user.id).page(params[:page])
      .per Settings.per_page.admins.course
  end
end
