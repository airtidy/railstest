class PagesController < ApplicationController

  def index
    @top_girls = Girl.top_girls
  end
end
