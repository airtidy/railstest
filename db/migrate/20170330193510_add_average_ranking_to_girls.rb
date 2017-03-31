class AddAverageRankingToGirls < ActiveRecord::Migration[5.0]
  def change
    add_column :girls, :average_ranking, :float
  end
end
