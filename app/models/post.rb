class Post < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :post_type
  validates :title, presence: true
  scope :order_post_at, -> { order("post_at DESC") }
end
