class PagesController < ApplicationController
  def index
    total = Girl.all.count

    girl_score = Hash.new
    Girl.find_each do |girl|
      girl_score[girl[:id]] = { name: girl[:name], score: 0 }
    end

    Ranking.find_each do |ranking|
      if ranking[:rank] > 0 && ranking[:rank] <= total
        # rank: 1 => score: Girl.all.count
        # ...
        # rank: Girl.all.count => score: 1
        girl_score[ranking[:girl_id]][:score] += (total - ranking[:rank] + 1)
      end
    end

    @girl_score = girl_score.sort_by { |id, girl| -girl[:score] }
  end
end
