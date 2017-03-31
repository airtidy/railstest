class Ranking < ApplicationRecord
  belongs_to :girl
  belongs_to :user

  validates_uniqueness_of :girl_id, scope: :user_id

  ### after each create/destroy/update we need to update the average_ranking of parent girl
  after_commit :update_girl_average_ranking

  def update_girl_average_ranking
    girl.update_average_ranking
  end

end
