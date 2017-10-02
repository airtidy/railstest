class PagesController < ApplicationController
  def index
    girls = Girl.all
    @global_ranking = Girl.global_ranking(girls)
  end
end
