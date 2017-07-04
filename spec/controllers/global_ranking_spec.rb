require 'rails_helper'

describe RankingController do
	let(:db) {
		FactoryGirl.create_list(:girl, 5)
		FactoryGirl.create_list(:user, 5)
		User.all.each do |user|
			Girl.all.each_with_index do |girl, index|
        FactoryGirl.create(:ranking, user: user, girl_id: girl.id, rank: index + 1)
      end
      user.update_absolute_ranks_of_ranking
		end
	}
	context "changes in ranking affect global ranks" do

		it "rank increase" do
			db
			girl = Girl.first
			initial_global_absolute_rank = girl.global_sum_absolute_ranks
			initial_global_relative_rank = girl.global_sum_relative_ranks
			User.all.each do |user|
					sign_in user
	        post :edit, params: { girl: girl.id , direction: "down" }
			end

			girl = Girl.first
			expect(girl.global_sum_absolute_ranks).to be > initial_global_absolute_rank
			expect(girl.global_sum_relative_ranks).to be > initial_global_relative_rank
		end

		it "rank decrease" do
			db
			girl = Girl.all.last
			initial_global_absolute_rank = girl.global_sum_absolute_ranks
			initial_global_relative_rank = girl.global_sum_relative_ranks
			user = User.first
			# User.all.each do |user|
					sign_in user

	        post :edit, params: { girl: girl.id , direction: "up" }

	        sign_out user
			# end
			girl = Girl.last
			expect(girl.global_sum_absolute_ranks).to be < initial_global_absolute_rank
			expect(girl.global_sum_relative_ranks).to be < initial_global_relative_rank
		end
	end
end