class PagesController < ApplicationController

  attr_reader :rankings

  def index
    @rankings = Ranking::global_ranking
  end
end
