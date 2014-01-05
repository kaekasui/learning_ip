class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    authorize :twitter do
      session["devise.twitter_data"] = request.env["omniauth.auth"].except('extra')
    end
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
    sign_in_and_redirect @user, event: :authentication
  end

  def provider_class(provider)
    eval("#{provider.capitalize}User")
  end
end
