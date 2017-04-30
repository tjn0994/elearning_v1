class Teachers::UserCoursesController < DashboardController
  before_action :authenticate_user!
  before_action :load_course
  load_and_authorize_resource

  def index
    init_variables
  end

  def create
    user_ids = params[:user_courses][:list_user].reject(&:blank?).map(&:to_i)
    array_user_id_temp = []
    user_ids.each do |user_id|
      array_user_id_temp << UserCourse.new(course_id: @course.id, user_id: user_id)
    end
    begin
      UserCourse.import array_user_id_temp
      flash[:success] = "add member success"
      user_ids.each do |user_id|
        create_notification_for_member UserCourse.name, @course, "add_course", user_id
      end
    rescue StandardError
      flash[:error] = "add member not success"
    end
    # user_course = UserCourseService.new.create user_ids, @course
    # message_notice user_course
    redirect_to teachers_course_user_courses_path @course
  end

  def destroy
    user_ids = params[:user_courses][:list_user].reject(&:blank?).map(&:to_i)
    @course.user_ids -= user_ids
    user_ids.each do |user_id|
      create_notification_for_member UserCourse.name, @course, "remove_course", user_id
    end
    flash[:success] = "delete success"
    redirect_to teachers_course_user_courses_path @course
  end

  private

  def init_variables
    @user_outside_courses = User.not_in_course(@course.id)
    @user_inside_courses = @course.users.recent.page(params[:page])
      .per Settings.per_page.teachers.user
    @user_course = @course.user_courses.build
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end

  def message_notice object
    return flash[:error] = "not success" unless object[:success]
    flash[:success] = "success"
  end
end
