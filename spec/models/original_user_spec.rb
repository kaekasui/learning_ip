require 'spec_helper'

describe OriginalUser do
  describe "acts_as_paranoid" do
    # deleted_atが更新されること
    it "update the deleted_at" do
      user = create(:original_user)
      expect(user.deleted_at).to be_nil
      user.destroy
      expect(user.deleted_at).not_to be_nil
    end
  end

  # typeがOriginalUserになること
  it "has OriginalUser type." do
    user = build(:original_user)
    expect(user.type).to eq "OriginalUser"
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without a email." do
    user = build(:original_user, email: "")
    expect(user).to have(1).errors_on(:email)
  end

  # メールアドレスがあれば有効な状態であること
  it "is valid with a email." do
    user = build(:original_user)
    expect(user).to be_valid
  end

  # パスワードが無ければ無効な状態であること
  it "is invalid without a password." do
    user = build(:original_user, password: "")
    expect(user).to have(1).errors_on(:password)
  end

  # パスワード(確認)が無ければ無効な状態であること
  it "is invalid without a password confirmation." do
    user = build(:original_user, password_confirmation: "")
    expect(user).to have(1).errors_on(:password_confirmation)
  end

  # パスワードが一致しなければ無効な状態であること
  it "is invalid with unmatched password." do
    user = build(:original_user, password: "123456", password_confirmation: "123457")
    expect(user).to have(1).errors_on(:password_confirmation)
  end

  # 未フォーマットのメールアドレスであれば無効な状態であること
  it "is invalid with unformatted email." do
    user = build(:original_user, email: "a")
    expect(user).to have(1).errors_on(:email)
  end

  # パスワードが8桁であれば有効な状態であること
  it "is valid with minimum(8) password, 8 characters." do
    user = build(:original_user, password: "password")
    expect(user).to have(0).errors_on(:password)
  end

  # パスワードが4桁であれば無効な状態であること
  it "is invalid with minimum(8) password, 4 characters." do
    user = build(:original_user, password: "pass")
    expect(user).to have(1).errors_on(:password)
  end

  # パスワードが128桁であれば有効な状態であること
  it "is valid with maximum(128) password, 128 characters." do
    user = build(:original_user, password: "a" * 128)
    expect(user).to have(0).errors_on(:password)
  end

  # パスワードが129桁であれば無効な状態であること
  it "is valid with maximum(128) password, 129 characters." do
    user = build(:original_user, password: "a" * 129)
    expect(user).to have(1).errors_on(:password)
  end

  # メールアドレスが100桁であれば有効な状態であること
  it "is valid with maximum(100) email, 100 characters." do
    user = build(:original_user, email: "a" * (MAX_LONG_TEXT_FIELD_LENGTH - 12) + "@example.com")
    expect(user).to have(0).errors_on(:email)
  end

  # メールアドレスが101桁であれば無効な状態であること
  it "is valid with maximum(100) email, 101 characters." do
    user = build(:original_user, email: "a" * (MAX_LONG_TEXT_FIELD_LENGTH - 11) + "@example.com")
    expect(user).to have(1).errors_on(:email)
  end

  # ニックネームが40桁であれば有効な状態であること
  it "is valid with maximum(40) name, 40 characters." do
    user = build(:original_user, name: "a" * (MAX_TEXT_FIELD_LENGTH))
    expect(user).to have(0).errors_on(:name)
  end

  # ニックネームが41桁であれば無効な状態であること
  it "is valid with maximum(40) name, 41 characters." do
    user = build(:original_user, name: "a" * (MAX_TEXT_FIELD_LENGTH + 1))
    expect(user).to have(1).errors_on(:name)
  end
end
