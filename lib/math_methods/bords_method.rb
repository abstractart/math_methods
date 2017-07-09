module MathMethods::BordsMethod
  def self.get_result(experts_cmp,ranges)
    for i in 0...ranges.count
      for j in 0...ranges[0].count
        ranges[i][j] = (ranges[i][j]-ranges[0].count).abs
      end
    end
    sum_of_ranges = [0]*ranges[0].count

    for i in 0...ranges[0].count
      for j in 0...ranges.count
        sum_of_ranges[i]+=ranges[j][i]*experts_cmp[j]
      end
    end
    sum_of_ranges.map! {|x| x.round(3)}
  end
end
