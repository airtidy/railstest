class RankingController < ApplicationController

  before_action :authenticate_user!

  def edit
    if request.post?

      nesoberi_id = params[:nesoberi]
      direction = params[:direction]

      return if !nesoberi_id || !direction

      # cases:
      # 1. nesoberi is not ranked
      # 2. nesoberi is at top and going up (cannot go)
      # 3. nesoberi is at bottom and going down (cannot go)
      # 4. nesoberi is changing rank

      ranking = current_user.rankings.where(nesoberi_id: nesoberi_id).first

      if ranking == nil || ranking.rank < 1 || ranking.rank > Nesoberi.all.count
        rank = current_user.rankings.count + 1
        ranking = Ranking.create(nesoberi_id: nesoberi_id, user: current_user, rank: rank)

      elsif ranking.rank == 1 && direction == "up"

      elsif ranking.rank == current_user.rankings.count && direction == "down"

      else
        current = current_user.rankings.where(nesoberi_id: nesoberi_id).first

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
