class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates :rank, numericality: { only_integer: true, greater_than: 0 }
  validates :nesoberi, :user, presence: true
  validates_uniqueness_of :nesoberi_id, scope: :user_id

end
