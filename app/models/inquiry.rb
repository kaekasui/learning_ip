class Inquiry < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  validates :content, presence: true
end
