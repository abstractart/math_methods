require 'munkres'

class MathMethods::NewGulyanitzky
  def initialize(task)
    @task = task
  end

  def get_result
    matr = []

    task.alternatives.each do |a|
      row = []
      (1..task.alternatives.size).each do |i|
        current = 0.0

        task.experts.each do |e|
          temp = (task.ratings.get(e, a) - i).abs
          current += task.competitions.get_for(e) * temp
        end
        row << current.round(3)
      end
      matr << row
    end
    solution = Munkres.new(matr).find_pairings

    MathMethods::Solution.new(result_range(solution), { matr: matr, solution: solution })
  end

  private

  attr_reader :task

  def result_range(solution)
    result = {}
    solution.each do |pair|
      result[pair[1] + 1] = task.alternatives[pair[0]]
    end
    result
  end
end

