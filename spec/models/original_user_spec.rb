require 'spec_helper'

describe OriginalUser do
  describe "record" do
    it "type is OriginalUser." do
      user = build(:original_user)
      expect(user.type).to eq "OriginalUser"
    end

    describe "acts_as_paranoid" do
      it "destroy a record, update the deleted_at" do
        user = create(:original_user)
        expect(user.deleted_at).to be_nil
        user.destroy
        expect(user.deleted_at).not_to be_nil
      end
    end
  end

  describe "validation test" do
    context "when blank." do
      it "email is required." do
        user = build(:original_user, email: "")
	p user
        expect(user).to have(1).errors_on(:email)
      end

      it "password is required." do
        user = build(:original_user, password: "")
	expect(user).to have(1).errors_on(:password)
      end

      it "password confirmation is required." do
        user = build(:original_user, password_confirmation: "")
	expect(user).to have(1).errors_on(:password_confirmation)
      end
    end

    context "when unmatched." do
      it "between password and password confirmation" do
        user = build(:original_user, password: "123456", password_confirmation: "123457")
	expect(user).to have(1).errors_on(:password_confirmation)
      end

      it "email is mail address format." do
        user = build(:original_user, email: "a")
        expect(user).to have(1).errors_on(:email)
      end
    end

    context "when not exceed minimum(6) characters." do
      it "with password." do
        user = build(:original_user, password: "password")
	expect(user).to have(0).errors_on(:password)
      end
    end

    context "when exceed minimum(6) characters." do
      it "with password." do
        user = build(:original_user, password: "pass")
	expect(user).to have(1).errors_on(:password)
      end
    end

    context "when not exceed max characters." do
      it "with email." do
        user = build(:original_user, email: "a" * (MAX_LONG_TEXT_FIELD_LENGTH - 12) + "@example.com")
        expect(user).to have(0).errors_on(:email)
      end
    end
  end
end
