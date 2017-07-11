require "spec_helper"

RSpec.describe MathMethods::Gulyanitzky do
  it "Production Example" do
    c = [
      0.13, 0.12, 0.11, 0.1, 0.1, 
      0.094, 0.092, 0.08, 0.079, 0.065
    ]
    r = 
    [
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4],
      
      [5, 4, 1, 2, 3],
      
      [5, 3, 1, 2, 4],
      
      [5, 1, 2, 3, 4],
      [4, 3, 1, 2, 5],
      
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4]
    ]
    result = MathMethods::Gulyanitzky.get_result(c, r)
    expect(result).to eq([[0, 4], [1, 2], [2, 0], [3, 1], [4, 3]])    
  end
end
