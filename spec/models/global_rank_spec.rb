require 'rails_helper'

describe GlobalRank do
  it "summs girl's ranks" do
    girl = create(:girl)
    create(:ranking, girl: girl, rank: 1)
    create(:ranking, girl: girl, rank: 2)
    create(:ranking, girl: girl, rank: 3)

    global_rank = GlobalRank.new(girl)
    expect(global_rank.rank).to eq(1 + 2 + 3)
  end
end
