require "spec_helper"

RSpec.describe MathMethods::RatingsCollection do
  it "Ratings Collection" do
    ratings = [
      {alternative_id: 1, expert_id: 1, value: 1 },
      {alternative_id: 2, expert_id: 1, value: 2 },
      {alternative_id: 3, expert_id: 1, value: 3 },
      
      {alternative_id: 1, expert_id: 2, value: 1 },
      {alternative_id: 2, expert_id: 2, value: 2 },
      {alternative_id: 3, expert_id: 2, value: 3 },
      
      {alternative_id: 1, expert_id: 3, value: 1 },
      {alternative_id: 2, expert_id: 3, value: 2 },
      {alternative_id: 3, expert_id: 3, value: 3 },
    ]
    collection = MathMethods::RatingsCollection.new(ratings)
    expect(collection.ratings).to eq(
      { 1 => {1 => 1, 2 => 1, 3 => 1}, 
        2 => {1 => 2, 2 => 2, 3 => 2},
        3 => {1 => 3, 2 => 3, 3 => 3}
      })
  end
end
