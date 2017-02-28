require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
	end
end
