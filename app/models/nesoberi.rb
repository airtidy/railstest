class Nesoberi < ApplicationRecord
	has_many :rankings

	validates :name, presence: true

	def self.global_rankings
		all.sort_by(&:global_rank).reverse
	end

	def rank(user)
		ranking = rankings.where(user: user).first
		ranking.present? ? ranking.rank : 0
	end

	def global_rank
		rankings.all.pluck(:rank).sum
	end
end
