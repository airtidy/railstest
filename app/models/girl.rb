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

  def self.global_ranking(girls)
    ranking = []
    girls.each do |girl|
      value = 0
      girl.rankings.each do |ranking|
        value = value + ranking.rank
      end
      hash = {name: girl.name, rank: value}
      ranking.push(hash)
    end
    return ranking.sort_by { |hash| hash[:rank] }
  end
end
