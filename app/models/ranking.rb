class Ranking < ApplicationRecord
  belongs_to :girl
  belongs_to :user

  validates_uniqueness_of :girl_id, scope: :user_id

  def self.global_ranking
    Ranking.find_by_sql("select a.id, a.name, b.total_rank, a.created_at
    from girls a
    inner join (select girl_id, sum(rank) as total_rank from rankings
    group by girl_id) b on a.id = b.girl_id
    order by total_rank asc, created_at desc")
  end
end
