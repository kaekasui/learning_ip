require 'spec_helper'

feature 'sign_up_and_sign_in' do

  scenario 'sign up with non-logged-in user.' do
    visit new_user_registration_path
    expect(page.status_code).to eq 200

    fill_in 'user_email', with: "aaa@example.com"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"
    click_button I18n.t("actions.create")

    expect(page.status_code).to eq 200
    expect(page).to have_content(I18n.t("devise.registrations.signed_up"))

    click_link I18n.t("account.logout")
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))
  end
  
  scenario 'sign in with non-logged-in user.' do
    user = create(:original_user)

    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button I18n.t("actions.login")
    expect(page.status_code).to eq 200
    expect(page).to have_content(I18n.t("devise.sessions.signed_in"))

    click_link I18n.t("account.logout")
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))
  end
end
