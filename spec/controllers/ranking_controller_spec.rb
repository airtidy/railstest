require 'rails_helper'

RSpec.describe RankingController, type: :controller do

  describe "GET #view" do
    it "returns http success with logged in user" do
      sign_in FactoryGirl.create(:user)

      get :view
      expect(response).to have_http_status(:success)
    end

    it "returns http found with no logged in user" do

      get :view
      expect(response).to have_http_status(:found)
    end
  end

  describe "POST #edit" do
    it "gives unranked girl a rank" do
      girl = FactoryGirl.create(:girl)
      user = FactoryGirl.create(:user)
      sign_in user

      post :edit, params: { girl: girl.id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.count ).to eq(1)

    end
  end


end
