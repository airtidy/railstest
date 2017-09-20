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
end
