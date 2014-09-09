class Round < ActiveRecord::Base
  has_many :vote

  validates :lie, inclusion: { in: [nil, 1, 2, 3] }
end
