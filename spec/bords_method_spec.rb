require "spec_helper"

RSpec.describe MathMethods::BordsMethod do
  it "New bords" do
    ratings = [
      { alternative_id: 1, expert_id: 1, value: 1 },
      { alternative_id: 2, expert_id: 1, value: 2 },
      { alternative_id: 3, expert_id: 1, value: 3 },
      { alternative_id: 4, expert_id: 1, value: 4 },
      { alternative_id: 5, expert_id: 1, value: 5 },

      { alternative_id: 1, expert_id: 2, value: 5 },
      { alternative_id: 2, expert_id: 2, value: 4 },
      { alternative_id: 3, expert_id: 2, value: 3 },
      { alternative_id: 4, expert_id: 2, value: 2 },
      { alternative_id: 5, expert_id: 2, value: 1 },

      { alternative_id: 1, expert_id: 3, value: 4 },
      { alternative_id: 2, expert_id: 3, value: 3 },
      { alternative_id: 3, expert_id: 3, value: 2 },
      { alternative_id: 4, expert_id: 3, value: 1 },
      { alternative_id: 5, expert_id: 3, value: 5 },

      { alternative_id: 1, expert_id: 4, value: 3 },
      { alternative_id: 2, expert_id: 4, value: 2 },
      { alternative_id: 3, expert_id: 4, value: 1 },
      { alternative_id: 4, expert_id: 4, value: 5 },
      { alternative_id: 5, expert_id: 4, value: 4 },
    ]
    competitions = [
      { expert_id: 1, cf: 0.4 },
      { expert_id: 2, cf: 0.3 },
      { expert_id: 3, cf: 0.2 },
      { expert_id: 4, cf: 0.1 }
    ]
    task = MathMethods::TaskModel.new(
      {
        alternatives: [1, 2, 3, 4 , 5],
        experts:      [1, 2, 3, 4],
        competitions: competitions,
        ratings:      ratings
      }
    )
    binding.pry
  end

  it "Example from Totsenko" do
    c = [0.4, 0.3, 0.2, 0.1]
    r = 
    [
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5],
      [3, 2, 1, 5, 4]
    ]
    result = MathMethods::BordsMethod.get_result(c, r)
    expect(result).to eq([2, 2.2, 2.4, 2.1, 1.3])
  end

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
      
      [5, 3, 1,  2, 4],
      
      [5, 1, 2, 3, 4],
      [4, 3, 1, 2, 5],
      
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4],
      [5, 3, 1, 2, 4]
    ]
    result = MathMethods::BordsMethod.get_result(c, r)
    expect(result).to eq([0.092, 2.028, 3.786, 2.816, 0.978])    
  end
end
