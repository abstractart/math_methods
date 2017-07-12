require "spec_helper"

RSpec.describe MathMethods::Concordation do
  context "Totsenko book" do
    let(:c) {[0.2, 0.3, 0.5]}
    let(:r) {[
      [1, 2, 3, 4, 5],
      [5, 4, 3, 2, 1],
      [4, 3, 2, 1, 5]    
      ]} 

    it "Coefficient" do
      result = MathMethods::Concordation.get_coef(c, r)
      expect(result).to eq(0.26) #0.2375 in book
    end

    it "Using Treshold (strong)" do
      result = MathMethods::Concordation.get_using_treshold(5, 1)
      expect(result).to be_within(0.01).of(0.848)  
    end

    it "Using Treshold (weak)" do
      result = MathMethods::Concordation.get_using_treshold(5, 2)
      expect(result).to eq(0.575)
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
      result = MathMethods::Concordation.get_coef(c, r)
      expect(result).to eq(0.666) #0.667 in docs    
    end

    it "Detection Treshold" do
      result = MathMethods::Concordation.get_detection_treshold(5, 10)
      expect(result).to be_within(0.01).of(0.002)  
    end

    it "Using Treshold (strong)" do
      result = MathMethods::Concordation.get_using_treshold(5, 1)
      expect(result).to be_within(0.01).of(0.848)  
    end

    it "Using Treshold (weak)" do
      result = MathMethods::Concordation.get_using_treshold(5, 2)
      expect(result).to eq(0.575)
    end       
  end
end
