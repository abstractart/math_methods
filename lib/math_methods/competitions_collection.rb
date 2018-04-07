class MathMethods::CompetitionsCollection
  attr_reader :competitions
  
  def initialize(competitions) #experts[e]
    @competitions = Hash.new
    competitions.each do |c|
      @competitions[c[:expert]] = c[:cf]
    end
  end

  def get_for(e)
    competitions[e]
  end
end