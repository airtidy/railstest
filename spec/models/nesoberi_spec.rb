require 'rails_helper'

RSpec.describe Nesoberi, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:nesoberi)).to be_valid
	end
end
