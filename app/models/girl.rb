class Girl < ApplicationRecord
	#we need a has_many here to easily get the rankings of each girl
	has_many :rankings

	def rank(user)
		ranking = Ranking.where(user: user, girl: self).first
		if !ranking
			0
		else
			ranking.rank
		end
	end

	#OK, so I can think of 2 alternatives here to update the average_ranking
	#Either the ranking will be updated on each commit
	#Or it will be updated on a scheduled time basis with a gem like Clockwork
	#This is a test, so I just picked the easier/fastest for me
	#Under real circumastances I have to decide considering the needs and the usage of the app

	#we need a method to update the average_ranking of Girl on each ranking create/delete/update
  def update_average_ranking
    @sum = 0

    self.rankings.each do |ranking|
			temp_rank = ranking.rank
    	@sum = @sum + temp_rank unless (temp_rank.nil?||temp_rank==0)
    end

    update_attributes(average_ranking: @sum.to_f / self.rankings.size.to_f)
  end

end
