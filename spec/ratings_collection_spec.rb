require "spec_helper"

RSpec.describe MathMethods::RatingsCollection do
  it "Ratings Collection" do
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
          }
        ]                                        
      },
      {
        expert: :e2,
        values: [
          {
            alternative: :a1,
            rating: 2
          },
          {
            alternative: :a2,
            rating: 3
          },
          {
            alternative: :a3,
            rating: 1
          }
        ]
      },
      {
        expert: :e3,
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
          }
        ]
      },
    ]
    collection = MathMethods::RatingsCollection.new(r)
    expect(collection.ratings).to eq(
      { e1: { a1: 1, a2: 2, a3: 3 }, 
        e2: { a1: 2, a2: 3, a3: 1 },
        e3: { a1: 3, a2: 2, a3: 1 }
      }
    )
  end
end
