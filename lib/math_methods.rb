require "math_methods/version"
require "math_methods/bords_method"
require "math_methods/concordation"
require "math_methods/new_spectral"
require "math_methods/ordinary_feedback"
require "math_methods/posteriori_competition"
require "math_methods/task_model"
require "math_methods/cardinal_task"
require "math_methods/ratings_collection"
require "math_methods/stats_collection"
require "math_methods/competitions_collection"
require "math_methods/solution"
require "math_methods/new_condorset"
require "math_methods/new_gulyanitzky"

module MathMethods
  def self.normalize_competitions(competitions)
    sum = competitions.reduce(:+)
    competitions.map {|c| c / sum}
  end
end
