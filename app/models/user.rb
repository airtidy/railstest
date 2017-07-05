class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :rankings

  def ranking_info
  	Girl.all.map{|x| { id: x.id, name: x.name, rank: x.rank(self) } }.sort_by{|x| x[:rank] == 0 ? 99999 : x[:rank] }
  end

  def update_absolute_ranks_of_ranking
  	rankings = self.rankings
  	rankings_length = rankings.count
    rankings.each do |ranking|
      ranking.update_attribute(:absolute_rank, ranking.rank.to_f/rankings_length.to_f)
      Girl.find(ranking.girl_id).update_ranking_sums
    end	
  end

end
