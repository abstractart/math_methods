class MathMethods::RatingsCollection
  attr_reader :ratings
  
  def initialize(ratings) #ratings[a][e]
    @ratings = Hash.new
    ratings.each do |r|
      @ratings[r[:alternative_id]] ||= Hash.new
      @ratings[r[:alternative_id]][r[:expert_id]] = r[:value]
    end
  end

  def for_expert(key)
    Hash.new(@ratings.keys.map { |a| [a, ratings[a][key]]})
  end

  def get(alternative_id, expert_id)
    @ratings[alternative_id][expert_id]
  end

  def for_alternative(key)
    @ratings[key]
  end
end