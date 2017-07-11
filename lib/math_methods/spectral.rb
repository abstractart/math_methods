module MathMethods::Spectral
  def self.get_coef(number_of_div, values, experts_cmp)
    sum_of_comp = Array.new(number_of_div, 0)
    for i in 0...experts_cmp.count
      sum_of_comp[values[i]-1]+=experts_cmp[i]
    end

    result = 1 - (outer_sum(sum_of_comp) - sum_with_ln(sum_of_comp))/(func_g(experts_cmp.count,number_of_div)*denominator(number_of_div)+Math.log(number_of_div))
    result
  end

  def self.get_detection_treshold(div_count)
    init_values = [*1..div_count]
    init_values[0] = (0.5*div_count+1).to_i
    experts_cmp =[1.0/div_count]*div_count

    get_coef(div_count,init_values,experts_cmp)

  end

  def self.get_using_treshold(number_of_div)
    get_coef(number_of_div,[2,3],[0.5,0.5])
  end

  def self.get_rejection(average,current,comp)
    (average - current).abs/comp
  end

  def self.get_average(experts_cmp,values)
    result = 0.0
    experts_cmp.each_index do |i|
      result+= experts_cmp[i]*values[i]
    end
    result
  end

  private

  def self.func_g(experts_count,div_count)
    experts_count/(Math.log(experts_count)*Math.log(div_count)*div_count)
  end

  def self.inner_sum(sum_of_comp)
    result = 0.0
    for i in 1..sum_of_comp.length
      result+= i * sum_of_comp[i-1]
    end
    result
  end

  def self.outer_sum(sum_of_comp)
    result = 0.0
    inner_sum_value = inner_sum(sum_of_comp)
    for i in 1..sum_of_comp.length
      result+= sum_of_comp[i-1]*(i - inner_sum_value).abs
    end
    result
  end

  def self.sum_with_ln(sum_of_comp)
    result = 0.0
    for i in 0...sum_of_comp.length
      if sum_of_comp[i] == 0.0
        next
      else
        result += sum_of_comp[i] * Math.log(sum_of_comp[i]);
      end
    end
    result
  end

  def self.denominator(div_count)
    result = 0.0

    for i in 1..div_count
      result+=(i -(div_count+1)/2).abs
    end
    result
  end

end
