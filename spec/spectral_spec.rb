require "spec_helper"

RSpec.describe MathMethods::Spectral do
  context "Production Example" do
    let(:c) { [0.25, 0.23, 0.17, 0.15, 0.1, 0.05, 0.05]}
    
    context "First Alternative" do
      let(:v) { [8, 8, 8, 8, 8, 7, 9] }
      
      it "Production Example Coefficient Calculates" do
        result = MathMethods::Spectral.get_coef(10, v, c)
        expect(result).to be_within(0.01).of(0.92)
      end

      it "Production Example Detection Treshold" do
        expect(MathMethods::Spectral.get_detection_treshold(10)).to be_within(0.01).of(0.41)
      end

      it "Production Example Using Treshold" do
        expect(MathMethods::Spectral.get_using_treshold(10)).to be_within(0.01).of(0.78)
      end

      it "Get Result Value" do
        expect(MathMethods::Spectral.get_average(c, v)).to eq(8)      
      end
    end
  end
end
