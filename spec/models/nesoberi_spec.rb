require 'rails_helper'

RSpec.describe Nesoberi, type: :model do
	before do
		@nesoberi = create(:nesoberi)
	end

	describe "relationships" do
		it "has many rankings" do
			create_list(:ranking, 3, nesoberi: @nesoberi)
			expect(@nesoberi.rankings.length).to eq(3)
		end
	end

	describe "validations" do
		it "is invalid without a name" do
			@nesoberi.name = nil
			expect(@nesoberi.valid?).to be false
			expect(@nesoberi.errors.messages[:name]).to include("can't be blank")
		end

		it "is valid with a name" do
			@nesoberi.name = "Giggles"
			expect(@nesoberi.valid?).to be true
		end
	end

	describe "class methods" do
		describe ".global_rankings" do
			it "is in order of highest to lowest rank" do
				Nesoberi.destroy_all
				nesoberis = create_list(:nesoberi, 3)
				rank = 1
				nesoberis.each do |nesoberi|
					create_list(:ranking, 3, nesoberi: nesoberi, rank: rank)
					rank += 1
				end
				rankings = Nesoberi.all.sort_by(&:global_rank).reverse
				expect(rankings.length).to eq(3) #ensure they exsist
				global_rankings = Nesoberi.global_rankings
				expect(global_rankings.first.global_rank).to be > global_rankings.last.global_rank
				expect(global_rankings.first).to eq(rankings.first)
				expect(global_rankings.last).to eq(rankings.last)
			end
		end
	end

	describe "#rank" do
		before do
			@users = create_list(:user, 3)
			rank = 1
			@users.each do |user|
				create(:ranking, nesoberi: @nesoberi, rank: rank, user: user)
				rank += 1
			end
		end

		it "finds the ranking for the user given" do
			expect(@nesoberi.rank(@users.first)).to eq(1)
			expect(@nesoberi.rank(@users.last)).to eq(3)
		end

		it "returns 0 for a user not found" do
			no_rank_user = create(:user)
			expect(@nesoberi.rank(no_rank_user)).to eq(0)
		end
	end

	describe "#global_rank" do
		it "should return the sum of all user rankings" do
			users = create_list(:user, 3)
			users.each do |user|
				create(:ranking, user: user, nesoberi: @nesoberi, rank: 2)
			end
			# 3 users with rank of 2 each
			expect(@nesoberi.global_rank).to eq(6)
		end
	end

	describe "#vote_up" do
		it "updates the vote for the ranking found" do
			ranking = create(:ranking, nesoberi: @nesoberi, rank: 3)
			current_rank = @nesoberi.rank(ranking.user)
			@nesoberi.vote_up(ranking.user)
			expect(@nesoberi.rank(ranking.user)).to eq(4)
		end

		it "creates a new ranking if no ranking exsists" do
			user = create(:user)
			expect(@nesoberi.rankings.where(user: user)).to be_blank
			expect(@nesoberi.rank(user)).to eq(0)
			@nesoberi.vote_up(user)
			expect(@nesoberi.rank(user)).to eq(1)
			expect(@nesoberi.rankings.where(user: user).length).to eq(1)
		end
	end


		describe "#vote_down" do
			it "updates the vote for the ranking found" do
				ranking = create(:ranking, nesoberi: @nesoberi, rank: 3)
				current_rank = @nesoberi.rank(ranking.user)
				@nesoberi.vote_down(ranking.user)
				expect(@nesoberi.rank(ranking.user)).to eq(2)
			end

			it "creates a new ranking if no ranking exsists" do
				user = create(:user)
				expect(@nesoberi.rankings.where(user: user)).to be_blank
				expect(@nesoberi.rank(user)).to eq(0)
				@nesoberi.vote_down(user)
				expect(@nesoberi.rank(user)).to eq(0)
				expect(@nesoberi.rankings.where(user: user).length).to eq(1)
			end
		end
end
