require 'spec_helper'

describe VirtualUser do
  describe "record" do
    describe "acts_as_paranoid" do
      it "destroy a record, update the deleted_at" do
        user = create(:virtual_user)
        expect(user.deleted_at).to be_nil
        user.destroy
        expect(user.deleted_at).not_to be_nil
      end
    end
  end

  describe "validation test" do
    context "when blank." do
      it "email is required." do
        user = build(:virtual_user, email: "")
        expect(user).to have(1).errors_on(:email)
      end

      it "password is not required." do
        user = build(:virtual_user, password: "")
        expect(user).to have(0).errors_on(:password)
      end
    end

    context "when unmatched." do
      it 'email is not mail address format.' do
        user = build(:virtual_user, email: "a")
        expect(user).to have(1).errors_on(:email)
      end
      
    end
 
    context "when not exceed maximum(100) characters." do
      it 'have no error with email.' do
        user = build(:virtual_user, email: "a@example.com")
        expect(user).to have(0).errors_on(:email)
      end
    end

    context "when exceed maximum(100) characters." do
      it "have 1 error with email." do
        user = build(:virtual_user, email: ("a" * 100) + "@example.com")
        expect(user).to have(1).errors_on(:email)
      end
    end
  end
end
