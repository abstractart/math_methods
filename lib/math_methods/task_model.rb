class MathMethods::TaskModel
  attr_reader :alternatives
  attr_reader :experts
  attr_reader :ratings
  attr_reader :competitions

  def initialize(args)
    @alternatives = args[:alternatives]
    @experts = args[:experts]
    @competitions = MathMethods::CompetitionsCollection.new(args[:competitions])
    @ratings = MathMethods::RatingsCollection.new(args[:ratings])
  end
end