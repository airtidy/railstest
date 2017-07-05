require 'rails_helper'

describe GlobalRanking do
  it 'returns sorted array' do
    global_ranking = GlobalRanking.new
    allow(global_ranking).to receive(:ranks).and_return(global_ranks)
    sorted = global_ranks.sort_by(&:rank)

    expect(global_ranking.sorted).to eq(sorted)
  end
end

def global_ranks
  [
    double('rank', rank: 2),
    double('rank', rank: 3),
    double('rank', rank: 4),
    double('rank', rank: 1),
  ]
end
