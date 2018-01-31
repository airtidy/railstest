class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates :rank, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :nesoberi, :user, presence: true
  validates_uniqueness_of :nesoberi_id, scope: :user_id

  def vote_up
    if rank.present?
      new_rank = rank + 1
    else
      new_rank = 1
    end
    self.update(rank: new_rank)
  end

  def vote_down
    if rank.blank? || rank <= 1
      new_rank = 0
    else
      new_rank = rank - 1
    end
    self.update(rank: new_rank)
  end

end
