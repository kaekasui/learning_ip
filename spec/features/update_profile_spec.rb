require 'spec_helper'

feature 'update the profile information, and send mail.' do

  scenario 'original user update the empty name.' do
    # login.
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email

  end

  scenario 'original user update the same email.' do
    # login.
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
 
    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario "original user can't update the email with string." do
    # login.
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
 
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

  scenario 'original user update the new email.' do
    # login.
    user = create(:original_user)
    visit user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
 
    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: "abc" + user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario 'twitter user update the new email.' do
    omniauth_hash = { provider: :twitter, uid: "1234" }
    provider = omniauth_hash[:provider]
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = omniauth_hash

    # login.
    user = create(:twitter_user)
    visit new_user_session_path
    click_link I18n.t("account.twitter_login")
    login_as(user, scope: :user)

    # display the profile page and editing email page.
    visit users_profile_path
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: "abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario "twitter user can't update the email with string." do
    # login.
    user = create(:twitter_user)
    visit user_session_path
    click_link I18n.t("account.twitter_login")
    login_as(user, scope: :user)
 
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
end
