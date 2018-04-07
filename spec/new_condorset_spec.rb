require "spec_helper"

RSpec.describe MathMethods::NewCondorset do
it "Example from Totsenko" do
    e = [:e1, :e2, :e3, :e4]
    
    c = 
    [
      { 
        expert: :e1,
        cf: 0.4
      },
      { 
        expert: :e2,
        cf: 0.3
      },
      { 
        expert: :e3,
        cf: 0.2
      },
      { 
        expert: :e4,
        cf: 0.1
      }
    ]

    a = [:a1, :a2, :a3, :a4, :a5]

    r = 
    [
      {
        expert: :e1,
        values: [
          {
            alternative: :a1,
            rating: 1
          },
          {
            alternative: :a2,
            rating: 2
          },
          {
            alternative: :a3,
            rating: 3
          },
          {
            alternative: :a4,
            rating: 4
          },
          {
            alternative: :a5,
            rating: 5
          }
        ]
      },
      {
        expert: :e2,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 4
          },
          {
            alternative: :a3,
            rating: 3
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 1
          }
        ]
      },
      {
        expert: :e3,
        values: [
          {
            alternative: :a1,
            rating: 4
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 2
          },
          {
            alternative: :a4,
            rating: 1
          },
          {
            alternative: :a5,
            rating: 5
          }
        ]
      },
      {
        expert: :e4,
        values: [
          {
            alternative: :a1,
            rating: 3
          },
          {
            alternative: :a2,
            rating: 2
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 5
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]                     
      }
    ]
    
    task = MathMethods::TaskModel.new(a, e, c, r)
    result = MathMethods::NewCondorset.new(task).get_result
    expect(result.range).to eq({1=>[:a3], 2=>[:a2], 3=>[:a1, :a4], 4=>[:a5]})
  end
end
