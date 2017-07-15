require 'rails_helper'

RSpec.describe Girl, type: :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:girl)).to be_valid
  end

  it "gets the sum of all rankings" do
    girl = FactoryGirl.create(:girl)
    FactoryGirl.create_list(:ranking, 10, girl: girl, rank: 1)

    expect(girl.total_rank).to eq(10)
  end
end
