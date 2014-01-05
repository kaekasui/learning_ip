class OriginalUser < User
  validates :email, uniqueness: true,
                    length: { maximum: MAX_LONG_TEXT_FIELD_LENGTH },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :password, confirmation: :password_confirmation,
                       length: { within: 6..MAX_TEXT_FIELD_LENGTH }
end
