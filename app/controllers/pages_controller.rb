class PagesController < ApplicationController

  def index
    @rankings = Ranking::global_ranking
  end
end
