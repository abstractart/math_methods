class MathMethods::CompetitionsCollection
  attr_reader :competitions
  
  def initialize(competitions) #experts[e]
    @competitions = Hash.new
    competitions.each do |c|
      @competitions[c[:expert_id]] = c[:cf]
    end
  end

  def get_for(expert_id)
    competitions[expert_id]
  end
end