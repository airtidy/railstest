require 'rails_helper'

RSpec.describe RankingsController, type: :controller do

  describe "GET #index" do
    it "returns http success with logged in user" do
      sign_in create(:user)

      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns http found with no logged in user" do

      get :index
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #vote_up" do
    it "gives unranked nesoberi a rank" do
      nesoberi = create(:nesoberi)
      user = create(:user)
      sign_in user

      post :vote_up, params: { id: nesoberi.id }
      expect(response).to have_http_status(:no_content)

      expect( user.rankings.count ).to eq(1)

    end
  end

  describe "POST #vote_down" do
    it "gives unranked nesoberi a rank" do
      nesoberi = create(:nesoberi)
      user = create(:user)
      ranking = create(:ranking, user: user, nesoberi: nesoberi, rank: 2)
      sign_in user

      post :vote_down, params: { id: nesoberi.id }
      expect(response).to have_http_status(:no_content)

      expect( user.rankings.count ).to eq(1)

    end
  end

end
