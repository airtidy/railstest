class PagesController < ApplicationController
  def index
  	@best_ranking = Ranking.best_nesoberi_ranking
  end
end
