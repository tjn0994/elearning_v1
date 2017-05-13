class RegisterCoursesController < ApplicationController
  before_action :load_course, only: :show
  def show
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to "/register_course"
  end
end
