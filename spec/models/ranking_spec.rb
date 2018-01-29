require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryBot.create(:ranking)).to be_valid
	end
end
