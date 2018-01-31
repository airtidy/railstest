require 'rails_helper'

RSpec.describe "Ranking", type: :request do
  describe "GET /ranking" do
    it "cannot view ranking if not signed in" do
      get rankings_path
      expect(response).to have_http_status(302)

    end

    it "can view ranking if signed in" do

    	sign_in create(:user)

      get rankings_path
      expect(response).to have_http_status(200)

    end

  end
end
