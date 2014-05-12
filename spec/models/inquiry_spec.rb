require 'spec_helper'

describe Inquiry do
  # 問い合わせ内容があれば有効な状態であること
  it 'is valid with a inquiry content.' do
    inquiry = build(:inquiry)
    expect(inquiry).to be_valid
  end

  # 問い合わせ内容が無ければ無効な状態であること
  it 'is invalid without a inquiry content.' do
    inquiry = build(:inquiry, content: "")
    expect(inquiry).to have(1).errors_on(:content)
  end

  # 問い合わせが削除された場合
  context "when deleted the inquiry" do
    # deleted_atが更新されること
    it "update the deleted_at." do
      inquiry = create(:inquiry)
      expect(inquiry.deleted_at).to be_nil
      inquiry.destroy
      expect(inquiry.deleted_at).not_to be_nil
    end
  end
end
