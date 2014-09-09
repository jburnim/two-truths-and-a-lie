class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :round

  validates :statement, inclusion: { in: [1, 2, 3] }
end
