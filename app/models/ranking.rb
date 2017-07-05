class Ranking < ApplicationRecord
  belongs_to :girl
  belongs_to :user

  validates_uniqueness_of :girl_id, scope: :user_id

end
