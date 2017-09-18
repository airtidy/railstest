require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do

      get :index
      expect(response).to have_http_status(:success)
    end

    it "assign @top_girls array" do
      get :index
      expect(assigns(:top_girls)).not_to be_nil
    end

  end
end
