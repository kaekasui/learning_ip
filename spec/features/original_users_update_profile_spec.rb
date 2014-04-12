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
end 
