class MathMethods::CardinalTask < MathMethods::TaskModel
  attr_reader :scale
  def initialize(alternatives, experts, competitions, ratings, stats = [], scale)
    super(alternatives, experts, competitions, ratings, stats)
    @scale = scale
  end
end