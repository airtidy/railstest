require 'rails_helper'

RSpec.describe Ranking, type: :model do
	it "has valid factory" do
		expect(FactoryGirl.create(:ranking)).to be_valid
  end

  it "able to find current ladderboard" do
    expect(Ranking.ladder.length).to be > 0
  end
end
