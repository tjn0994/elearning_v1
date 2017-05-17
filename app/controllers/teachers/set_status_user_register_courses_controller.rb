class Teachers::SetStatusUserRegisterCoursesController < DashboardController
  def index
    user_course = UserCourse.find_by id: params[:id]
    if user_course.present?
      if user_course.update status: params[:status].to_i
        flash[:success] = "Cập nhật trạng thái thành công"
      else
        flash[:errors] = "Cập nhật trạng thái không thành công"
      end
    else
      flash[:errors] = "Không tìm thấy"
    end
    redirect_to teachers_user_register_courses_path
  end
end
