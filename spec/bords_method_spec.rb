require "spec_helper"

RSpec.describe MathMethods::BordsMethod do

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
    result = MathMethods::BordsMethod.new(task).get_result
    expect(result.range).to eq({1=>:a3, 2=>:a2, 3=>:a4, 4=>:a1, 5=>:a5})
    expect(result.math_info).to eq(
      [
        {:alternative=>:a3, :sr=>2.4},
        {:alternative=>:a2, :sr=>2.2},
        {:alternative=>:a4, :sr=>2.1},
        {:alternative=>:a1, :sr=>2.0},
        {:alternative=>:a5, :sr=>1.3}
      ]
   )
  end

  it 'Production example' do
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
    result = MathMethods::BordsMethod.new(task).get_result
    expect(result.range).to eq({1=>:a3, 2=>:a4, 3=>:a2, 4=>:a5, 5=>:a1})
    expect(result.math_info).to eq(
      [
        {:alternative=>:a3, :sr=>3.79},
        {:alternative=>:a4, :sr=>2.82},
        {:alternative=>:a2, :sr=>2.03},
        {:alternative=>:a5, :sr=>0.98},
        {:alternative=>:a1, :sr=>0.09}
      ]
   )
  end
end
