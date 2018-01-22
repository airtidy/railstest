require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
	end

  describe 'global_ranking' do
    before do
      Ranking.delete_all
      User.delete_all
      Nesoberi.delete_all
      @user1 = FactoryGirl.create(:user) 
      @user2 = FactoryGirl.create(:user) 
      @nesoberi1 = FactoryGirl.create(:nesoberi) 
      @nesoberi2 = FactoryGirl.create(:nesoberi) 
      @nesoberi3 = FactoryGirl.create(:nesoberi) 
      @ranking_u1_n1 = FactoryGirl.create(:ranking, rank: 1, user: @user1, nesoberi: @nesoberi1)
      @ranking_u1_n2 = FactoryGirl.create(:ranking, rank: 2, user: @user1, nesoberi: @nesoberi2)
      @ranking_u1_n3 = FactoryGirl.create(:ranking, rank: 3, user: @user1, nesoberi: @nesoberi3)
      @ranking_u2_n1 = FactoryGirl.create(:ranking, rank: 1, user: @user2, nesoberi: @nesoberi1)
      @ranking_u2_n2 = FactoryGirl.create(:ranking, rank: 2, user: @user2, nesoberi: @nesoberi2)
      @ranking_u3_n3 = FactoryGirl.create(:ranking, rank: 3, user: @user2, nesoberi: @nesoberi3)
    end

    it 'returns score hash' do
      ranks = Ranking.global_ranking
      expect(ranks[0][1][:nesoberi_name]).to eq(@nesoberi1.name)
      expect(ranks[1][1][:nesoberi_name]).to eq(@nesoberi2.name)
      expect(ranks[2][1][:nesoberi_name]).to eq(@nesoberi3.name)
    end
  end
end
