class VirtualUser < User
  validates :email, uniqueness: false,
                    length: { maximum: MAX_LONG_TEXT_FIELD_LENGTH },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
