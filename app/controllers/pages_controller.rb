class PagesController < ApplicationController

  # Get global rank
  def index
  	@global_ranking = Girl.global_ranking
  end
end
