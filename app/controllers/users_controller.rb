class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.users_with_vote_counts.map do |user|
      correct_votes = user.correct_votes || 0
      incorrect_votes = user.incorrect_votes || 0
      total_votes = correct_votes + incorrect_votes
      {
        id: user.id,
        email: user.email.html_safe,
        correct_votes: correct_votes,
        incorrect_votes: incorrect_votes,
        total_votes: total_votes,
        correct_rate: correct_votes / (total_votes + Float::MIN),
        incorrect_rate: incorrect_votes / (total_votes + Float::MIN)
      }
    end
    @users.sort_by! { |user| -user[:correct_rate] }
  end

  def show
  end
end
