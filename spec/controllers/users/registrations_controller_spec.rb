require 'spec_helper'

describe Users::RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do
    context "with non-logged-in user" do
      it "response code is 200." do
        get :new
        expect(response.status).to eq 200
      end

      it "render template :new." do
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
      before do
        post :create, { user: { email: "abc@example.com", password: "password", password_confirmation: "password" }}
      end

      it "response code is 302." do
        expect(response.status).to eq 302
      end

      it "render template the top page, after sign up." do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when email is blank." do
      before do
        post :create, { user: {email: "", password: "password" }}
      end

      it "once more, render template :new." do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    context "with logged-in original user" do
      before do
        controller.stub(:authenticate_user!).and_return true
        @user = create(:original_user)
        sign_in @user
      end

      it "response code is 200." do
        get :show, id: @user.id
        expect(response.status).to eq 200
      end

      it "render template :show." do
        get :show, id: @user.id
        expect(response).to render_template(:show)
      end

      after do
        sign_out :user
      end
    end

    context "with logged-in twitter user" do
      before do
        controller.stub(:authenticate_user!).and_return true
        @user = create(:twitter_user)
        sign_in @user
      end

      it "response code is 200." do
        get :show, id: @user.id
        expect(response.status).to eq 200
      end

      it "render template :show." do
        get :show, id: @user.id
        expect(response).to render_template(:show)
      end
    end

    after do
      sign_out :user
    end
  end
end
