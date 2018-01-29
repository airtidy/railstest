require 'rails_helper'

RSpec.describe Nesoberi, type: :model do
	describe "#rank" do
		it "finds the last ranking for the user given" do
			
		end
	end


	it "has valid factory" do
		expect(FactoryBot.create(:nesoberi)).to be_valid
	end
end
