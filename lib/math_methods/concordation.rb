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
    alternatives = ("a1".."a#{alt_count}").to_a
    experts      = ("e1".."e#{alt_count + 1 - l}").to_a
    competitions = experts.map { |e| { expert: e, cf: 1.0 / experts.size } }
    ratings = ranges(experts, alternatives, l)
    task = MathMethods::TaskModel.new(alternatives, experts, competitions, ratings)
    self.new(task).coef
  end

  private
  
  def self.ranges(experts, alternatives, l)
    init_range = (1..alternatives.size).to_a.zip(alternatives).to_h

    result = (1..alternatives.size - l).to_a.map do |r|
      tmp_range = init_range.clone
      range_for_swap = r + l

      tmp_rating = tmp_range[r]
      tmp_range[r] = tmp_range[range_for_swap]
      tmp_range[range_for_swap] = tmp_rating

      tmp_range
    end
    result << init_range
    binding.pry
    experts.zip(result).map do |range|
      r = {}
      r[:expert] = range.first
      r[:values] = []
      range.last.each {|key, value| r[:values] << { alternative: value, rating: key } }
      r
    end 
  end

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