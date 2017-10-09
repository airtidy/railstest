class Nesoberi < ApplicationRecord
	def rank(user)
		ranking = Ranking.where(user: user, nesoberi: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end
end
