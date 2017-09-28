class PagesController < ApplicationController
  def index
	@girls_ranking_list = Ranking.group(:girl_id).sum(:rank)
	@girlArray = Array.new
	@girls_ranking_list.each do |girlID|
		@girlArray.push [Girl.select(:name).where(id: girlID[0]).first.attributes.values[1],
						 @girls_ranking_list[girlID[0]]]
	end
	@girlArray.sort!{|x,y| y[1] <=> x[1]}  
  end
end
