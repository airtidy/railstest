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

    let(:girl) { FactoryGirl.create(:girl) }
    let(:girl2) { FactoryGirl.create(:girl) }
    let(:user) { FactoryGirl.create(:user) }

    it "gives unranked girl a rank" do
      sign_in user

      post :edit, params: { girl: girl.id , direction: "up" }
      expect(response).to have_http_status(:found)

      expect( user.rankings.count ).to eq(1)
    end

    it 'should move rank up and down' do
      sign_in user

      post :edit, params: { girl: girl.id, direction: "up" }
      post :edit, params: { girl: girl2.id, direction: "up" }
      expect(user.rankings.count).to eq(2)

      expect(user.rankings[0].rank).to be == 1
      post :edit, params: { girl: girl.id, direction: "up" }
      user.reload
      expect(user.rankings[0].rank).to be == 1
      post :edit, params: { girl: girl.id, direction: "down" }
      user.reload
      expect(user.rankings[0].rank).to be == 2
      post :edit, params: { girl: girl.id, direction: "down" }
      user.reload
      expect(user.rankings[0].rank).to be == 2
    end
  end

end
