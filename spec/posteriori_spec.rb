require "spec_helper"

RSpec.describe MathMethods::PosterioriCompetition do

context "simple task"  
  let(:r) {
    [
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5],
      [3, 2, 1, 5, 4]
    ]
  }
  let(:a) { [4, 3, 1, 2, 5] }

  skip "works well" do
    c = [0.4, 0.3, 0.2, 0.1]

    100.times do
      c = MathMethods::PosterioriCompetition.new(
        competitions: c, 
        ranges: r, 
        result_range: a, 
        task_type: :ordinal).get_new_coefficients
        #binding.pry
    end
    expect(c).to eq([2, 2.2, 2.4, 2.1, 1.3])
  end
end