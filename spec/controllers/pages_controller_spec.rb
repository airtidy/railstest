require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do

      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @girls" do
    	get :index
    	assert_equal Girl.select("girls.*, SUM(rankings.rank) total_rank").joins(:rankings).group("girls.id").order("total_rank DESC"), assigns(:girls)
    end

    it "assigns @girls" do
    	get :index
    	expect(response).to render_template("index")
    end
  end
end
