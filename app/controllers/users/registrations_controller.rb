class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def show
    @original_user = OriginalUser.find_by_code(current_user.code) || OriginalUser.new
    @virtual_user = VirtualUser.find_by_code(current_user.code)
    @twitter_user = TwitterUser.find_by_code(current_user.code) || TwitterUser.new
  end

  def email
    @user = VirtualUser.find_by_code(current_user.code) || VirtualUser.new
  end

  def send_email
    @user = VirtualUser.find_by_code(current_user.code) || VirtualUser.new
    respond_to do |format|
      if @user.update_attributes(email: user_email_param["email"], code: current_user.code)
        NoticeMailer.change_email(@user).deliver
        format.html { redirect_to users_profile_path, notice: I18n.t("messages.send_mail") }
      else
        format.html { render "email" }
      end
    end
  end

  def name
    @user = OriginalUser.find_by_code(current_user.code) || OriginalUser.new
  end

  def update_name
    @user = OriginalUser.find_by_code(current_user.code) || OriginalUser.new
    respond_to do |format|
      if @user.update_attributes(name: user_name_param["name"], code: current_user.code)
        format.html { redirect_to users_profile_path, notice: I18n.t("messages.update_user_name") }
      else
        format.html { render "name" }
      end
    end
  end

  private
  def sign_up_params
    params = devise_parameter_sanitizer.sanitize(:sign_up)
    params.store("type", "OriginalUser")
    params
  end

  def user_email_param
    params.require(:virtual_user).permit(:email)
  end

  def user_name_param
    params.require(:original_user).permit(:name)
  end
end
