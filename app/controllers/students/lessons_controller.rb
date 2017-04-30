class Students::LessonsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_course
  before_action :load_lesson, only: :show

  def index
    @lessons = @course.lessons.recent.page(params[:page])
      .per Settings.per_page.teachers.lesson
  end

  def show
  end

  private

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_course_lessons_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = t "dashboard.users.not_found"
    redirect_to teachers_courses_path
  end
end
