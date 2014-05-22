require 'spec_helper'

describe Section do
  # 試験区分があれば有効な状態であること
  it 'is valid with a section name.' do
    section = build(:section)
    expect(section).to be_valid
  end

  # 試験区分が無ければ無効な状態であること
  it 'is invalid without a section name.' do
    section = build(:section, name: "")
    expect(section).to have(1).errors_on(:name)
  end

  # 試験区分が削除された場合
  context "when deleted the section" do
    # deleted_atが更新されること
    it "update the deleted_at." do
      section = create(:section)
      expect(section.deleted_at).to be_nil
      section.destroy
      expect(section.deleted_at).not_to be_nil
    end
  end
end
