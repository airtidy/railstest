class PagesController < ApplicationController
  def index
  	@global_ranking = Girl.global_ranking
  end
end
