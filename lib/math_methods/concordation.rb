class MathMethods::Concordation
  attr_reader :task
  
  def initialize(task)
    @task = task
  end

  def coef
    12.0 * outer_sum / self.class.denominator(task.alternatives.size)
  end

  def self.d_t(alt_count, exp_count)
    24.0 / (exp_count ** 2 * denominator(alt_count))
  end

  def self.u_t(alt_count, l)
    alternatives = (1..alt_count).to_a
    experts      = (1..(alt_count + 1 - l)).to_a
    competitions = experts.map { |e| { expert: e, cf: 1.0 / experts.size } }
    
    init_range = alternatives.map.with_index do |a, i|
      {
        alternative: a,
        rating: i + 1
      }
    end
    ratings = experts.zip(generate_ranges(init_range, l)).map do |range|
      r = {}
      r[:expert] = range.first
      r[:values] = range.last
      r
    end 

    task = MathMethods::TaskModel.new(alternatives, experts, competitions, ratings)
    self.new(task).coef
  end
 
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

  def self.generate_ranges(range, l)
    range_hash = range.map {|r| [r[:rating], r[:alternative]]}.to_h
    
    ranges = (1..range.size - l).to_a.map do |r|
      tmp_range = range_hash.clone
      rating_for_swap = r + l

      tmp_rating = tmp_range[r]
      tmp_range[r] = tmp_range[rating_for_swap]
      tmp_range[rating_for_swap] = tmp_rating

      tmp_range
    end
    ranges << range_hash

    ranges.map! do |r|
      r.keys.map do |i|
        {
          alternative: r[i],
          rating: i
        }        
      end
    end 
  end

  private

  def self.denominator(alt_count)
    alt_count ** 3 - alt_count
  end
  
  def outer_sum
    task.alternatives.map {|a| outer_sum_element(a)}.reduce(:+)
  end

  def outer_sum_element(alt)
    ((task.alternatives.size + 1.0) / 2.0 - inner_sum(alt)) ** 2
  end

  def inner_sum(alt)
    task.experts.map { |e| inner_sum_element(alt, e)}.reduce(:+)
  end

  def inner_sum_element(alternative, expert)
    task.ratings.get(expert, alternative) * task.competitions.get_for(expert)
  end
end