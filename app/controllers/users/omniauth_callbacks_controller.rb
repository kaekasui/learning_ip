class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    authorize :twitter do
      session["devise.twitter_data"] = request.env["omniauth.auth"].except('extra')
    end
  end

  def disconnect
    case params[:provider]
    when "twitter"
      user = current_user.same_code_twitter
      user.code = nil
      user.save
    end
    redirect_to users_profile_path
  end

  private
  def authorize provider
    auth = request.env["omniauth.auth"]
    @user = provider_class(provider).find_for_oauth(auth)
    if @user
      provider_class(provider).update_with_oauth(auth, @user)
    else
      @user = provider_class(provider).create_with_oauth(auth)
    end
    set_flash_message(:notice, :signed_in, kind: provider) if is_flashing_format?
    if current_user
      @user.code = current_user.code
      @user.save
      redirect_to users_profile_path
    else
      sign_in_and_redirect @user, event: :authentication
    end
  end

  def provider_class(provider)
    eval("#{provider.capitalize}User")
  end
end
