require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
	end

  describe 'Associations' do
    it 'belongs to one user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to one nesoberi' do
      assc = described_class.reflect_on_association(:nesoberi)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
