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
    let(:girls) {FactoryGirl.create_list(:girl,9)}
    let(:user) {FactoryGirl.create(:user)}

    it "gives unranked girl a rank" do

      sign_in user

      post :edit, params: { girl: girls[0].id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.count ).to eq(1)

    end
    it "gives ranked girl a rank" do

      sign_in user

      post :edit, params: { girl: girls[0].id , direction: "up" }
      post :edit, params: { girl: girls[1].id , direction: "up" }

      post :edit, params: { girl: girls[1].id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.where( girl_id: girls[1].id).first.rank ).to eq(1)
      expect( user.rankings.where( girl_id: girls[0].id).first.rank ).to eq(2)
    end
    it "gives 1st girl a rank up" do
      
      sign_in user
      post :edit, params: { girl: girls[0].id , direction: "up" }

      post :edit, params: { girl: girls[0].id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.where( girl_id: girls[0].id).first.rank ).to eq(1)
    end
    it "gives last girl a rank down" do   
      sign_in user

      for i in 0..8
        post :edit, params: { girl: girls[i].id , direction: "up" }
      end
      post :edit, params: { girl: girls[8].id , direction: "down" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.where( girl_id: girls[8].id).first.rank ).to eq(9)
    end
  end
end
