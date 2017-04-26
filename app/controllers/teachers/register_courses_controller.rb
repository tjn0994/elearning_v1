class Teachers::RegisterCoursesController < ApplicationController
  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @register_course = RegisterCourse.new register_course_params
    if @register_course.save
      respond_to do |format|
        format.js{}
      end
    else
      render :new
    end

  end
  private

  def register_course_params
    params.require(:register_course).permit(:course_id, :date_open, :date_close)
  end
end
