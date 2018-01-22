class PagesController < ApplicationController
  def index
    @ranking_hash = Ranking.global_ranking
  end
end
