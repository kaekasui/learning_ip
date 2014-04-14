require 'spec_helper'

# twitter user がプロフィール情報を更新する
feature 'twitter users update the profile.' do
  background do
    @user = create(:twitter_user)
    login_twitter @user
    visit users_profile_path
  end

  # 空のニックネームを更新する
  scenario 'updates the empty nickname.' do
    click_link 'name'
    expect(page.status_code).to eq 200

    fill_in 'original_user_name', with: ""
    click_button I18n.t("actions.create")

    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  # ニックネームを更新する
  scenario 'updates the nickname.' do
    click_link 'name'
    expect(page.status_code).to eq 200

    fill_in 'original_user_name', with: "nickname"
    click_button I18n.t("actions.create")

    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("nickname")
  end

  # ニックネームを再更新する
  scenario 're-updates the nickname.' do
    click_link 'name'
    expect(page.status_code).to eq 200

    fill_in 'original_user_name', with: "nickname"
    click_button I18n.t("actions.create")
    expect(page).to have_content(I18n.t("messages.update_user_name"))

    click_link 'name'
    fill_in 'original_user_name', with: "nickname2"
    click_button I18n.t("actions.update")
 
    expect(page).to have_content(I18n.t("messages.update_user_name"))
    expect(page).to have_content("nickname2")
  end

  # 新しくメールアドレスを登録する
  scenario 'updates a new email.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    # メールの送信
    fill_in 'virtual_user_email', with: "virtual_abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
    expect(current_path).to eq users_profile_path

    # メールに送信したURLに接続
    user = VirtualUser.find_by_email("virtual_abc@example.com")
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq "virtual_abc@example.com"
  end

  # 自由書式の文字列をメールアドレスとして更新する
  scenario 'updates the email as string of free format.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "abcde"
    click_button I18n.t("actions.mail")
    expect(current_path).to eq users_send_email_path
  end

  # パスワードを登録および更新する
  scenario "updates the new password." do
    # メールアドレスの更新
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "virtual_abc@example.com"
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))

    user = VirtualUser.find_by_email("virtual_abc@example.com")
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq "virtual_abc@example.com"

    # パスワードの登録
    click_link "password"
    expect(page.status_code).to eq 200

    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))

    click_link "logout"
    login_twitter @user
    visit users_profile_path

    original_user = OriginalUser.find_by_code(@user.code)
    expect(original_user.email).to eq "virtual_abc@example.com"
    
    # パスワードの変更
    click_link 'password'
    fill_in 'user_current_password', with: '12345678'
    fill_in 'user_password', with: '123123123'
    fill_in 'user_password_confirmation', with: '123123123'
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))

    click_link "logout"
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))

    # original user でログイン
    click_link "login"
    fill_in 'user_email', with: original_user.email
    fill_in 'user_password', with: '123123123'
    click_button I18n.t("actions.login")
    expect(page).to have_content(I18n.t("devise.sessions.signed_in"))
  end
end
