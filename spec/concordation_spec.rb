require "spec_helper"

RSpec.describe MathMethods::Concordation do
  context "Totsenko book" do
    let (:task) {
      MathMethods::TaskModel.new(
        [:a, :b, :c, :d, :e], 
        [:e1, :e2, :e3], 
        [
          { expert: :e1, cf: 0.2 },
          { expert: :e2, cf: 0.3 }, 
          { expert: :e3, cf: 0.5 }
        ],
        [
          {
            expert: :e1,
            values: [
              { alternative: :a, rating: 1 },
              { alternative: :b, rating: 2 },
              { alternative: :c, rating: 3 },
              { alternative: :d, rating: 4 },
              { alternative: :e, rating: 5 }
            ]
          },
          {
            expert: :e2,
            values: [
              { alternative: :a, rating: 5 },
              { alternative: :b, rating: 4 },
              { alternative: :c, rating: 3 },
              { alternative: :d, rating: 2 },
              { alternative: :e, rating: 1 }
            ]
          },
          {
            expert: :e3,
            values: [
              { alternative: :a, rating: 4 },
              { alternative: :b, rating: 3 },
              { alternative: :c, rating: 2 },
              { alternative: :d, rating: 1 },
              { alternative: :e, rating: 5 }
            ]
          }                   
        ]
      )
    }
    it "Coefficient" do
      expect(MathMethods::Concordation.new(task).coef).to eq(0.26) #0.2375 in book
    end

    it "Detection treshold" do
      result = MathMethods::Concordation.d_t(5, 3)
      expect(result).to be_within(0.01).of(0.02)
    end

    it "Using treshold(strong)" do
      result = MathMethods::Concordation.u_t(5, 1)
      expect(result).to be_within(0.01).of(0.848)
    end

    it "Using treshold(weak)" do
      result = MathMethods::Concordation.u_t(5, 2)
      expect(result).to be_within(0.01).of(0.575)
    end
  end

  context 'Production example' do
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
            rating: 2
          },
          {
            alternative: :a3,
            rating: 1
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
        expert: :e3,
        values: [
          {
            alternative: :a1,
            rating: 5
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
            rating: 3
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
            rating: 2
          },
          {
            alternative: :a4,
            rating: 1
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
            rating: 4
          },
          {
            alternative: :a4,
            rating: 3
          },
          {
            alternative: :a5,
            rating: 2
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
            rating: 2
          },
          {
            alternative: :a3,
            rating: 1
          },
          {
            alternative: :a4,
            rating: 3
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
            rating: 1
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
            rating: 2
          },
          {
            alternative: :a3,
            rating: 1
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
            rating: 2
          },
          {
            alternative: :a4,
            rating: 1
          },
          {
            alternative: :a5,
            rating: 4
          }
        ]
      } 
    ]
    s = e.map { |expert| { expert: expert, count_of_changes: 0 } }

    it 'Coefficient' do
      task = MathMethods::TaskModel.new(a, e, c, r)
      expect(MathMethods::Concordation.new(task).coef).to be_within(0.001).of(0.667)
    end

    it 'Feedback' do
      task = MathMethods::TaskModel.new(a, e, c, r, s)
      result = 
      {
        expert: :e10,
        cf: 0.676091,
        old_range: [
          {alternative: :a1, rating: 5},
          {alternative: :a2, rating: 3},
          {alternative: :a3, rating: 2},
          {alternative: :a4, rating: 1},
          {alternative: :a5, rating: 4}],
        new_range: [
          {alternative: :a1, rating: 5}, 
          {alternative: :a2, rating: 3}, 
          {alternative: :a4, rating: 2}, 
          {alternative: :a3, rating: 1}, 
          {alternative: :a5, rating: 4}]
      }
      expect(MathMethods::OrdinaryFeedback.new(task).get).to eq(result)
    end
  end
end
