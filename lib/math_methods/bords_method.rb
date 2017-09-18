class MathMethods::BordsMethod

  def initialize(task)
    @task = task
  end

  def get_result
    ranges = task.alternatives.map do |a|
      task.experts.map do |e|
        normal_range(a, e) * task.competitions.get_for(e)
      end
    end
    
    sum_of_ranges = ranges.map { |a| a.inject(:+).round(2) }
    sum_of_ranges_with_alternative = sum_of_ranges.map.with_index do |sr, i| 
      { 
        alternative: task.alternatives[i],
        sr: sr
      }
    end
    # сортируем по убыванию коэффичиента
    sum_of_ranges_with_alternative.sort! { |x, y| y[:sr] <=> x[:sr] }

    result = {}
    (1..task.alternatives.size).each do |r|
      result[r] = sum_of_ranges_with_alternative[r - 1][:alternative]
    end
    MathMethods::Solution.new(result, sum_of_ranges_with_alternative)
  end


  private

  attr_reader :task
  
  def normal_range(alternative, expert)
    (@task.ratings.get(expert, alternative) - @task.alternatives.size).abs
  end

end