class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates_uniqueness_of :nesoberi_id, scope: :user_id

  def self.global_ranking
    base_score = Nesoberi.count
    score_arr = Nesoberi.all.pluck(:id).map { |id| [id, { score: 0, nesoberi_name: '' }] }
    score_hash = Hash[*score_arr.flatten]
    Ranking.all.each do |ranking|
      score_hash[ranking.nesoberi.id][:score] += (base_score - ranking.rank)
      score_hash[ranking.nesoberi.id][:nesoberi_name] = ranking.nesoberi.name
    end
    score_hash.sort { |(k1, v1), (k2, v2)| v2[:score] <=> v1[:score]}
  end
end
