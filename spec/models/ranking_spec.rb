require 'rails_helper'

RSpec.describe Ranking, type: :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:ranking)).to be_valid
  end

  it "checks uniqeness of girl ranking per user" do
    user = FactoryGirl.create(:user)
    girl = FactoryGirl.create(:girl)

    FactoryGirl.create(:ranking, user: user, girl: girl, rank: 1)
    new_rank = FactoryGirl.build(:ranking, user: user, girl: girl, rank: 1)
    expect { new_rank.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
