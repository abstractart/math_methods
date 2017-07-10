module MathMethods::Concordation
  def self.get_coef(experts,ranges)
    return (12*outer_sum(experts,ranges)/(ranges[0].count ** 3 - ranges[0].count)).round(3)
  end

  def self.get_detection_treshold(alt_count,exp_count)
    return (24.0/(exp_count ** 2 * (alt_count ** 3 - alt_count))).round(3)
  end

  def self.get_using_treshold(n,l)
    m = n-l+1 #experts count
    experts = [1.0/m]*m
    #binding.pry
    init_range = []
    for i in 1..n
      init_range << i
    end

    ranges = []
    ranges << init_range
    for i in 0...n-l
      range = init_range.clone

      tmp = range[i]
      range[i] = range[i+l]
      range[i+l] = tmp

      ranges << range
    end
    return (12*outer_sum(experts,ranges)/(ranges[0].count ** 3 - ranges[0].count)).round(3)
  end

  private

  def self.inner_sum(experts,ranges,outer_index)
    result = 0.0
    for i in 0...experts.count
      result += experts[i]*ranges[i][outer_index]
    end

    return result
  end

  def self.outer_sum(experts,ranges)
    result = 0.0
    alt_count = ranges[0].count

    for i in 0...alt_count
      result+= ((alt_count+1)/2-inner_sum(experts,ranges,i)) ** 2
    end

    return result
  end
end
