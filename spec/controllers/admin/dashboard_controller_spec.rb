require 'spec_helper'

describe Admin::DashboardController do
  context "with non-logged-in user" do
    describe '#index' do
      it 'response code is 302.' do
        get :index
        expect(response.status).to eq 302
      end

      it 'redirect to the top page.' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "with logged-in administrator" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:original_user, admin: true)
    end

    describe '#index' do
      it 'response code is 200.' do
        get :index
        expect(response.status).to eq 200
      end

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
