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

  def self.global_ranking
    # Implement global ranking based on the Borda Count Method: One 1st place vote is worth
    # Nesoberi.count points, one 2nd place vote is worth Nesoberi.count - 1 points, etc.
    # http://www.ctl.ua.edu/math103/voting/borda.htm

    global_ranking = {}
    Nesoberi.all.each do |nesoberi|
      global_ranking[nesoberi.name] = 0
      multiplier = Nesoberi.count
      for rank in 1..Nesoberi.count
        global_ranking[nesoberi.name] += (nesoberi.rankings.where(rank: "#{rank}").count)*multiplier
        multiplier -= 1
      end
    end
    global_ranking.sort_by {|key, value| value }.reverse
  end
end
