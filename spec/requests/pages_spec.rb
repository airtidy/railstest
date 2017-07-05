require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /pages" do
    it "works! (now write some real specs)" do
      get root_path
      expect(response).to have_http_status(200)
    end

     it "has ranking ladderboard" do
       get root_path
       expect(response.body).to include("table", "rank")
     end
  end
end
