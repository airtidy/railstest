class PagesController < ApplicationController
  def index
  	@girls = Girl.select("girls.*, SUM(rankings.rank) total_rank").joins(:rankings).group("girls.id").order("total_rank DESC")
  end
end
