class Ranking < ApplicationRecord
  belongs_to :nesoberi
  belongs_to :user

  validates_uniqueness_of :nesoberi_id, scope: :user_id

  def self.best_nesoberi_ranking

    num_of_rank_candi = Nesoberi.count
    num_of_all_rank = Ranking.count
    avg_num_of_rankings = (num_of_all_rank / num_of_rank_candi).to_f
    avg_of_rankings =  (((num_of_all_rank * num_of_rank_candi) -  Ranking.sum(:rank)) / num_of_all_rank).to_f
    # results of ranking
    best_ranking_array = Hash.new

    Nesoberi.all.each do | nesoberi |
    	current_num_of_rankings = Ranking.where({nesoberi_id: nesoberi.id}).count
    	if current_num_of_rankings > 1
    		current_avg_of_rankings = num_of_rank_candi - Ranking.where({nesoberi_id: nesoberi.id}).average(:rank)
    		# calculating bayesian avarage for ranking
    		bayesian_average_ranking = (((avg_num_of_rankings * avg_of_rankings) + (current_num_of_rankings * current_avg_of_rankings)) / (avg_num_of_rankings + current_num_of_rankings)).to_f
    		best_ranking_array[nesoberi.id] = { rank: bayesian_average_ranking, nesoberi_name:  nesoberi.name}
    	else
    		best_ranking_array[nesoberi.id] = { rank: 0 , nesoberi_name:  nesoberi.name}
    	end
    end
    # desc sort ranking results
    best_ranking_array.sort_by { | _ , v | -v[:rank]}
  end
end
