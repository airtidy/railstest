class Nesoberi < ApplicationRecord
  has_many :rankings

	def rank(user)
		ranking = Ranking.where(user: user, nesoberi: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end
end
