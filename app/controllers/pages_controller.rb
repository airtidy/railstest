class PagesController < ApplicationController
  def index

    # Store total number of girls here and expose to view for DRYness
    @total_girls = Girl.all.count

    # Hash to hold name of girls as key, total score as value
    girls_with_combined_scores = Hash.new

    # For the total number of girls,
    # set value at hash index to hold girl's name and score with index == ID
    for i in 0..@total_girls - 1 do
      girls_with_combined_scores[i] = { name: Girl.find_by(id: i + 1).name, score: Ranking.where(girl_id: i + 1).sum(:rank) }
    end

    # Expose to view after being populated and sorted
    @girls_with_combined_scores = girls_with_combined_scores.sort_by{ |key, value| value[:score] }.reverse
  end
end
