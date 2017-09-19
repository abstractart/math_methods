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
    Munkres.new(matr).find_pairings
  end

  private

  attr_reader :task
end

