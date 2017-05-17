class Members::UserCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user_course, only: :destroy
  load_and_authorize_resource

  def index
    @user_courses = current_user.user_courses.where(status: :active).includes(:course)
  end

  def destroy
    if @user_course.destroy
      flash[:success] = "Xóa đăng ký khóa học thành công"
    else
      flash[:error] = "Xóa đăng ký khóa học không thành công"
    end
    redirect_to members_registered_courses_path
  end

  private

  def load_user_course
    @user_course = UserCourse.find_by id: params[:id]
    return if @user_course
    flash[:error] = "Không tìm thấy"
    redirect_to members_registered_courses_path
  end
end
