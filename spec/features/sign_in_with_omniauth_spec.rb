require 'spec_helper'

feature 'sign_in_with_omniauth' do

  scenario 'sign in with the twitter user.' do
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    visit new_user_session_path
    click_link I18n.t("account.twitter_login")
  end
end
