class Girl < ApplicationRecord
	has_many :rankings
	def rank(user)
		ranking = Ranking.where(user: user, girl: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end

	class << self
		def top_girls
	    Ranking.joins(:girl)
						 .group("girl_id, girls.name")
						 .order("rank_sum")
						 .pluck('girl_id, girls.name, SUM(rank) as rank_sum')
	  end
	end
end
