require 'rails_helper'

RSpec.describe Girl, type: :model do
	it 'has valid factory' do
		expect(FactoryGirl.create(:girl)).to be_valid
  end

	let(:girl) { FactoryGirl.create(:girl) }
  it 'should calculate average rank' do
		FactoryGirl.create(:ranking, :rank => 1, :girl_id => girl.id)
		FactoryGirl.create(:ranking, :rank => 2, :girl_id => girl.id)
    expect(girl.average_rank).to be == 1.5
  end
end
