class Ranking < ApplicationRecord
  belongs_to :girl
  belongs_to :user

  validates_uniqueness_of :girl_id, scope: :user_id

  def self.ladder
    Ranking.joins(:girl).select("girls.name, sum(rankings.rank) as rank").group("girls.name").order("rank desc")
  end
end
