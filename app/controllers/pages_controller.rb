class PagesController < ApplicationController
  def index
    @global_ranking = GlobalRanking.new.sorted
  end
end
