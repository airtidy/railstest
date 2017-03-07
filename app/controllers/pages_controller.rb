class PagesController < ApplicationController
 	def index
	  	girlCount = Girl.all.count

	  	@globalRankScore = Array.new(girlCount, 0)	#Array for saving scores of each girl
	  	resultSet = Hash.new

	  	Ranking.find_each do |ranks|
	  		#Girl who get rank 1 will get 8(Total number of girls - rank) points
	  		@globalRankScore[ranks.girl_id - 1] += girlCount - ranks.rank
	  	end

	  	@globalRankScore.each_with_index do |score, index|
	  		resultSet[index+1] = {:name => Girl.find_by(id: index+1).name, :score => score}
	  	end

	  	@resultSet = resultSet.sort_by { |k,v| v[:score] }.reverse
	end
end
