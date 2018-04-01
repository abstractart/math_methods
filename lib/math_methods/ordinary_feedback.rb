class MathMethods::OrdinaryFeedback
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def get
    weak_expert = task.experts.first

    task.experts.each do |e|
      if task.stats.get_for(e)        <= task.stats.get_for(weak_expert) &&
         task.competitions.get_for(e) <= task.competitions.get_for(weak_expert)
         weak_expert = e
      end
    end

    weak_range = task.original_ratings.select {|h| h[:expert] == weak_expert}.first
    suggestions = MathMethods::Concordation.generate_ranges(weak_range[:values], 1)

    result = suggestions.map do |s|
      new_ratings = task.original_ratings.select {|h| h[:expert] != weak_expert}
      new_ratings << {
        expert: weak_expert,
        values: s
      }
      tmp_task = MathMethods::TaskModel.new(task.alternatives, task.experts, task.original_competitions, new_ratings)
      [s, MathMethods::Concordation.new(tmp_task).coef]
    end
    best = result.sort {|r1, r2| r2[1] <=> r1[1]}.first

    {
      expert: weak_expert,
      cf:     best.last,
      old_range:  weak_range
      new_range:  best.first
    } 
  end
end
