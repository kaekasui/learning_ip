require 'spec_helper'

describe User do
  describe "record" do
    it "admin is false." do
      user = build(:original_user)
      expect(user.admin).to be_false
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

  describe "before_create" do
    it "user code is not empty." do
      user = build(:original_user)
      expect(user.code).to be_nil
      user.save
      expect(user.code).not_to be_nil
    end
  end
end
