class RankingController < ApplicationController

  before_action :authenticate_user!

  # TODO ISSUES:
  # User cannot lower the rank of the last girl to be ranked.
  # i.e., pressing DOWN on the last girl won't change her rank to 9
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
        ranking = Ranking.create(girl_id: girl_id, user: current_user, rank: rank)

      elsif ranking.rank == 1 && direction == "up"

      elsif ranking.rank == current_user.rankings.count && direction == "down"

      else
        current = current_user.rankings.where(girl_id: girl_id).first

        if direction == "up"
			# swap with upper ranker
			upper = current_user.rankings.where(rank: ranking.rank.to_i - 1).first
		  
			# To be safe, I am also checking for nil up here as well (see below)
			if upper != nil && current != nil
			  upper.rank = current.rank
			  current.rank = current.rank - 1
			  upper.save!
			  current.save!
			end
 
        elsif direction == "down"
			# swap with lower ranker
			lower = current_user.rankings.where(rank: ranking.rank.to_i + 1).first
		  
			# This crashed with a NoMethodError, i.e. current / lower was Nil
			if lower != nil && current != nil
			  lower.rank = current.rank
			  current.rank = current.rank + 1
			  lower.save!
			  current.save!
			end

        end

      end

      redirect_to :ranking_view
    end
  end
    	
  def self.waifu_ranks(girls)
	leaderboard = []
		
	girls.each do |girl|
		totalRank = 0
		girl.rankings.each do |ranking|
			# A new user could have not finished ranking all
			# the girls. Thus, I add 9 for unranked girls (the lowest rank).
			# Without this a girl will have a smaller total than she deserves.
			if (ranking.rank > 0) 
				totalRank = totalRank + ranking.rank
			else 
				totalRank = totalRank + 9
			end
		end
	
		waifu = {name: girl.name, rank: totalRank}
		leaderboard.push(waifu)
	end
		
	# Remember that 1 is the highest rank, so the lowest total 
	# will be the highest ranked.
	return leaderboard.sort_by { |waifu| waifu[:rank] }
  end

  def view
  end
end
