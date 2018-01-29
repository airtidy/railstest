class PagesController < ApplicationController
  def index
    @nesoberis = Nesoberi.global_rankings
  end
end
