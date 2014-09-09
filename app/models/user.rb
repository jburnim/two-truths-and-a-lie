class User < ActiveRecord::Base
  has_many :vote
  has_many :round, :through => :vote

  validates :email, format: { with: /@siftscience.com\z/,
    message: "Sift Science email address required" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.users_with_vote_counts
    joins(:round).where('rounds.lie IN (1,2,3)').select('users.*')
      .select('SUM(CASE WHEN rounds.lie = votes.statement THEN 1 END) ' +
              ' AS correct_votes')
      .select('SUM(CASE WHEN rounds.lie <> votes.statement THEN 1 END) ' +
              ' AS incorrect_votes')
      .group('users.id')
  end
end
