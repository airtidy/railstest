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
    before(:each) do
      @girls = FactoryGirl.create_list(:girl, 9)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    after(:each) do
      expect(response).to have_http_status(:found)
    end

    context "when not all girls are ranked" do
      it "gives unranked girl a rank" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }

        expect( @user.rankings.count ).to eq(1)
      end

      it "moves ranked girl up" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }
        post :edit, params: { girl: @girls[1].id, direction: "up" }
        post :edit, params: { girl: @girls[1].id, direction: "up" }

        expect( @user.rankings.where(girl_id: @girls[0].id).first.rank ).to eq(2)
        expect( @user.rankings.where(girl_id: @girls[1].id).first.rank ).to eq(1)
      end

      it "moves ranked girl down" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }
        post :edit, params: { girl: @girls[1].id, direction: "up" }
        post :edit, params: { girl: @girls[0].id, direction: "down" }

        expect( @user.rankings.where(girl_id: @girls[0].id).first.rank ).to eq(2)
        expect( @user.rankings.where(girl_id: @girls[1].id).first.rank ).to eq(1)
      end

      it "does not raise top girl" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }
        post :edit, params: { girl: @girls[0].id, direction: "up" }

        expect( @user.rankings.where(girl_id: @girls[0].id).first.rank ).to eq(1)
      end

      it "does not lower last girl" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }
        post :edit, params: { girl: @girls[1].id, direction: "up" }
        post :edit, params: { girl: @girls[1].id, direction: "down" }

        expect( @user.rankings.where(girl_id: @girls[1].id).first.rank ).to eq(2)
      end
    end

    context "when every girl is ranked" do
      before(:each) do
        for i in 0..@girls.length - 1
          post :edit, params: { girl: @girls[i].id, direction: "up" }
        end
      end

      it "moves ranked girl up" do
        post :edit, params: { girl: @girls[1].id, direction: "up" }

        expect( @user.rankings.where(girl_id: @girls[1].id).first.rank ).to eq(1)
      end

      it "moves ranked girl down" do
        post :edit, params: { girl: @girls[0].id, direction: "down" }

        expect( @user.rankings.where(girl_id: @girls[0].id).first.rank ).to eq(2)
      end

      it "does not raise top girl" do
        post :edit, params: { girl: @girls[0].id, direction: "up" }

        expect( @user.rankings.where( girl_id: @girls[0].id).first.rank ).to eq(1)
      end

      it "does not lower last girl" do
        post :edit, params: { girl: @girls[@girls.length - 1].id, direction: "down" }

        expect( @user.rankings.where( girl_id: @girls[@girls.length - 1].id).first.rank ).to eq(@girls.length)
      end
    end
  end

end
