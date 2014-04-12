require 'spec_helper'

feature 'original user' do

  # ログイン/ログアウトする
  scenario 'logs in and logs out.' do
    user = create(:original_user)

    # ログイン
    login user
    expect(current_path).to eq root_path
    expect(page).to have_content I18n.t("devise.sessions.signed_in")

    # ログアウト
    click_link I18n.t("account.logout")
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))
  end

  # 会員登録する
  scenario 'creates an account.' do

    # 会員登録
    visit new_user_registration_path
    fill_in 'user_email', with: "new_user@example.com"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"
    click_button I18n.t("actions.create")
    expect(page).to have_content(I18n.t("devise.registrations.signed_up"))

    # ログアウト
    click_link I18n.t("account.logout")
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))
  end
end
