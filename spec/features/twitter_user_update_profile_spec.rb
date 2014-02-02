require 'spec_helper'

feature 'update the profile information, and send mail.' do
  background do
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    # login.
    @user = create(:twitter_user)
    visit new_user_session_path
    click_link I18n.t("account.twitter_login")
    login_as(@user, scope: :user)
  end

  scenario "twitter user update the empty name." do
    # editing name page.
    visit users_profile_path
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: ""
    click_button I18n.t("actions.create")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  scenario "twitter user update the new name." do
    # editing name page.
    visit users_profile_path
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: "Nickname"
    click_button I18n.t("actions.create")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("Nickname")
  end

  scenario "twitter user update the new name." do
    # editing name page.
    visit users_profile_path
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: "NickName"
    click_button I18n.t("actions.create")
    expect(page).to have_content(I18n.t("messages.update_user_name"))

    # update the name once again.
    click_link 'name'
    fill_in 'original_user_name', with: "Nickname2"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("Nickname2")
  end

  scenario 'twitter user update the new email.' do
    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: "virtual_abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))

    # update email.
    user = VirtualUser.find_by_email("virtual_abc@example.com")
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq "virtual_abc@example.com"
  end

  scenario "twitter user can't update the email with string." do
    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # don't send email.
    fill_in 'virtual_user_email', with: "abcde"
    click_button I18n.t("actions.mail")
    expect(page.status_code).to eq 200
    url = URI.parse(page.current_url).path
    expect(url).to eq users_send_email_path
  end

  scenario "twitter user update the password with non-regist password." do
    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: "virtual_abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))

    # update email.
    user = VirtualUser.find_by_email("virtual_abc@example.com")
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq "virtual_abc@example.com"

    # display the editing password page.
    click_link "password"

    # set password.
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))

    # logout.
    click_link "logout"

    # login.
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    click_link "login"
    visit new_user_session_path
    click_link I18n.t("account.twitter_login")
    login_as(@user, scope: :user)

    # update password.
    visit users_profile_path
    original_user = OriginalUser.find_by_code(@user.code)
    expect(original_user.email).to eq "virtual_abc@example.com"
    
    click_link 'password'
    fill_in 'user_current_password', with: '12345678'
    fill_in 'user_password', with: '123123123'
    fill_in 'user_password_confirmation', with: '123123123'
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))

    # logout.
    click_link "logout"

    # login.
    click_link "login"
    fill_in 'user_email', with: original_user.email
    fill_in 'user_password', with: '123123123'
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
  end
end
