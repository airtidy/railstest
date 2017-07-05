class Girl < ApplicationRecord

	def update_ranking_sums
		rankings = Ranking.where(girl: self)
		global_sum_absolute_ranks = 0.0
		global_sum_relative_ranks = 0.0
		rankings.each do |ranking|
			global_sum_absolute_ranks += ranking.absolute_rank 
			global_sum_relative_ranks += ranking.rank
		end
		self.update_attributes(global_sum_absolute_ranks: global_sum_absolute_ranks, global_sum_relative_ranks: global_sum_relative_ranks)
	end


	def rank(user)
		ranking = Ranking.where(user: user, girl: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end
end
