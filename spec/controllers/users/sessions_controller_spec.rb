require 'spec_helper'

describe Users::SessionsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do
    context "with non-logged-in user" do
      it 'response code is 200.' do
        get :new
        expect(response.status).to eq 200
      end

      it 'render template is :new' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "with logged-in user" do
      before do
        controller.stub(:authenticate_user!).and_return true
        user = create(:original_user)
	sign_in user
      end

      it "response code is 302." do
        get :new
        expect(response.status).to eq 302
      end

      it "redirect to the top page." do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    after do
      sign_out :user
    end
  end

  describe "#create" do
    let(:user) { create(:original_user) }

    context "when data is normal." do
      it "response code is 200." do
        post :create, { user: { email: "abc@example.com", password: "password" }}
        expect(response.status).to eq 200
      end
    end

    context "when email is blank." do
      it "once more, render template is :new." do
        post :create, { user: { email: "", password: "password" }}
        expect(response).to render_template(:new)
      end
    end
  end
end
