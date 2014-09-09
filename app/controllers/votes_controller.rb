class VotesController < ApplicationController
  before_action :authenticate_user!

  def new
    @round = Round.find(params[:round_id])

    # If the user has already voted, redirect.
    @user = current_user
    if @user.vote.where(:round => @round).first
      redirect_to round_path(@round)
    end

    @vote = @round.vote.new
  end

  def create
    @user = current_user
    @round = Round.find(params[:round_id])
    @vote = @round.vote.new(vote_params)
    @vote.user = @user
    if @vote.save
      redirect_to @round
    else
      render 'new'
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:statement)
  end
end
