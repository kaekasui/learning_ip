require 'spec_helper'

feature 'update the profile information, and send mail.' do
  background do
    # login.
    @user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200

    # display the profile page
    visit users_profile_path
  end

  scenario 'original user update the password.' do
    # editing password page.
    click_link 'password'
    expect(page.status_code).to eq 200

    # update password.
    fill_in 'user_current_password', with: @user.password
    fill_in 'user_password', with: @user.password + "123"
    fill_in 'user_password_confirmation', with: @user.password + "123"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))
  end

  scenario 'original user update the empty password confirmation.' do
    # editing password page.
    click_link 'password'
    expect(page.status_code).to eq 200

    # update password.
    fill_in 'user_current_password', with: @user.password
    fill_in 'user_password', with: @user.password + "123"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("errors.messages.confirmation", attribute: User.human_attribute_name(:password)))
  end

  scenario 'original user update the empty current password.' do
    # editing password page.
    click_link 'password'
    expect(page.status_code).to eq 200

    # update password.
    fill_in 'user_password', with: @user.password + "123"
    fill_in 'user_password_confirmation', with: @user.password + "123"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("errors.messages.empty"))
  end

  scenario 'original user set twitter user.' do
    # login.
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash
    user = create(:twitter_user)
    login_as(user, scope: :user)
    click_link "connect"

    # connect.
    visit users_profile_path
    expect(page).to have_content(I18n.t("actions.unregist_twitter"))
  end

  scenario 'original user disconnet twitter user.' do
    # login.
    omniauth_hash = { provider: :twitter, uid: "1234", info: { name: "Name", nickname: "ScreenName" }}
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new(omniauth_hash)

    # connect.
    click_link "connect"
    expect(page).to have_content(@user.email)
    expect(page).to have_content(I18n.t("actions.unregist_twitter"))

    # disconnect.
    click_link 'disconnect'
    expect(page).to have_content(I18n.t("actions.regist_twitter"))
  end
end
