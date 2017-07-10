require "spec_helper"

RSpec.describe MathMethods::Condorset do
  it "Example from Totsenko" do
    c = [0.4, 0.3, 0.2, 0.1]
    r = 
    [
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5],
      [3, 2, 1, 5, 4]
    ]
    result = MathMethods::Condorset.get_result(c, r)
    expect(result).to eq([1, 2, 3, 1, 0])
  end
end
