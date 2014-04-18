class Post < ActiveRecord::Base
  acts_as_paranoid

  validates :title, presence: true
  scope :order_post_at, -> { order("post_at DESC") }
end
