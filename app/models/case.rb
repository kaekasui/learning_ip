class Case < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :category
  belongs_to :section
end
