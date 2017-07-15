class Girl < ApplicationRecord
  has_many :rankings
  def rank(user)
    ranking = rankings.where(user: user).first
    if !ranking
      0
    else
      ranking.rank
    end
  end

  def total_rank
    rankings.sum(:rank)
  end

  def self.global_ranking
    Girl.all.map{ |x| {name: x.name, total_rank: x.total_rank} }.sort{ |x,y| x[:total_rank] <=> y[:total_rank] }
  end
end
