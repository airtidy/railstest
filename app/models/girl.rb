class Girl < ApplicationRecord
	def rank(user)
		ranking = Ranking.where(user: user, girl: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end

  def average_rank
    ranks = Ranking.where(girl: self).map(&:rank)
    return 1_000_000.0 if ranks.empty?  # No divide by 0.
    return ranks.reduce(:+).to_f / ranks.size
  end
end
