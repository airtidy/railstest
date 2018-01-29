require 'rails_helper'

RSpec.describe Ranking, type: :model do
	describe "relationships" do
		before do
			@ranking = create(:ranking)
		end

		describe "belongs_to" do
			it "belongs to a nesoberi" do
				nesoberi = create(:nesoberi)
				@ranking.nesoberi = nesoberi
				expect(@ranking.save).to be true
				expect(@ranking.reload.nesoberi).to eq(nesoberi)
			end

			it "belongs to a user" do
				user = create(:user)
				@ranking.user = user
				expect(@ranking.save).to be true
				expect(@ranking.reload.user).to eq(user)
			end
		end
	end

	describe "validations" do
		before do
			@ranking = build(:ranking)
		end

		context "rank" do
			it "is invalid without a rank" do
				@ranking.rank = nil
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:rank]).to include("is not a number")
			end

			it "is valid with a rank" do
				@ranking.rank = 10
				expect(@ranking.valid?).to be true
			end

			it "must be an integer" do
				["ABC", 1.34, 000].each do |rank|
					@ranking.rank = rank
					expect(@ranking.valid?).to be(false)
				end
			end
		end

		context "nesoberi" do
			it "is invalid without a nesoberi" do
				@ranking.nesoberi = nil
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:nesoberi]).to include("can't be blank")
			end

			it "is invalid if the nesoberi does not exsist" do
				@ranking.nesoberi_id = 5555
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:nesoberi]).to include("must exist")
			end

			it "is valid when an exsisting nesoberi is assigned" do
				nesoberi = create(:nesoberi)
				@ranking.nesoberi = nesoberi
				expect(@ranking.valid?).to be true
			end
		end

		context "user" do
			it "is invalid without a user" do
				@ranking.user = nil
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:user]).to include("can't be blank")
			end

			it "is invalid if the user does not exsist" do
				@ranking.user_id = 5555
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:user]).to include("must exist")
			end

			it "is valid when an exsisting user is assigned" do
				user = create(:user)
				@ranking.user = user
				expect(@ranking.valid?).to be true
			end
		end

		context "nesoberi and user scope" do
			it "can only have one nesoberi rank per user" do
				nesoberi = create(:nesoberi)
				user = create(:user)
				exsisting_ranking = create(:ranking, user: user, nesoberi: nesoberi)

				@ranking.user = user
				@ranking.nesoberi = nesoberi
				expect(@ranking.valid?).to be false
				expect(@ranking.errors.messages[:nesoberi_id]).to include("has already been taken")
			end
		end
	end
end
