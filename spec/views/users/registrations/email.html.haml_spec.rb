require 'spec_helper'

describe 'users/registrations/email' do
  before do
    view.stub(:devise_mapping) { Devise.mappings[:user] }
  end

  context 'with logged-in the original user' do
    before do
      @user = create(:original_user)
      view.stub(:resource) { @user }
      view.stub(:current_user) { @user }
    end

    it 'display the title' do
      render
      expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.email"))
    end
  end
end
