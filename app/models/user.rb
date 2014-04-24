class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:twitter]
  acts_as_paranoid

  has_many :inquiries
  before_create :set_access_code
  validates :email, uniqueness: false, presence: false

  def same_code_original
    User.where(code: self.code, provider: nil).first
  end

  def same_code_twitter
    User.where(code: self.code, provider: "twitter").first
  end

  def display_name
    if self.name.blank?
      self.email if self.provider.nil?
    else
      self.name
    end
  end

  private

  def set_access_code
    self.code = self.code.blank? ? generate_access_code : self.code
  end

  def generate_access_code
    code = SecureRandom.urlsafe_base64(6)
    self.class.where(code: code).blank? ? code : generate_access_code
  end
end
