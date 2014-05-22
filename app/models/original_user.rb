class OriginalUser < User
  devise authentication_keys: :email
  validates :email, length: { maximum: MAX_LONG_TEXT_FIELD_LENGTH },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i },
                    uniqueness: true,
                    if: :email_required?
  validates :password, confirmation: :password_confirmation,
                       length: { within: 8..128 },
                       if: :password_required?
  validates :name, length: { maximum: MAX_TEXT_FIELD_LENGTH }

  protected

  def email_required?
    !password.nil? || !password_confirmation.nil?
  end

  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
