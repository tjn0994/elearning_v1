class Admins::SetStatusCoursesController < DashboardController
  def index
    course = Course.find_by id: params[:id]
    if course.present?
      if course.update status: params[:status].to_i, approver_id: current_user.id
        flash[:success] = "success"
        if course.approver?
          UserNotifierMailer.send_email_after_approver(course.owner).deliver_later
        end
      else
        flash[:errors] = "errors"
      end
    else
      flash[:danger] = "not found"
    end
    redirect_to admins_courses_path
  end
end
