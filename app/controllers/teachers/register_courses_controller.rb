class Teachers::RegisterCoursesController < ApplicationController
  before_action :load_course
  before_action :load_register_course, only: [:edit, :update]

  def new
    respond_to do |format|
      format.js{}
    end
  end

  def create
    override_params params[:register_course][:date_open], params[:register_course][:date_close]
    @register_course = RegisterCourse.new register_course_params.merge!(course_id: @course.id)
    if @register_course.save
      respond_to do |format|
        format.js{}
      end
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js{}
    end
  end

  def update
    override_params params[:register_course][:date_open], params[:register_course][:date_close]
    if @register_course.update_attributes register_course_params
      respond_to do |format|
        format.js{}
      end
    else
      render :edit
    end
  end

  private

  def register_course_params
    params.require(:register_course).permit(:date_open, :date_close).merge!(status: :active)
  end

  def load_register_course
    @register_course = RegisterCourse.find_by id: params[:id]
    return if @register_course
    flash[:error] = "Không tìm thấy thời gian đăng ký khóa học"
    redirect_to teachers_courses_path
  end

  def load_course
    @course = Course.find_by id: params[:course_id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to teachers_courses_path
  end

  def override_params date_open, date_close
    if date_open.present? && date_close.present?
      params[:register_course][:date_open] =  DateTime.parse(date_open).beginning_of_day.to_s
      params[:register_course][:date_close] = DateTime.parse(date_close).end_of_day.to_s
    end
  end
end
