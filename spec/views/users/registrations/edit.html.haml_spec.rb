require 'spec_helper'

describe 'users/registrations/edit' do
  before do
    view.stub(:devise_mapping) { Devise.mappings[:user] }
    @original_user = create(:original_user)
    view.stub(:resource) { @original_user }
    view.stub(:resource_name) { "user" }
  end

  it 'display the title' do
    render
    expect(rendered).to have_selector(".panel .panel-heading", content: I18n.t("account.edit_password"))
  end

  it 'display the locked-in email.' do
    render
    expect(rendered).to have_selector("form .form-group > input", value: @original_user.email)
  end
end
