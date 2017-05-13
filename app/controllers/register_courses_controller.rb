class RegisterCoursesController < ApplicationController
  before_action :load_course, only: :show

  def index
    @courses = Course.by_active.by_register_course_active(Date.today).includes(:register_course)
    gon.courses = []
    @courses.each do |course|
      gon.courses << {date_close: course.register_course.date_close.strftime("%Y-%m-%d %H:%M:%S"), course_id: course.id}
    end
  end

  def show
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to "/register_course"
  end
end
