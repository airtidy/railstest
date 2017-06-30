class Girl < ApplicationRecord
	def rank(user)
		ranking = Ranking.where(user: user, girl: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end

  def self.with_global_ranks
    result = []
    Ranking.group('girl_id').select('SUM(rank) as global_rank, girl_id').order('global_rank desc')
      .each do |e|
        result.push ({:name => Girl.find(e.girl_id).name, :global_rank => e.global_rank})
      end
    result
  end
end
