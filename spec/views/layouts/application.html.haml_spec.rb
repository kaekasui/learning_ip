require 'spec_helper'

describe 'layouts/application' do

  context 'with non-logged-in user' do
    before do
      view.stub(:user_signed_in?) { false }
    end

    it 'display the brand.' do
      render
      expect(rendered).to have_selector(".header a.navbar-brand", content: I18n.t(".brand"))
    end

    it 'display the sign up link.' do
      render
      expect(rendered).to have_selector(".header ul.nav > li > a", content: I18n.t("account.new"))
    end

    it 'display the login link.' do
      render
      expect(rendered).to have_selector(".header ul.nav > li > a", content: I18n.t("account.login"))
    end
  end

  context 'with logged-in user' do
    before do
      view.stub(:user_signed_in?) { true }
    end

    it 'display the brand.' do
      render
      expect(rendered).to have_selector(".header a.navbar-brand", content: I18n.t(".brand"))
    end

    it "don't display the sign up link." do
      render
      expect(rendered).not_to have_selector(".header ul.nav > li > a", content: I18n.t("account.new"))
    end

    it 'display the logout link.' do
      render
      expect(rendered).to have_selector(".header ul.nav > li > a", content: I18n.t("account.logout"))
    end
  end
end
