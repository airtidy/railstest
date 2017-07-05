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
    let(:girls) { FactoryGirl.create_list(:girl, 3)}
    let(:girl) { FactoryGirl.create :girl }
    let(:user) { FactoryGirl.create :user }
    let(:rankingList) {
      girls.each_with_index do |girl, index|
        FactoryGirl.create(:ranking, user: user, girl_id: girl.id, rank: index + 1)
      end
    }
    context "for unranked girl" do


      it "single girl increasing rank (direction up)" do

        sign_in user

        post :edit, params: { girl: girl.id , direction: "up" }
        expect(response).to have_http_status(:found)
        expect( girl.rank(user)).to eq(1)
        expect( user.rankings.count ).to eq(1)

      end

      it "single girl derection down" do
        sign_in user

        post :edit, params: { girl: girl.id , direction: "down" }
        expect(response).to have_http_status(:found)
        expect( girl.rank(user)).to eq(1)
        expect( user.rankings.count ).to eq(1)
      end

      it "multiple girls increasing rank (direction up)" do

        #CREATES PREVIOUS GIRLS WITH RANKINGS FROM :user
        rankingList

        sign_in user
        post :edit, params: { girl: girl.id , direction: "up" }
        expect(response).to have_http_status(:found)
        expect( girl.rank(user)).to eq(4)
        expect( user.rankings.count ).to eq(4)

      end

      it "multiple girls derection down" do

        #CREATES PREVIOUS GIRLS WITH RANKINGS FROM :user
        rankingList

        sign_in user
        post :edit, params: { girl: girl.id , direction: "down" }
        expect(response).to have_http_status(:found)
        expect( girl.rank(user)).to eq(4)
        expect( user.rankings.count ).to eq(4)

      end      
    end

    context "ranked girl" do
      before {
        rankingList

      }

      it "rank = first and press up" do
        first_girl = Girl.first
        sign_in user
        post :edit, params: { girl: first_girl.id , direction: "up" }
        expect(response).to have_http_status(:found)
        expect( first_girl.rank(user)).to eq(1)
        expect( user.rankings.count ).to eq(3)
      end

      it "rank = last and press down" do
        last_girl = Girl.last
        sign_in user
        post :edit, params: { girl: last_girl.id , direction: "down" }
        expect(response).to have_http_status(:found)
        expect( last_girl.rank(user)).to eq(3)
        expect( user.rankings.count ).to eq(3)
      end

      it "mid rank and press up" do
        first_girl = Girl.first
        second_girl = Girl.second
        sign_in user
        post :edit, params: { girl: second_girl.id , direction: "up" }
        expect(response).to have_http_status(:found)
        expect( second_girl.rank(user)).to eq(1)
        expect( first_girl.rank(user)).to eq(2)
      end

      it "mid rank and press down" do
        last_girl = Girl.last
        second_girl = Girl.second
        sign_in user
        post :edit, params: { girl: second_girl.id , direction: "down" }
        expect(response).to have_http_status(:found)
        expect( second_girl.rank(user)).to eq(3)
        expect( last_girl.rank(user)).to eq(2)
      end

    end
  end


end
