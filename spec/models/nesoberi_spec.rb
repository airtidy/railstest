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
end
