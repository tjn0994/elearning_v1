class UserNotifierMailer < ApplicationMailer
  def send_email_after_approver user
     @user = user
     mail to: user.email, subject: t("mailer.subject", name: @user.name)
  end
end
