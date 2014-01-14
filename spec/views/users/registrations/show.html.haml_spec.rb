require 'spec_helper'

describe 'users/registrations/show' do
  before do
    view.stub(:devise_mapping) { Devise.mappings[:user] }
    view.stub(:user_signed_in?) { true }
  end

  context 'with logged-in original user, non-regist twitter user' do
    before do
      @twitter_user = TwitterUser.new
      @original_user = create(:original_user)
   end

    it 'display the title' do
      render
      expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.profile"))
    end

    it 'display the twitter link' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("actions.regist_twitter"))
    end
  end

  context 'with logged-in twitter user, non-regist original user' do
    before do
      @twitter_user = create(:twitter_user)
      view.stub(:current_user) { @twitter_user }
      @original_user = OriginalUser.new
    end

    it 'display the title' do
      render
      expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.profile"))
    end

    it 'display the twitter link' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("actions.unregist_twitter"))
    end

    it 'display the disabled twitter link' do
      render
      expect(rendered).to have_selector(".btn.disabled > a", content: I18n.t("actions.unregist_twitter"))
    end
  end

  context 'with logged-in original user, regist twitter user' do
    before do
      @original_user = create(:original_user, code: "123456")
      view.stub(:current_user) { @original_user }
      @twitter_user = create(:twitter_user)
      @twitter_user.code = "123456"
      @twitter_user.save
    end

    it 'display the title' do
      render
      expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.profile"))
    end

    it 'display the twitter link' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("actions.unregist_twitter"))
    end
  end
end
