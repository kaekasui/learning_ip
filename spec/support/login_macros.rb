module LoginMacros
  def login(user)
    #visit root_path
    click_link I18n.t("account.login")
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
    click_button I18n.t("actions.login")
  end 

  def login_twitter(user)
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    visit new_user_session_path
    click_link I18n.t("account.twitter_login")
    login_as(user, scope: :user)
  end
end
