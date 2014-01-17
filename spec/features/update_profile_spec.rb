require 'spec_helper'

feature 'update the profile information, and send mail.' do

  scenario 'original user update the same email.' do
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
 
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200
    fill_in 'virtual_user_email', with: user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario 'original user update the new email.' do
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
 
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200
    fill_in 'virtual_user_email', with: "abc" + user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario 'twitter user update the new email.' do
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    user = create(:twitter_user)
    visit new_user_session_path
    click_link I18n.t("account.twitter_login")

    login_as(user, scope: :user)
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end
end
