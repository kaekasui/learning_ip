require 'spec_helper'

describe 'users/registrations/new' do
  before do
    view.stub(:devise_mapping) { Devise.mappings[:user] }
    view.stub(:devise_error_messages!) { [] }
    view.stub(:resource) { OriginalUser.new }
    view.stub(:resource_name) { "user" }
  end

  context 'with non-logged-in user' do
    before do
      view.stub(:user_signed_in?) { false }
   end

    it 'display the title' do
      render
      expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.new"))
    end

    it 'display the twitter link' do
      render
      expect(rendered).to have_selector(".btn > a", content: I18n.t("account.twitter_login"))
    end
  end
end
