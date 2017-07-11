require 'munkres'

module MathMethods::Gulyanitzky
  def self.get_result(experts_cmp,ranges)
    result_matr=[]

    for k in 1..ranges[0].count
    	result_row = []
    	for i in 1..ranges[0].count
    	  temp = 0.0
    	  for j in 0...experts_cmp.count
    	    temp+=experts_cmp[j]*(ranges[j][k-1]-i).abs
    	  end
    		temp = temp.round(3)
    		result_row << temp
    	end
    	result_matr << result_row
    end
    m = Munkres.new(result_matr)
    result =  m.find_pairings
    result.each_index do |row|
    end 
  end
end
