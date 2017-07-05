class GlobalRank
  attr_reader :girl

  def initialize(girl)
    @girl = girl
  end

  def rank
    @rank ||= girl.rankings.sum(&:rank)
  end
end
