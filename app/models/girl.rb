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
		def global_ranking
	    select("girls.*, sum(rankings.rank) as global_rank").joins(:rankings).group('girls.id').order("global_rank ASC")
	  end
	end
end
