require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
	end

	describe 'best_nesoberi_ranking' do
	    before do
	      User.delete_all
	      Nesoberi.delete_all
	      Ranking.delete_all
	      @user_h = Hash.new
	      @nesoberi_h = Hash.new

	      for i in 0..1000
	      	@user_h[i] = FactoryGirl.create(:user)
		  end

		  for i in 0..9
		  	@nesoberi_h[i] = FactoryGirl.create(:nesoberi)
		  end 
	    end

	    it 'generate and sort ranking' do

	      for i in 0..100
			  FactoryGirl.create(:ranking, rank: 9, user: @user_h[i], nesoberi: @nesoberi_h[0])
		  end
	      best_rankings = Ranking.best_nesoberi_ranking
	      expect(best_rankings[0][1][:nesoberi_name]).to eq( @nesoberi_h[0].name)

	      for i in 100..200
			  FactoryGirl.create(:ranking, rank: 9, user: @user_h[i], nesoberi: @nesoberi_h[1])
		  end
	      best_rankings = Ranking.best_nesoberi_ranking
	      expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[0].name)

	      for i in 200..300
			  FactoryGirl.create(:ranking, rank: 8, user: @user_h[i], nesoberi: @nesoberi_h[2])
		  end
	      best_rankings = Ranking.best_nesoberi_ranking
	      expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[2].name)

		  for i in 300..400
		  	  FactoryGirl.create(:ranking, rank: 7, user: @user_h[i], nesoberi: @nesoberi_h[3])
		  end
	      best_rankings = Ranking.best_nesoberi_ranking
	      expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[3].name)

	      for i in 400..500
		  	  FactoryGirl.create(:ranking, rank: 6, user: @user_h[i], nesoberi: @nesoberi_h[4])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[4].name)

		  for i in 500..600
		  	  FactoryGirl.create(:ranking, rank: 5, user: @user_h[i], nesoberi: @nesoberi_h[5])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[5].name)

		  for i in 600..700
		  	  FactoryGirl.create(:ranking, rank: 4, user: @user_h[i], nesoberi: @nesoberi_h[6])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[6].name)

		  for i in 700..800
		  	  FactoryGirl.create(:ranking, rank: 3, user: @user_h[i], nesoberi: @nesoberi_h[7])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[7].name)

		  for i in 800..900
		  	  FactoryGirl.create(:ranking, rank: 2, user: @user_h[i], nesoberi: @nesoberi_h[8])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[8].name)

		  for i in 900..1000
		  	  FactoryGirl.create(:ranking, rank: 1, user: @user_h[i], nesoberi: @nesoberi_h[9])
		  end
		  best_rankings = Ranking.best_nesoberi_ranking
		  expect(best_rankings[0][1][:nesoberi_name]).to eq(@nesoberi_h[9].name)

		  puts  best_rankings
	    end
  end
end
