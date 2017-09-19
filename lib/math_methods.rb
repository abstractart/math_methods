require "math_methods/version"
require "math_methods/bords_method"
require "math_methods/new_concordation"
require "math_methods/gulyanitzky"
require "math_methods/spectral"
require "math_methods/ordinary_feedback"
require "math_methods/posteriori_competition"
require "math_methods/task_model"
require "math_methods/ratings_collection"
require "math_methods/competitions_collection"
require "math_methods/solution"
require "math_methods/new_condorset"

module MathMethods
  def self.normalize_competitions(competitions)
    sum = competitions.reduce(:+)
    competitions.map {|c| c / sum}
  end
end
