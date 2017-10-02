class PagesController < ApplicationController
  def index
    @girls = Girl.all.sort_by { |g| g.average_rank }
  end
end
