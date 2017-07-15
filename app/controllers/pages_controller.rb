class PagesController < ApplicationController
  def index
    @girls = Girl.global_ranking
  end
end
