class MathMethods::NewCondorset
  def initialize(task)
    @task = task
  end

  def get_result
    matr_of_equals = {}
    task.experts.each do |e|
      matr_of_equals[e] ||= {}
      
      task.alternatives.each do |a1|
        matr_of_equals[e][a1] ||= {}
        
        task.alternatives.each do |a2|
          if a1 == a2
            matr_of_equals[e][a1][a2] = 0
            next 
          end
          if task.ratings.get(e, a1) > task.ratings.get(e, a2)
            matr_of_equals[e][a1][a2] ||= - task.competitions.get_for(e)
          else
            matr_of_equals[e][a1][a2] ||= task.competitions.get_for(e)
          end
        end
      end
    end

    result_matr = {}
    task.alternatives.each do |a1|
      result_matr[a1] ||= {}
        
      task.alternatives.each do |a2|
        result_matr[a1][a2] = task.experts.map do |e| 
          matr_of_equals[e][a1][a2]
        end.reduce(:+).round(2)

        if result_matr[a1][a2] > 0
          result_matr[a1][a2] = 1
        elsif result_matr[a1][a2] < 0
          result_matr[a1][a2] = -1
        end
      end
    end
    strength_with_alternative = task.alternatives.map do |a|
      [a, result_matr[a].values.count { |e| e == 1 }]
    end
    strength_with_alternative.sort! {|a, b| b[1] <=> a[1]}
    result_range = {}

    current_range = 1
    strength_with_alternative.map { |s_a| s_a[1] }.uniq.each do |s|
      result_range[current_range] = strength_with_alternative.map {|s_a| s_a[0] if s_a[1] == s }.compact
      current_range += 1
    end

    MathMethods::Solution.new(result_range, result_matr)
  end

  private
  
  attr_reader :task
end