require 'rails_helper'

RSpec.describe "Ranking", type: :request do
  describe "GET /ranking" do
    it "cannot view ranking if not signed in" do
      get ranking_view_path	
      expect(response).to have_http_status(302)
    end

    it "can view ranking if signed in" do
      sign_in FactoryGirl.create(:user)	
      get ranking_view_path	
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /ranking" do
    it "can decrease girl rank" do
      sign_in FactoryGirl.create(:user)
      post ranking_edit_path, params: {direction: 'down', girl: 1}
      expect(response).to redirect_to(ranking_view_path)
    end

    it "can increase girl rank" do
      sign_in FactoryGirl.create(:user)
      post ranking_edit_path, params: {direction: 'up', girl: 1}
      expect(response).to redirect_to(ranking_view_path)
      get ranking_view_path
      expect(response.body).to include("table", "<td>1</td>")
    end
  end
end
