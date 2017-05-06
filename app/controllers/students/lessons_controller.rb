class Students::LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_course
  before_action :authenticate_member_of_course!, only: :index
  before_action :load_lesson, only: :show
  load_and_authorize_resource

  def index
    @lessons = @course.lessons.page(params[:page])
      .per Settings.per_page.teachers.lesson
  end

  def show
  end

  private

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    return if @lesson
    flash[:error] = "Không tìm thấy bài học"
    redirect_to students_course_lessons_path(@course)
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to students_user_courses_path
  end

  def authenticate_member_of_course!
    unless @course.user_ids.include? current_user.id
      flash[:error] = "Bạn không phải học viên của khóa học này"
      if current_user.courses.present?
        redirect_to students_user_courses_path
      else
        redirect_to "/home"
      end
    end
  end
end
