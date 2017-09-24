class MathMethods::RatingsCollection
  attr_reader :ratings
  
  def initialize(ratings) #ratings[a][e]
    @ratings = Hash.new
    ratings.each do |r|
      @ratings[r[:expert]] ||= Hash.new
      r[:values].each do |v|
        @ratings[r[:expert]][v[:alternative]] = v[:rating]
      end
    end
  end

  def for_alternative(a)
    ratings.keys.map { |e| [e, ratings[e][a]] }.to_h
  end

  def get(e, a)
    ratings[e][a]
  end

  def for_expert(e)
    ratings[e]
  end
end