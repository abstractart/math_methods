class MathMethods::NewConcordation
  attr_reader :competitions
  attr_reader :ranges
  attr_reader :alt_count
  attr_reader :exp_count
  
  def initialize(args)
    @competitions = args[:competitions]
    @ranges = args[:ranges]
    @exp_count = @competitions.length
    @alt_count = @ranges[0].length  
  end

  def get_coef
    12 * outer_sum / denominator
  end

  def self.get_detection_treshold(alt_count, exp_count)
    return (24.0/(exp_count**2 * denominator(alt_count)))
  end

  def self.get_using_treshold(alt_count, l)
    init_range = (1..alt_count).to_a.shuffle
    new_ranges = get_new_ranges(init_range, l) << init_range
    exp_count = (alt_count + 1 - l)
    competitions = [1.0/exp_count]*exp_count

    MathMethods::NewConcordation.new(competitions: competitions, ranges: new_ranges).get_coef
  end

  def self.get_new_ranges(init_range, l)
    (1..init_range.length-l).to_a.map do |r|
      tmp = init_range.clone
      first_alternative = tmp.index(r)
      second_alternative = tmp.index(r + l)

      temp_for_swap = tmp[first_alternative]
      tmp[first_alternative] = tmp[second_alternative]
      tmp[second_alternative] = temp_for_swap

      tmp
    end
  end
  
  private

  def denominator
    alt_count ** 3 - alt_count
  end

  def inner_sum(outer_index)
    elements = (0...exp_count).to_a.map do |inner_index|
      inner_sum_element(outer_index, inner_index)
    end
    elements.reduce(:+)
  end

  def inner_sum_element(outer_index, inner_index)
    competitions[inner_index]*ranges[inner_index][outer_index]
  end

  def outer_sum
    elements = (0...alt_count).to_a.map do |outer_index|
      outer_sum_element(outer_index)
    end
    elements.reduce(:+)
  end
  
  def outer_sum_element(outer_index)
    ((alt_count + 1.0) / 2.0 - inner_sum(outer_index))**2
  end
end
