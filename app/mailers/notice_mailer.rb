class NoticeMailer < ActionMailer::Base
  default from: "aprende.notice@gmail.com"

  def change_email(user)
    @user = user
    mail to: @user.email, subject: "メールアドレスを変更します。"
  end
end
