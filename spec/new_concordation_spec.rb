require "spec_helper"

RSpec.describe MathMethods::NewConcordation do
  context "Totsenko book" do
    let(:c) {[0.2, 0.3, 0.5]}
    let(:r) {[
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5]    
      ]} 

    it "Coefficient" do
      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to eq(0.26) #0.2375 in book
    end
  end
end