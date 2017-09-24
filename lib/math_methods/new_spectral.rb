class MathMethods::NewSpectral
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def coef(alternative)
    1 - numerator(specter(alternative)) / denominator
  end

  def self.d_t(scale)
    experts      = (1..scale).to_a
    alt = :a
    competitions = experts.map { |e| { expert: e, cf: 1.0 / experts.size } }
    r = experts.map.with_index do |e, i|
      {
        expert: e,
        values: [
          { alternative: alt, rating: i + 1 }
        ]
      }
    end
    r.first[:values].first[:rating] = median_value(scale)
    task = MathMethods::CardinalTask.new([alt], experts, competitions, r, [], scale)
    self.new(task).coef(alt)
  end

  def self.u_t(scale)
    experts = [:e1, :e2]
    alt = :a
    competitions = experts.map { |e| { expert: e, cf: 1.0 / experts.size } }
    ratings = 
    [
      {
        expert: :e1,
        values: [{ alternative: alt, rating: 3 }]
      },
      {
        expert: :e2,
        values: [{ alternative: alt, rating: 2 }]
      }
    ]
    task = MathMethods::CardinalTask.new([alt], experts, competitions, ratings, [], scale)
    self.new(task).coef(alt)
  end

  def average(alternative)
    task.experts.map {|e| task.competitions.get_for(e) * task.ratings.get(e, alternative)}.reduce(:+)
  end

  def weak_values(alternative)
    avg = average(alternative)
    task.experts.map {|e| { expert: e, value: ((task.ratings.get(e, alternative) - avg).abs / task.competitions.get_for(e)).round(3) } }
  end

  def weak_expert(alternative)
    wv = weak_values(alternative)
    min_cf = wv.map{|i| i[:value]}.max
    wv.select { |uv| uv[:value] == min_cf }.first
  end

  private

  def self.median_value(scale)
    (0.5 * scale + 1).to_i
  end

  def numerator(specter)
    outer_sum(specter) - sum_with_ln(specter)
  end

  def specter(alternative)
    r = {}
    task.ratings.for_alternative(alternative).each do |k, v|
      r[v] ||= 0
      r[v] += task.competitions.get_for(k)
    end
    r
  end

  def outer_sum(specter)
    inner_sum_value = inner_sum(specter)
    specter.to_a.map { |i| i.last * (i.first - inner_sum_value).abs }.reduce(:+)
  end

  def inner_sum(specter)
    specter.to_a.map { |i| i.first * i.last }.reduce(:+)
  end

  #fine
  def sum_with_ln(specter)
    specter.values.map {|v| v * Math.log(v)}.reduce(:+)
  end

  #fine
  def denominator
    g_func * denominator_sum + Math.log(task.scale)
  end

  #fine
  def g_func
    task.experts.size / (Math.log(task.experts.size) * Math.log(task.scale) * task.scale)
  end

  #fine
  def denominator_sum
    (1..task.scale).to_a.map { |i| (i - (task.scale + 1.0) / 2.0).abs }.reduce(:+)
  end
end