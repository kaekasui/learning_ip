require 'spec_helper'

feature 'twitter user' do

  # ログイン/ログアウトする
  scenario 'logs in and logs out.' do
    user = create(:twitter_user)

    # ログイン
    login_twitter user

    visit users_profile_path
    expect(current_path).to eq users_profile_path

    # ログアウト
    click_link I18n.t("account.logout")
    expect(page).to have_content(I18n.t("devise.sessions.signed_out"))
  end
end
