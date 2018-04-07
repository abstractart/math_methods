class MathMethods::NewPosterioriCompetition
  attr_reader :task
  attr_reader :result_range
  attr_reader :rejection

  def initialize(task, result_range, task_type)
    @task = task
    @result_range = result_range.invert
    set_rejection(task.alternatives, task_type) 
  end

  def get_new_coefficients
    rejections = {}
    task.experts.each do |e|
      rejections[e] = rejection.get(task.ratings.for_expert(e), result_range)
    end
    d_t_max = rejections.values.max
    
    coefficients = {}
    task.experts.each do |e|
      coefficients[e] = new_competition(
        new_potential(
          start_potential(task.competitions.get_for(e), b),
          rejections[e],
          d_t_max),
        b).round(4)
    end
    coefficients
  end

  private

  def set_rejection(alternatives, task_type)
    raise "task type #{task_type} not supported" unless [:ordinal, :cardinal].include?(task_type)
    if task_type == :ordinal
      @rejection = MathMethods::NewOrdinalRejection.new(alternatives)
    elsif task_type == :cardinal
      @rejection = MathMethods::NewCardinalRejection.new(alternatives)
    end
  end
  
  def b(c1 = 0.9)
    2 * Math.log(c1 / (1 - c1))
  end

  def t
    50
  end

    
  def new_competition(potential, b)
    1.0 / (1.0 + Math.exp(- b * (potential - 0.5)))
  end

  #right
  def start_potential(competition, b)
    0.5 - 1 / b * Math.log((1.0 - competition) / competition)
  end

  def new_potential(potential, d_t, d_t_max)
    potential + 0.5 / t - 1.0 / t * d_t / d_t_max
  end
end

class MathMethods::Rejection
  attr_reader :alternatives

  def initialize(alternatives)
    @alternatives = alternatives
  end
end

class MathMethods::NewCardinalRejection < MathMethods::Rejection
  def get(expert_range,result_range)
    alternatives.map do |a|
      (expert_range[a] - result_range[a]) ** 2.0
    end.reduce(:+) ** 0.5
  end
end

class MathMethods::NewOrdinalRejection < MathMethods::Rejection
  def get(expert_range,result_range)
    alternatives.map do |a|
      (expert_range[a] - result_range[a]).abs
    end.reduce(:+).to_f
  end
end