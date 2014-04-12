require 'spec_helper'

# original user が外部サービスと連携する
feature 'original users link up with the other external service.' do
  background do
    @user = create(:original_user)
    login @user
    visit users_profile_path
  end

  # Twitterを登録する
  scenario 'regists a twitter account.' do
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash
    user = create(:twitter_user)
    login_as(user, scope: :user)
    click_link "connect"

    visit users_profile_path
    expect(page).to have_content(I18n.t("actions.unregist_twitter"))
  end

  # Twitter連携を解除する
  scenario 'original user disconnet twitter user.' do
    omniauth_hash = { provider: :twitter, uid: "1234", info: { name: "Name", nickname: "ScreenName" }}
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(omniauth_hash)

    click_link "connect"
    expect(page).to have_content(@user.email)
    expect(page).to have_content(I18n.t("actions.unregist_twitter"))

    click_link 'disconnect'
    expect(page).to have_content(I18n.t("actions.regist_twitter"))
  end
end
