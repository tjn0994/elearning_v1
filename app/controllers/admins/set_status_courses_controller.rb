require "opentok"

class Admins::SetStatusCoursesController < DashboardController
  before_action :authenticate_admin!

  def index
    course = Course.find_by id: params[:id]
    if course.present?
      if course.update_attributes status: params[:status].to_i, approver_id: current_user.id
        create_activity_confirm_course(course)
        create_notification_for_member Course.name, course, "#{course.status}", course.owner_id
        if course.active?
          if course.room.blank?
            create_room course
            UserNotifierMailer.send_email_after_approver(course.owner, course).deliver_now
          else
            course.room.update(status: :active) if course.room.not_active?
            flash[:success] = "Cập nhật khóa học thành công"
          end
        elsif course.block?
          if course.room.present? && course.room.active?
            course.room.update status: :not_active
          else
            flash[:success] = "Cập nhật khóa học thành công"
          end
        end
      else
        flash[:error] = "Cập nhật khóa học không thành công"
      end
    else
      flash[:error] = "Không tìm thấy khóa học"
    end
    redirect_to admins_courses_path
  end

  def show
    course = Course.find_by id: params[:id]
    create_room course
    redirect_to admins_courses_path
  end

  private

  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new(ENV["KEY_OPENTOK"], ENV["TOKEN"])
    end
  end

  def create_room course
    begin
      config_opentok
      session =  @opentok.create_session
      # session = @opentok.create_session :media_mode => :routed
      @room = Room.create owner_id: course.owner.id, course_id: course.id,
        name: course.name, session_id: session.session_id, status: 0
      if @room.blank?
        course.update status: 2
        flash[:error] = "Tạo phòng không thành công"
      else
        UserNotifierMailer.send_email_after_approver(course.owner).deliver_later
        flash[:success] = "Tạo phòng thành công"
      end
    rescue StandardError
      flash[:error] = "Kết nối mạng thất bại và tạo phòng không thành công"
    end
  end

  def create_activity_confirm_course course
    create_activity Course.name, course, course.status
  end
end
