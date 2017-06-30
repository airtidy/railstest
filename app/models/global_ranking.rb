class GlobalRanking
  def sorted
    # Less total score = upper rank
    @sorted ||= ranks.sort_by(&:rank)
  end

  private

  def ranks
    @ranks ||= girls.map { |g| GlobalRank.new(g) }
  end

  def girls
    @girls ||= Girl.all
  end
end
