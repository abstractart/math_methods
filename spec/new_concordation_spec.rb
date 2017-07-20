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

    it "Using Treshold weak(function)" do
      result = MathMethods::NewConcordation.get_using_treshold(5, 2)
      expect(result).to eq(0.575)
    end

    it "Using Treshold strong(function)" do
      result = MathMethods::NewConcordation.get_using_treshold(5, 1)
      expect(result).to be_within(0.01).of(0.848)
    end
  end
  context "Production Example" do
    let(:c) {[
        0.13, 0.12, 0.11, 0.1, 0.1, 
        0.094, 0.092, 0.08, 0.079, 0.065
      ]}
    let(:r) {[
        [5, 3, 1, 2, 4],
        [5, 2, 1, 3, 4],
        [5, 2, 1, 3, 4],
        
        [5, 4, 2, 1, 3],
        
        [5, 3, 1,  2, 4],
        
        [5, 1, 4, 3, 2],
        [4, 2, 1, 3, 5],
        
        [5, 1, 3, 2, 4],
        [5, 2, 1, 3, 4],
        [5, 3, 2, 1, 4]
      ]}   
    it "Coefficient value" do
      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to be_within(0.001).of(0.667)
    end

    it "Feedback" do
      result = MathMethods::OrdinaryFeedback.new(
        competitions: c, 
        ranges: r, 
        expert_stats: [0,0,0,0,0,0,0,0,0,0]).generate_request
      
      expect(result[:expert_index]).to eq(9)
      expect(result[:competition]).to eq(0.065)
      expect(result[:best_range]).to eq([5, 3, 1, 2, 4])
      expect(result[:new_cf]).to eq(0.676091)
    end
  end
    
  context "Testing coef values in different situations" do
    it "Coef equals 1 with same ranges(6 alternatives, 4 experts)" do
      c = [0.2, 0.3, 0.4, 0.1]
      r = [
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6]    
      ]

      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to be_within(0.01).of(1)
    end 
    
    it "Coef equals 1 with same ranges(4 alternatives, 4 experts)" do
      c = [0.2, 0.3, 0.4, 0.1]
      r = [
            [1, 2, 3, 4],
            [1, 2, 3, 4],
            [1, 2, 3, 4],
            [1, 2, 3, 4]    
      ]

      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to be_within(0.01).of(1)
    end

    it "Coef equals 1 with same ranges(6 alternatives, 6 experts)" do
      c = [0.15, 0.15, 0.15, 0.15, 0.2, 0.2]
      r = [
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],
            [1, 2, 3, 4, 5, 6],                        
            [1, 2, 3, 4, 5, 6]    
      ]

      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to be_within(0.01).of(1)
    end

    it "Coef equals 1 with same ranges(5 alternatives, 4 experts)" do
      c = [0.15, 0.15, 0.35, 0.35]
      r = [
            [1, 2, 3, 4, 5],
            [1, 2, 3, 4, 5],
            [1, 2, 3, 4, 5],
            [1, 2, 3, 4, 5] 
      ]

      result = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef
      expect(result).to be_within(0.01).of(1)
    end
    it "Coef equals 1 with same ranges(5 alternatives, 10 experts)" do
      experts_range = 3..10
      alternatives_range = 3..10

      results_hash = {}
      for e in experts_range
        results_hash[e] ||= {}
        for a in alternatives_range
          results_hash[e][a] ||= {}
          c = [1.0 / e] * e
          r = [(1..a).to_a] * e
          results_hash[e][a] = MathMethods::NewConcordation.new(competitions: c, ranges: r).get_coef.round(3)
        end
      end
      #binding.pry
      expect(results_hash).to eq({})
    end
  end
end
