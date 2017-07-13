class MathMethods::OrdinaryFeedback
  attr_reader :competitions
  attr_reader :ranges
  attr_reader :alt_count
  attr_reader :exp_count
  attr_reader :expert_stats
  attr_reader :consistency_coef

  def initialize(args)
    @competitions = args[:competitions]
    @ranges = args[:ranges]
    @expert_stats = args[:expert_stats]
    @exp_count = @competitions.length
    @alt_count = @ranges[0].length
    @consistency_coef = MathMethods::NewConcordation.new(ranges: @ranges, competitions: competitions).get_coef
  end

  def generate_request
    result = {}
    
    fill_hash(result, 0)
    expert_stats.each_with_index do |stat, i|
      if stat < result[:count_of_changes] ||
         (stat == result[:count_of_changes] && competitions[i] < result[:competition])
        fill_hash(result, i)
      end
    end
    
    weak_range = ranges[result[:expert_index]]
    new_ranges = MathMethods::NewConcordation.get_new_ranges(weak_range, 1)
    ranges_with_cf = new_ranges.map do |nr|
      temp_ranges = ranges.clone
      temp_ranges[result[:expert_index]] = nr
      [MathMethods::NewConcordation.new(ranges: temp_ranges, competitions: competitions).get_coef, nr]
    end
    best_range = ranges_with_cf.max
    result[:best_range] = best_range[1]
    result[:new_cf]     = best_range[0]

    result
  end

  private

  def fill_hash(hash, index)
    hash[:competition] = competitions[index]
    hash[:count_of_changes] = expert_stats[index]
    hash[:expert_index]     = index
  end 
end
