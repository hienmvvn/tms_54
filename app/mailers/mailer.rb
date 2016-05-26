class Mailer < ApplicationMailer
  default from: "notification-tms54@framgia.com"

  def assign_trainee_email user, course
    @user = user
    @course = course
    mail to: @user.email, 
      subject: t("mailer.assign_trainee_email_subject", 
      title: @course.title)
  end

  def remove_trainee_email user, course
    @user = user
    @course_title = course.title
    mail to: @user.email, 
      subject: t("mailer.remove_trainee_email_subject", 
      title: @course_title)
  end
end
