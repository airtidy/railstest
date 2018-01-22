require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "has a table with one row for each nesoberi in the global ranking" do
      get :index
      expect(response).to have_selector('table#global_ranking td', count: Nesoberi.count)
    end
  end
end
