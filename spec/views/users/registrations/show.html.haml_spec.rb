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

    it 'display the twitter link.' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("actions.regist_twitter"))
    end

    it 'display the mail address of original user.' do
      render
      expect(rendered).to have_selector("table.table tr > td", content: @original_user.email)
    end

    it 'display the link of changing password.' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("buttons.edit_password"))
    end
  end

  context 'with logged-in twitter user, non-regist original user' do
    before do
      @twitter_user = create(:twitter_user)
      view.stub(:current_user) { @twitter_user }
      @original_user = OriginalUser.new
    end

    it 'display the twitter user account.' do
      render
      expect(rendered).to have_selector("table.table tr > td", content: @twitter_user.name)
    end

    it 'display the disabled twitter link' do
      render
      expect(rendered).to have_selector(".btn.disabled > a", content: I18n.t("actions.unregist_twitter"))
    end

    it "don't display the mail address of original user." do
      render
      expect(rendered).to have_selector("table.table tr > td", content: I18n.t("account.unregistered"))
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

    it 'display the twitter link' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("actions.unregist_twitter"))
    end
  end

  context 'with logged-in original user, regist virtual user' do
    before do
      @original_user = create(:original_user, code: "123456")
      view.stub(:current_user) { @original_user }
      @virtual_user = create(:virtual_user, code: "123456")
      @twitter_user = create(:twitter_user, code: "123456")
    end

    it 'display the virtual email address.' do
      render
      expect(rendered).to have_selector("table.table tr > td", content: I18n.t("account.waiting_list") + "\n" + @virtual_user.email)
    end
  end
end
