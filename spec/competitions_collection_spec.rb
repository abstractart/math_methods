require "spec_helper"

RSpec.describe MathMethods::CompetitionsCollection do
  it "Ratings Collection" do
    competitions = [
      { expert: :e1, cf: 0.35 },
      { expert: :e2, cf: 0.45 },
      { expert: :e3, cf: 0.2 }
    ]

    collection = MathMethods::CompetitionsCollection.new(competitions)

    expect(collection.competitions).to eq({ e1: 0.35, e2: 0.45, e3: 0.2 })
  end
end
