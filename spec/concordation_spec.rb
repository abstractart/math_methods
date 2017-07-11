require "spec_helper"

RSpec.describe MathMethods::Concordation do
  it "Example from Totsenko" do
    c = [0.2, 0.3, 0.5]
    r = 
    [
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5]    
    ]
    result = MathMethods::Concordation.get_coef(c, r)
    expect(result).to eq(0.26) #0.2375 in book
  end

  it "Equals one with same answers" do
    c = [0.2, 0.3, 0.5]
    r = 
    [
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4, 5]    
    ]
    result = MathMethods::Concordation.get_coef(c, r)
    expect(result).to eq(1.00)
  end

  it "Production Example" do
    c = [
      0.13, 0.12, 0.11, 0.1, 0.1, 
      0.094, 0.092, 0.08, 0.079, 0.065
    ]
    r = 
    [
      [5, 3, 1, 2, 4],
      [5, 2, 1, 3, 4],
      [5, 2, 1, 3, 4],
      
      [5, 4, 2, 1, 3],
      
      [5, 3, 1,  2, 4],
      
      [5, 1, 4, 3, 2],
      [4, 2, 1, 3, 5],
      
      [5, 1, 3, 2, 4],
      [5, 2, 1, 3, 4],
      [5, 3, 2, 1, 4]
    ]
    result = MathMethods::Concordation.get_coef(c, r)
    expect(result).to eq(0.666) #0.667 in docs    
  end
end
