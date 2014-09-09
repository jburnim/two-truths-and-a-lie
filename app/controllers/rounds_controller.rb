class RoundsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    puts current_user
    @rounds = Round.all

    @finished_rounds = @rounds.select { |r| r.lie }.map do |round|
      {
        id: round.id,
        name: round.name,
        created_at: round.created_at,
      }
    end

    @open_rounds = @rounds.reject { |r| r.lie }.map do |round|
      {
        id: round.id,
        name: round.name,
        created_at: round.created_at,
        voted: round.vote.where(:user => @user).present?
      }
    end
    puts @open_rounds
  end

  def show
    @round = Round.find(params[:id])
    @user = current_user

    # If the round is open and this user hasn't voted yet, redirect.
    if @round.lie.nil? and @user.vote.where(:round => @round).first.nil?
      redirect_to new_round_vote_path(@round)
    end

    # Otherwise, show the votes (and the answer, if it has been entered).
    @votes = @round.vote.all.to_a
    @totals = ((1..3).map { |i| [i, @votes.count { |v| v.statement == i }] }).to_h
  end

  def new
    @round = Round.new
  end

  def create
    round_params =
      params.require(:round).permit(:name,:statement1,:statement2,:statement3)
    @round = Round.new(round_params)
    if @round.save
      redirect_to @round
    else
      render 'new'
    end
  end

  def finalize
    @round = Round.find(params[:id])
    if @round.lie
      redirect_to @round
    end
  end

  def update
    @round = Round.find(params[:id])
    if @round.lie
      # TODO(jburnim): Return some kind of warning message and 409 status code?
      redirect_to @round
    end

    @round.lie = params.require(:round).require(:lie)
    if @round.save
      redirect_to @round
    else
      render 'finalize'
    end
  end
end
