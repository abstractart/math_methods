require "spec_helper"

RSpec.describe MathMethods::NewGulyanitzky do
  it "Production Example" do
    e = [:e1, :e2, :e3, :e4, :e5, :e6, :e7, :e8, :e9, :e10]
    c = 
    [
      { 
        expert: :e1,
        cf: 0.13
      },
      { 
        expert: :e2,
        cf: 0.12
      },
      { 
        expert: :e3,
        cf: 0.11
      },
      { 
        expert: :e4,
        cf: 0.1
      },
      { 
        expert: :e5,
        cf: 0.1
      },
      { 
        expert: :e6,
        cf: 0.094
      },
      { 
        expert: :e7,
        cf: 0.092
      },
      { 
        expert: :e8,
        cf: 0.08
      },
      { 
        expert: :e9,
        cf: 0.079
      },
      { 
        expert: :e10,
        cf: 0.065
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
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
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
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      },
      {
        expert: :e3,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      },
      {
        expert: :e4,
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
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 3
          }
        ]                   
      },
      {
        expert: :e5,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]                   
      },
      {
        expert: :e6,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 1
          },
          {
            alternative: :a3,
            rating: 2
          },
          {
            alternative: :a4,
            rating: 3
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]                     
      },
      {
        expert: :e7,
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
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 5
          }
        ]
      },
      {
        expert: :e8,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      },
      {
        expert: :e9,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      },
      {
        expert: :e10,
        values: [
          {
            alternative: :a1,
            rating: 5
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 2
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      }                          
    ]
    task = MathMethods::TaskModel.new(a, e, c, r)
    result = MathMethods::NewGulyanitzky.new(task).get_result
    expect(result).to eq([[0, 4], [1, 2], [2, 0], [3, 1], [4, 3]])    
  end
end
