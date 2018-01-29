class Nesoberi < ApplicationRecord

	has_many :rankings

	def rank(user)
		ranking = rankings.where(user: user).first
		ranking.present? ? ranking.rank : 0
	end
end
