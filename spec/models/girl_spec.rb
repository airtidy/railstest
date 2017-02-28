require 'rails_helper'

RSpec.describe Girl, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:girl)).to be_valid
	end
end
