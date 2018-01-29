class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates :rank, numericality: { only_integer: true, greater_than: 0 }
  validates :nesoberi, :user, presence: true
  validates_uniqueness_of :nesoberi_id, scope: :user_id

  def vote_down
    self.update(rank: (rank + 1))
  end

  def vote_up
    if rank > 0
      self.update(rank: (rank - 1))
    end
  end

end
