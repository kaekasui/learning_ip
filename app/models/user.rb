class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :omniauthable, omniauth_providers: [:twitter]
  acts_as_paranoid

  before_save :set_access_code
  validates :email, uniqueness: false, presence: false
  
  private

  def set_access_code
    self.code = self.code.blank? ? generate_access_code : self.code
  end

  def generate_access_code
    code = SecureRandom.urlsafe_base64(6)
    self.class.where(code: code).blank? ? code : generate_access_code
  end
end
