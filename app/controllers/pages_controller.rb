class PagesController < ApplicationController
  def index
    @girls = Girl.with_global_ranks
  end
end
