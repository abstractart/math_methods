require "spec_helper"

RSpec.describe MathMethods::NewPosterioriCompetition do
  context "simple task" do
    it "works well" do
      experts = [:e1, :e2, :e3, :e4]
      alternatives = [:a1, :a2, :a3, :a4, :a5]
      competitions = 
      [
        { expert: :e1, cf: 0.4 },
        { expert: :e2, cf: 0.3 },
        { expert: :e3, cf: 0.2 },
        { expert: :e4, cf: 0.1 }
      ]
      ratings = 
      [
        {
          expert: :e1,
          values: [
            { alternative: :a1, rating: 1 },
            { alternative: :a2, rating: 2 },
            { alternative: :a3, rating: 3 },
            { alternative: :a4, rating: 4 },
            { alternative: :a5, rating: 5 }
          ]
        },
        {
          expert: :e2,
          values: [
            { alternative: :a1, rating: 5 },
            { alternative: :a2, rating: 4 },
            { alternative: :a3, rating: 3 },
            { alternative: :a4, rating: 2 },
            { alternative: :a5, rating: 1 }
          ]
        },
        {
          expert: :e3,
          values: [
            { alternative: :a1, rating: 4 },
            { alternative: :a2, rating: 3 },
            { alternative: :a3, rating: 2 },
            { alternative: :a4, rating: 1 },
            { alternative: :a5, rating: 5 }
          ]
        },
        {
          expert: :e4,
          values: [
            { alternative: :a1, rating: 3 },
            { alternative: :a2, rating: 2 },
            { alternative: :a3, rating: 1 },
            { alternative: :a4, rating: 5 },
            { alternative: :a5, rating: 4 }
          ]
        }           
      ]
      result_range = { 4 => :a1, 3 => :a2, 1 => :a3, 2 => :a4, 5 => :a5 }
      
      task = MathMethods::TaskModel.new(alternatives, experts, competitions, ratings)
      c = MathMethods::NewPosterioriCompetition.new(task, result_range, :ordinal)
      
      expect(c.get_new_coefficients).to eq({ e1: 0.3895, e2: 0.2909, e3: 0.2035, e4: 0.098 })
    end
  end
end