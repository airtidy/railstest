require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do

      get :index
      expect(response).to have_http_status(:success)
    end

    it "creates rankings and get best girl rank score" do
      girl1 = FactoryGirl.create(:girl)
      girl2 = FactoryGirl.create(:girl)
      girl3 = FactoryGirl.create(:girl)
      girl4 = FactoryGirl.create(:girl)

      user1 = FactoryGirl.create(:user)
      ranking1 = FactoryGirl.create(:ranking, girl: girl1, user: user1, rank: 4)
      ranking2 = FactoryGirl.create(:ranking, girl: girl2, user: user1, rank: 3)
      ranking3 = FactoryGirl.create(:ranking, girl: girl3, user: user1, rank: 2) # score: 3
      ranking4 = FactoryGirl.create(:ranking, girl: girl4, user: user1, rank: 1) # score: 4

      user2 = FactoryGirl.create(:user)
      ranking5 = FactoryGirl.create(:ranking, girl: girl1, user: user2, rank: 4)
      ranking6 = FactoryGirl.create(:ranking, girl: girl2, user: user2, rank: 3)
      ranking7 = FactoryGirl.create(:ranking, girl: girl3, user: user2, rank: 2) # score: 3
      ranking8 = FactoryGirl.create(:ranking, girl: girl4, user: user2, rank: 1) # score: 4

      get :index

      # test Rank 1 score
      # [[<id>, {:name=>xxx, :score=>8}], [<id>, {:name=>xxx, :score=>6}], ...]
      expect(assigns(:girl_score)[0][1][:score]).to eq(8)
    end
  end
end
