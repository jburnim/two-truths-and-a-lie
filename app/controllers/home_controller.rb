class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    redirect_to rounds_path
  end
end
