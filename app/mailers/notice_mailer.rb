class NoticeMailer < ActionMailer::Base
  default from: "aprende.notice@gmail.com"

  def change_email(user)
    @user = user
    mail to: @user.email, subject: I18n.t("messages.change_email")
  end
end
