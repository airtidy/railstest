require 'rails_helper'

RSpec.describe RankingController, type: :controller do

  describe "GET #view" do
    it "returns http success with logged in user" do
      sign_in FactoryBot.create(:user)

      get :view
      expect(response).to have_http_status(:success)
    end

    it "returns http found with no logged in user" do

      get :view
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #edit" do
    it "gives unranked nesoberi a rank" do
      nesoberi = FactoryBot.create(:nesoberi)
      user = FactoryBot.create(:user)
      sign_in user

      post :edit, params: { nesoberi: nesoberi.id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.count ).to eq(1)

    end
  end


end
