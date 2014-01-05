class TwitterUser < User
  validates :uid, :screen_name, presence: true

  def self.find_for_oauth(auth)
    self.where(uid: auth.uid).first
  end

  def self.create_with_oauth(auth)
    self.create(provider: auth.provider, uid: auth.uid, name: auth.info.name, screen_name: auth.info.nickname, password: Devise.friendly_token[0, 20])
  end

  def self.update_with_oauth(auth, user)
    user.update_attributes(name: auth.info.name, screen_name: auth.info.nickname, token: auth.credentials.token, secret: auth.credentials.secret)
  end
end
