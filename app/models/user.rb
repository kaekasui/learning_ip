class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  acts_as_paranoid

  before_save :set_access_code
  
  private

  def set_access_code
    self.code = self.code.blank? ? generate_access_code : self.code
  end

  def generate_access_code
    code = SecureRandom.urlsafe_base64(6)
    self.class.where(code: code).blank? ? code : generate_access_code
  end
end
