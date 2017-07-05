class Girl < ApplicationRecord
  has_many :rankings

  ## Single responsibility principle violation?
	def rank(user)
		ranking = rankings.where(user: user).first
		if !ranking
			0
		else
			ranking.rank
		end
	end
end
