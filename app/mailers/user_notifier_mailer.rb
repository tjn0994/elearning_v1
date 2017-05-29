class UserNotifierMailer < ApplicationMailer
  def send_email_after_approver user, course
     @user = user
     @course = course
     mail to: user.email, subject: "Xác nhận khóa học #{@course.name}"
  end
end
