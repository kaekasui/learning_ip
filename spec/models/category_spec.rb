require 'spec_helper'

describe Category do
  # カテゴリ名があれば有効な状態であること
  it 'is valid with a category name.' do
    category = build(:category)
    expect(category).to be_valid
  end

  # カテゴリ名が無ければ無効な状態であること
  it 'is invalid without a category name.' do
    category = build(:category, name: "")
    expect(category).to have(1).errors_on(:name)
  end
end
