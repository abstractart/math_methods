require "spec_helper"

RSpec.describe MathMethods::Spectral do
  context "Production Example" do
    let(:c) { [0.25, 0.23, 0.17, 0.15, 0.1, 0.05, 0.05]}
    
    it "Detection Treshold" do
      expect(MathMethods::Spectral.get_detection_treshold(10)).to be_within(0.01).of(0.41)
    end

    it "Using Treshold" do
      expect(MathMethods::Spectral.get_using_treshold(10)).to be_within(0.01).of(0.78)
    end   
    
    context "First Alternative" do
      let(:v) { [8, 8, 8, 8, 8, 7, 9] }
      
      it "Production Example Coefficient Calculates" do
        result = MathMethods::Spectral.get_coef(10, v, c)
        expect(result).to be_within(0.01).of(0.92)
      end

      it "Get Result Value" do
        expect(MathMethods::Spectral.get_average(c, v)).to eq(8)      
      end
    end

    context "Second Alternative" do
      let(:v) { [3, 5, 7, 7, 3, 5, 5] }
      it "Production Example Coefficient Calculates" do
        result = MathMethods::Spectral.get_coef(10, v, c)
        expect(result).to be_within(0.01).of(0.60)
      end

      it "Get Average Value" do
        expect(MathMethods::Spectral.get_average(c, v)).to eq(4.94)      
      end

      it "Get Rejections Array" do
        expect(MathMethods::Spectral.get_weak_value(c, v)).to eq([7.76, 0.261, 12.118, 13.733, 19.4, 1.2, 1.2])      
      end

      it "Get Weak Expert" do
        expect(MathMethods::Spectral.get_weak_expert(c, v)).to eq([19.4, 4])      
      end
    end
  end
end
