class Section < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: true

  scope :order_updated_at, -> { order("updated_at DESC") }
end
