module MathMethods::Condorset
  def self.get_result(experts_cmp, ranges)
    for i in 0...ranges.count
      for j in 0...ranges[0].count
        ranges[i][j] = (ranges[i][j]-ranges[0].count).abs
      end
    end
    matr_of_equals = Array.new(ranges[0].count) { 
      Array.new(ranges[0].count) {
        Array.new(ranges.count, 0) 
      }
    }

    for j in 0...experts_cmp.count
      for i in 0...ranges[0].count - 1
        k = i
        for h in k...ranges[0].count
          if i == h
            matr_of_equals[i][h][j] = 0
            next
          end
          if ranges[j][i] > ranges[j][h]
            matr_of_equals[i][h][j] = experts_cmp[j]
            matr_of_equals[h][i][j] = -experts_cmp[j]
          else
            matr_of_equals[i][h][j] = -experts_cmp[j]
            matr_of_equals[h][i][j] = experts_cmp[j]
          end
        end
      end
    end

    result_matr = Array.new(ranges[0].count) {Array.new(ranges[0].count,0)}
    for i in 0...ranges[0].count
      for h in 0...ranges[0].count
        for j in 0...experts_cmp.count
          result_matr[i][h] += matr_of_equals[i][h][j];
        end
      end
    end
    for i in 0...ranges[0].count
      for j in 0...ranges[0].count
      result_matr[i][j] = result_matr[i][j].round(3)
        if result_matr[i][j] > 0
          result_matr[i][j] = 1
        elsif result_matr[i][j] < 0
          result_matr[i][j] = -1
        end
      end
    end
    result_answer = []
    result_matr.each do |row|
      result_answer << row.count {|x| x > 0}
    end
    result_answer
  end
end
