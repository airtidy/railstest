require 'rails_helper'

RSpec.describe Girl, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:girl)).to be_valid
	end
	
	it "has many rankings" do 
		girl = FactoryGirl.create(:girl)
		girl.rankings.push(FactoryGirl.create(:ranking))
		girl.rankings.push(FactoryGirl.create(:ranking))
		girl.rankings.push(FactoryGirl.create(:ranking))
		girl.rankings.push(FactoryGirl.create(:ranking))
	
		expect(girl.rankings.count).to eq(4)
	end
end
