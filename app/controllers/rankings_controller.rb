class RankingsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_nesoberi, only: [:vote_up, :vote_down]

  def index
    @nesoberis = current_user.ranking_info.reverse

    # This will help with AJAX
    respond_to do |format|
      format.html
      format.json
    end
  end

  # This is for AJAX call
  def vote_up
    @nesoberi.vote_up(current_user)
  end

  # This is for AJAX call
  def vote_down
    @nesoberi.vote_down(current_user)
  end

  def update
  end

  private

  def get_nesoberi
    @nesoberi = Nesoberi.find_by(id: params[:id])
  end

end
