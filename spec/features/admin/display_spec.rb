require 'spec_helper'

# 管理者が管理画面を表示する
feature 'administrators display the admin page.' do
  background do
    user = create(:original_user, admin: true)
    login user
  end 

  # ダッシュボードを表示する
  scenario 'displays the dashboard page.' do
    visit admin_root_path
  end
end
