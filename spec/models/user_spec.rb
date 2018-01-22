require 'rails_helper'

RSpec.describe User, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:user)).to be_valid
	end

  describe 'Associations' do
    it 'has many rankings' do
      assc = described_class.reflect_on_association(:rankings)
      expect(assc.macro).to eq :has_many
    end
  end
end
