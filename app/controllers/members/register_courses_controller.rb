class Members::RegisterCoursesController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :load_course, only: [:show, :create]

  def index
    @courses = Course.by_active.by_register_course_active(Date.today).includes(:register_course)
    gon.courses = []
    @courses.each do |course|
      gon.courses << {date_close: course.register_course.date_close, course_id: course.id}
    end
  end

  def show
  end

  def create
    if @course.user_courses.pluck(:user_id).include?(current_user.id)
      flash[:success] = "Bạn đã đăng ký khóa học này"
      redirect_to members_register_courses_path
    else
      @user_course = @course.user_courses.new user_id: current_user.id
      if @course.register_course.date_close >= Date.today &&  @user_course.save
        flash[:success] = "Đăng ký khóa học thành công"
        redirect_to members_register_courses_path
      else
        flash[:error] = "Đăng ký khóa học không thành công"
        redirect_to members_register_courses_path
      end
    end
  end

  def load_course
    @course = Course.find_by id: params[:id]
    return if @course
    flash[:error] = "Không tìm thấy khóa học"
    redirect_to members_register_courses_path
  end
end
