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

  describe "#email" do
    before do
      controller.stub(:authenticate_user!).and_return true
      @user = create(:original_user)
      sign_in @user
    end

    it "response code is 200." do
      get :email
      expect(response.status).to eq 200
    end

    it "render template :email." do
      get :email
      expect(response).to render_template(:email)
    end

    after do
      sign_out :user
    end
  end

  describe "#send_email" do
    context "original user logged-in" do
      before do
        controller.stub(:authenticate_user!).and_return true
        @user = create(:original_user, email: "abc@example.com")
        sign_in @user
      end

      context "email is format." do
        before do
          post :send_email, { virtual_user: { email: "abc@example.com" }}
        end

        it "response code is 302." do
          expect(response.status).to eq 302
        end

        it "redirect to the profile page." do
          expect(response).to redirect_to(users_profile_path)
        end

        it "update the virtual email." do
          expect(VirtualUser.find_by_code(@user.code).reload.email).to eq "abc@example.com"
        end
      end

      context "email is not the format" do
        before do
          post :send_email, { virtual_user: { email: "abc" }}
        end

        it "response code is 200." do
          expect(response.status).to eq 200
        end

        it "render template :email." do
          expect(response).to render_template(:email)
        end

        it "don't update the virtual email." do
          expect(VirtualUser.find_by_code(@user.code)).to eq nil
        end
      end

      after do
        sign_out :user
      end
    end
  end

  describe "#update_email" do
    context "with non-logged-in user" do
      before do
        get :update_email, code: "123abc"
      end
    end

    context "with logged-in user" do
      before do
        controller.stub(:authenticate_user!).and_return true
        @original_user = create(:original_user, code: "123abc")
        sign_in @original_user
      end

      context "code is user code, and there is virtual email." do
        before do
          @virtual_user = create(:virtual_user, code: "123abc")
          get :update_email, code: "123abc"
        end

        it "response code is 302." do
          expect(response.status).to eq 302
        end

        it "redirect to the user profile page." do
          expect(response).to redirect_to(users_profile_path)
        end

        it "original user email is new email." do
          expect(@original_user.reload.email).to eq @virtual_user.email
        end

        it "destroy the virtual user." do
          expect(@virtual_user.reload.deleted_at).not_to eq nil
        end
      end

      context "code is user code, and there is not virtual email." do
        before do
          get :update_email, code: "123abc"
        end

        it "response code is 302." do
          expect(response.status).to eq 302
        end

        it "redirect to the user profile page." do
          expect(response).to redirect_to(users_profile_path)
        end

        it "original user email is original user email." do
          expect(@original_user.reload.email).to eq @original_user.email
        end

        it "there is not the virtual user." do
          expect(VirtualUser.find_by_code(@original_user.code)).to eq nil
        end
      end

      context "code is not user code, and there is not virtual email." do
        before do
          get :update_email, code: "abcdef"
        end

        it "response code is 302." do
          expect(response.status).to eq 302
        end

        it "redirect to the top page." do
          expect(response).to redirect_to(root_path)
        end

        it "original user email is original user email." do
          expect(@original_user.reload.email).to eq @original_user.email
        end
      end

      after do
        sign_out :user
      end
    end
  end
end
