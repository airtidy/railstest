class PagesController < ApplicationController
  def index
	girls = Girl.all
	
	@waifu_ranks = RankingController.waifu_ranks(girls)
  end
end
