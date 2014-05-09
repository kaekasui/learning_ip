require 'spec_helper'

# 管理者が管理画面を表示する
feature 'administrators display the admin page.' do
  background do
    user = create(:original_user, admin: true)
    login user
  end 

  # ダッシュボードを表示する
  scenario 'display the dashboard page.' do
    visit admin_root_path
    expect(current_path).to eq admin_root_path
  end

  # 管理メニューを表示する
  scenario 'display the admin menu.' do
    visit admin_root_path
    expect(page).to have_selector("ul.list-group > li.list-group-item > a", I18n.t("admin_menu.dashboard"))
    expect(page).to have_selector("ul.list-group > li.list-group-item > a", I18n.t("admin_menu.category"))
    expect(page).to have_selector("ul.list-group > li.list-group-item > a", I18n.t("admin_menu.case"))
  end
end
