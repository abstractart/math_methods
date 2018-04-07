class MathMethods::StatsCollection
  attr_reader :stats
  
  def initialize(stats)
    @stats = Hash.new
    stats.each do |c|
      @stats[c[:expert]] = c[:count_of_changes]
    end
  end

  def get_for(e)
    stats[e]
  end
end