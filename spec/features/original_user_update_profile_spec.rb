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

  scenario 'original user update the empty name.' do
    # editing name page.
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: ""
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  scenario 'original user update the new name.' do
    # editing name page.
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: "Nickname"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("Nickname")
  end

  scenario 'original user update the name.' do
    # editing name page.
    click_link 'name'
    expect(page.status_code).to eq 200

    # update the name.
    fill_in 'original_user_name', with: "Nickname"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("messages.update_user_name"))

    # update the name once again.
    click_link 'name'
    fill_in 'original_user_name', with: "Nickname2"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("Nickname2")
  end

  scenario 'original user update the same email.' do
    # editing email page.
    click_link 'email'
    expect(page.status_code).to eq 200
 
    # send email.
    fill_in 'virtual_user_email', with: @user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  scenario "original user can't update the email with string." do
    # editing email page.
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
    # editing email page.
    click_link 'email'
    expect(page.status_code).to eq 200

    # send email.
    fill_in 'virtual_user_email', with: "abc" + @user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
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
end
