class MathMethods::Solution
  attr_reader :range
  attr_reader :math_info

  def initialize(range, math_info)
    @range     = range
    @math_info = math_info
  end
  
  def to_h
    {
      range: range,
      math_info: math_info
    }
  end
end
