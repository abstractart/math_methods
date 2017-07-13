class MathMethods::PosterioriCompetition
  attr_reader :competitions #глобальные оценки а не относительные
  attr_reader :ranges
  attr_reader :result_range
  attr_reader :rejection
  
  def initialize(args)
    @competitions = args[:competitions]
    @ranges = args[:ranges]
    @result_range = args[:result_range]
    set_rejection(args[:task_type]) 
  end

  def get_new_coefficients
    rejections = ranges.map {|er| rejection.get(er, result_range) }
    d_t_max = rejection.max
    competitions.with_index.map do |c, i|
      new_competition(
          new_potential(
              start_potential(c, b), 
              T, 
              rejections[i], #d_t
              d_t_max), 
          b)
    end
  end

  private

  def set_rejection(task_type)
    raise "task type #{task_type} not supported" unless [:ordinal, :cardinal].include?(task_type)
    if task_type == :ordinal
      @rejection = MathMethods::OrdinalRejection.new
    elsif task_type == :cardinal
      @rejection = MathMethods::CardinalRejection.new
    end
  end
  
  def b(c1 = 0.9)
    2 * Math.log(c1 / (1 - c1))
  end

  def T
    50
  end

  def new_competition(potential, b)
    1 / (1 + Math.exp(-b * (potential - 0.5)))
  end

  def start_potential(competition, b)
    0.5 - 1 / b * Math.log((1 - competition) / competition)
  end

  def new_potential(potential, T, d_t, d_t_max)
    potential + 0.5 / T - 1 / T * d_t / d_t_max
  end
end

class MathMethods::CardinalRejection
  def get(expert_range,result_range)
    result = 0
    for i in 0...expert_range.count
      result += (expert_range[i] - result_range[i]) ** 2
    end
    return Math.sqrt(result)
  end
end

class MathMethods::OrdinalRejection
  def get(expert_range,result_range)
    result = 0
    for i in 0...expert_range.count
      result += (expert_range[i] - result_range[i]).abs
    end
    result
  end
end