class Teachers::RegisterCoursesController < ApplicationController
  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    @course = Course.find_by id: params[:course_id]
    @register_course = RegisterCourse.new register_course_params.merge! course_id: @course.id
    if @register_course.save
      respond_to do |format|
        format.js{}
      end
    else
      render :new
    end
  end

  def edit; end

  def update
    @course = Course.find_by id: params[:course_id]
    if @course.register_course.update_attributes register_course_params.merge! course_id: @course.id
      respond_to do |format|
        format.js{}
      end
    else
      render :edit
    end
  end

  private

  def register_course_params
    params.require(:register_course).permit(:date_open, :date_close)
  end
end
