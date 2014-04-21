class Category < ActiveRecord::Base
  acts_as_paranoid

  has_many :cases
  has_many :sections, through: :cases
  validates :name, presence: true
  scope :order_updated_at, -> { order("updated_at DESC") }
end
