require "math_methods/version"
require "math_methods/bords_method"
require "math_methods/condorset"
require "math_methods/new_concordation"
require "math_methods/gulyanitzky"
require "math_methods/spectral"
require "math_methods/ordinary_feedback"
require "math_methods/posteriori_competition"

module MathMethods
  def self.normalize_competitions(competitions)
    sum = competitions.reduce(:+)
    competitions.map {|c| c / sum}
  end
end
