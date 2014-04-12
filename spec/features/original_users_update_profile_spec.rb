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
  end

  # 同じメールアドレスを更新する
  scenario 'updates the same email.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: @user.email
    click_button I18n.t("actions.mail")
    expect(page).to have_content(I18n.t("messages.send_mail"))
  end

  # 自由書式の文字列をメールアドレスとして更新する
  scenario 'updates the email as string of free format.' do
    click_link 'email'
    expect(page.status_code).to eq 200

    fill_in 'virtual_user_email', with: "abcde"
    click_button I18n.t("actions.mail")
    expect(page.status_code).to eq 200

    url = URI.parse(page.current_url).path
    expect(url).to eq users_send_email_path
  end
end 
