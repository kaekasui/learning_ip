require 'spec_helper'

describe Admin::DashboardController do
  # ログインしていない場合
  context "with non-logged-in user" do
    describe '#index' do
      it 'redirect to the top page.' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end

  # ログインユーザーが一般ユーザーの場合
  context "with a logged-in user" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:original_user, admin: false)
    end

    describe '#index' do
      it 'redirect to the top page.' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    after do
      sign_out :user
    end
  end

  # ログインユーザーが管理者の場合
  context "with a logged-in administrator" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:original_user, admin: true)
    end

    describe '#index' do
      it 'render template :index' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    after do
      sign_out :user
    end
  end
end
