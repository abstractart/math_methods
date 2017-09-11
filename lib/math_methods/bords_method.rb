class MathMethods::BordsMethod
  def initialize(task)
    @task = task
  end

  def get_result
    ranges = @task.alternatives.map do |a|
      @task.experts.map do |e|
        normal_range(a, e) * @task.competitions.get_for(e)
      end
    end
    
    sum_of_ranges = ranges.map { |a| a.inject(:+).round(2) }
    sum_of_ranges_with_alternative = sum_of_ranges.map.with_index do |sr, i| 
      { 
        alternative_id: @task.alternatives[i],
        sr: sr
      }
    end

    # сортируем по убыванию коэффичиента
    sum_of_ranges_with_alternative.sort! { |x, y| y[:sr] <=> x[:sr] }
    # назначаем ранг
    sum_of_ranges_with_alternative.each_with_index { |entry, i| entry[:result_range] = i + 1 }
  end

  def normal_range(alternative, expert)
    (@task.ratings.get(alternative, expert) - @task.alternatives.size).abs
  end
end