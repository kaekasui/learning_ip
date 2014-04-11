require 'spec_helper'

describe TwitterUser do
  describe "record" do
    it "type is TwitterUser." do
      user = build(:twitter_user)
      expect(user.type).to eq "TwitterUser"
    end

    describe "acts_as_paranoid" do
      it "destroy a record, update the deleted_at" do
        user = create(:twitter_user)
        expect(user.deleted_at).to be_nil
        user.destroy
        expect(user.deleted_at).not_to be_nil
      end
    end
  end

  describe "validation test" do
    context "when blank." do
      it "email is not required." do
        user = build(:twitter_user, email: "")
        expect(user).to have(0).errors_on(:email)
      end

      it "password is not required." do
        user = build(:twitter_user, password: "")
        expect(user).to have(0).errors_on(:password)
      end

      it "uid is required." do
        user = build(:twitter_user, uid: "")
        expect(user).to have(1).errors_on(:uid)
      end

      it "screen name is required." do
        user = build(:twitter_user, screen_name: "")
        expect(user).to have(1).errors_on(:screen_name)
      end
    end
  end
end
