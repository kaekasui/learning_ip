require 'spec_helper'

# original user がプロフィール情報を更新する
feature 'original users update the profile.' do
  background do
    @user = create(:original_user)
    login @user
    visit users_profile_path
  end

  # 空のニックネームを更新する
  scenario 'updates the empty nickname.' do
    click_link 'name'
    fill_in 'original_user_name', with: ""
    click_button I18n.t("actions.update")

    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  # ニックネームを更新する
  scenario 'updates the nickname.' do
    click_link 'name'
    fill_in 'original_user_name', with: "nickname"
    click_button I18n.t("actions.update")

    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  # ニックネームを再更新する
  scenario 're-updates the nickname.' do
    click_link 'name'
    fill_in 'original_user_name', with: "nickname"
    click_button I18n.t("actions.update")
    click_link 'name'
    fill_in 'original_user_name', with: "nickname2"
    click_button I18n.t("actions.update")
 
    expect(page).to have_content(I18n.t("messages.update_user_name"))
  end

  # 異なるメールアドレスを更新する
  scenario 'updates the defferent email.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "abc" + @user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))

   # メールに送信したURLに接続
    user = VirtualUser.find_by_email("abc" + @user.email)
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq "abc" + @user.email
  end

  # 同じメールアドレスを更新する
  scenario 'updates the same email.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: @user.email
    click_button I18n.t("actions.mail")
    expect(current_path).to eq users_profile_path
    expect(page).to have_content(I18n.t("messages.send_mail"))

    # メールに送信したURLに接続
    user = VirtualUser.find_by_email(@user.email)
    visit update_users_email_path(code: user.code)
    expect(page).to have_content(I18n.t("messages.update_user_email"))
    expect(OriginalUser.find_by_code(user.code).email).to eq @user.email
  end

  # 自由書式の文字列をメールアドレスとして更新する
  scenario 'updates the email as string of free format.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "abcde"
    click_button I18n.t("actions.mail")
    expect(page.status_code).to eq 200

    expect(current_path).to eq users_send_email_path
  end

  # パスワードを更新する
  scenario 'updates the password.' do
    click_link 'password'
    expect(page.status_code).to eq 200

    fill_in 'user_current_password', with: @user.password
    fill_in 'user_password', with: @user.password + "123"
    fill_in 'user_password_confirmation', with: @user.password + "123"
    click_button I18n.t("actions.update")
    expect(page).to have_content(I18n.t("devise.registrations.updated"))
  end

  # パスワード再入力で異なるパスワードを更新する
  scenario 'updates the defferent password confirmation.' do
    click_link 'password'
    expect(page.status_code).to eq 200

    fill_in 'user_current_password', with: @user.password
    fill_in 'user_password', with: @user.password + "123"
    click_button I18n.t("actions.update")

    expect(page).to have_content(I18n.t("errors.messages.confirmation", attribute: User.human_attribute_name(:password)))
  end

  # 現在のパスワードを空にして更新する
  scenario 'updates the empty current password.' do
    click_link 'password'
    expect(page.status_code).to eq 200

    fill_in 'user_password', with: @user.password + "123"
    fill_in 'user_password_confirmation', with: @user.password + "123"
    click_button I18n.t("actions.update")

    expect(page).to have_content(I18n.t("errors.messages.empty"))
  end
end 
