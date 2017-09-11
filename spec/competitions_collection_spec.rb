require "spec_helper"

RSpec.describe MathMethods::CompetitionsCollection do
  it "Ratings Collection" do
    competitions = [
      { expert_id: 1, cf: 0.35 },
      { expert_id: 2, cf: 0.45 },
      { expert_id: 3, cf: 0.2 }
    ]

    collection = MathMethods::CompetitionsCollection.new(competitions)

    expect(collection.competitions).to eq({ 1 => 0.35, 2 => 0.45, 3 => 0.2 })
  end
end
