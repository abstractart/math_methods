class MathMethods::TaskModel
  attr_reader :alternatives
  attr_reader :competitions
  attr_reader :ratings
  attr_reader :experts
  attr_reader :stats
  attr_reader :original_ratings
  attr_reader :original_competitions
  
  def initialize(alternatives, experts, competitions, ratings, stats = [])
    @experts          = experts
    @alternatives     = alternatives
    @ratings          = MathMethods::RatingsCollection.new(ratings)
    @competitions     = MathMethods::CompetitionsCollection.new(competitions)
    @stats            = MathMethods::StatsCollection.new(stats)
    @original_ratings = ratings
    @original_competitions = competitions
  end
end

=begin
# rating
{
  expert: :e1,
  values: [
    {
      alternative: :a1,
      range: 1
    },
    {
      alternative: :a2,
      range: 2
    },
    {
      alternative: :a3,
      range: 3
    },
    {
      alternative: :a4,
      range: 4
    },
    {
      alternative: :a5,
      range: 5
    },                
  ]
}

# alternatives
[:a1, :a2, :a3, :a4, :a5]

# competitions
{
  e1: 0.2,
  e2: 0.3,
  e3: 0.4,
  e4: 0.1
}
=end