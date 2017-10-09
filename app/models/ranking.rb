class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates_uniqueness_of :nesoberi_id, scope: :user_id
end
