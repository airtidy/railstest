class RankingController < ApplicationController

  before_action :authenticate_user!

  def edit
    if request.post?

      girl_id = params[:girl]
      direction = params[:direction]

      return if !girl_id || !direction

      # cases:
      # 1. girl is not ranked
      # 2. girl is at top and going up (cannot go)
      # 3. girl is at bottom and going down (cannot go)
      # 4. girl is changing rank

      ranking = current_user.rankings.where(girl_id: girl_id).first

      if ranking == nil || ranking.rank < 1 || ranking.rank > Girl.all.count
        rank = current_user.rankings.count
        puts "rank: #{rank}"
        ranking = Ranking.create(girl_id: girl_id, user: current_user, rank: rank + 1)

      elsif ranking.rank == 1 && direction == "up"

      elsif ranking.rank == current_user.rankings.count && direction == "down"

      else
        current = current_user.rankings.where(girl_id: girl_id).first

        if direction == "up"
          # swap with upper ranker
          upper = current_user.rankings.where(rank: ranking.rank.to_i - 1).first
          upper.rank = current.rank
          current.rank = current.rank - 1
          upper.save!
          current.save!

        elsif direction == "down"
          # swap with lower ranker
          lower = current_user.rankings.where(rank: ranking.rank.to_i + 1).first
          lower.rank = current.rank
          current.rank = current.rank + 1
          lower.save!
          current.save!

        end


      end

      redirect_to :ranking_view
    end
  end

  def view
  end
end
