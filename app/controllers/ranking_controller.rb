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

      ranking = Ranking.where(girl_id: girl_id, user: current_user).first

      if ranking == nil || ranking.rank < 1 || ranking.rank > Girl.all.count
        rank = Ranking.where(user: current_user).count
        ranking = Ranking.create(girl_id: girl_id, user: current_user, rank: rank)

      elsif ranking.rank == 1 && direction == "up"

      elsif ranking.rank == Ranking.where(user: current_user).count && direction == "down"

      else
        current = Ranking.where(user: current_user, girl_id: girl_id).first

        if direction == "up"
          # swap with upper ranker
          upper = Ranking.where(user: current_user, rank: ranking.rank.to_i - 1).first
          upper.rank = current.rank
          current.rank = current.rank - 1
          upper.save!
          current.save!

        elsif direction == "down"
          # swap with lower ranker
          lower = Ranking.where(user: current_user, rank: ranking.rank.to_i + 1).first
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
