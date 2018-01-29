require 'rails_helper'

RSpec.describe "Ranking", type: :request do
  describe "GET /ranking" do
    it "cannot view ranking if not signed in" do
      get ranking_view_path	
      expect(response).to have_http_status(302)

    end

    it "can view ranking if signed in" do

    	sign_in FactoryBot.create(:user)
    	
      get ranking_view_path	
      expect(response).to have_http_status(200)

    end

  end
end
