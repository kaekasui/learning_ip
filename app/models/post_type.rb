class PostType < ActiveRecord::Base
  acts_as_paranoid

  has_many :posts
  validates :name, presence: true
  scope :order_updated_at, -> { order("updated_at DESC") }
end
