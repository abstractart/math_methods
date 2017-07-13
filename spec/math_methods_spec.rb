require "spec_helper"

RSpec.describe MathMethods do
  it "has a version number" do
    expect(MathMethods::VERSION).not_to be nil
  end

  context "Normalize specs" do
    it "Normalize with equal competitions" do
      result = MathMethods.normalize_competitions([0.5, 0.5, 0.5, 0.5])
      expect(result).to eq([0.25, 0.25, 0.25, 0.25])
    end

    it "Normalize with different competitions" do
      global_competitions = [0.4, 0.3, 0.2, 0.1]
      result = MathMethods.normalize_competitions(global_competitions)
      result.each_with_index do |c, i|
        expect(c).to be_within(0.0001).of(global_competitions[i])
      end
    end

    it "always return array with sum of elements equals 1" do
      result = MathMethods.normalize_competitions([rand]*rand(10))
      expect(result.reduce(:+)).to be_within(0.0001).of(1)    
    end
  end
end
