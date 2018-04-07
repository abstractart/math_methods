require "spec_helper"

RSpec.describe MathMethods::NewSpectral do
  context "Production Example" do
    let (:task) {
      MathMethods::CardinalTask.new(
        [:a, :b], 
        [:e1, :e2, :e3, :e4, :e5, :e6, :e7], 
        [
          { expert: :e1, cf: 0.25 },
          { expert: :e2, cf: 0.23 }, 
          { expert: :e3, cf: 0.17 },
          { expert: :e4, cf: 0.15 },
          { expert: :e5, cf: 0.1 },
          { expert: :e6, cf: 0.05 },
          { expert: :e7, cf: 0.05 },
        ],
        [
          {
            expert: :e1,
            values: [
              { alternative: :a, rating: 8 },
              { alternative: :b, rating: 3 }
            ]
          },
          {
            expert: :e2,
            values: [
              { alternative: :a, rating: 8 },
              { alternative: :b, rating: 5 }
            ]
          },
          {
            expert: :e3,
            values: [
              { alternative: :a, rating: 8 },
              { alternative: :b, rating: 7 }
            ]
          },
          {
            expert: :e4,
            values: [
              { alternative: :a, rating: 8 },
              { alternative: :b, rating: 7 }
            ]
          },
          {
            expert: :e5,
            values: [
              { alternative: :a, rating: 8 },
              { alternative: :b, rating: 3 }
            ]
          },
          {
            expert: :e6,
            values: [
              { alternative: :a, rating: 7 },
              { alternative: :b, rating: 5 }
            ]
          },
          {
            expert: :e7,
            values: [
              { alternative: :a, rating: 9 },
              { alternative: :b, rating: 5 }
            ]
          }               
        ],
        [],
        10
      )
    }    

    it "Detection Treshold" do
      expect(MathMethods::NewSpectral.d_t(10)).to be_within(0.01).of(0.41)
    end
    
    it "Using Treshold" do
      expect(MathMethods::NewSpectral.u_t(10)).to be_within(0.01).of(0.78)
    end
    
    context "First Alternative" do      
      it "Production Example Coefficient Calculates" do
        result = MathMethods::NewSpectral.new(task).coef(:a)
        expect(result).to be_within(0.01).of(0.92)
      end

      it "Get Result Value" do
        expect(MathMethods::NewSpectral.new(task).average(:a)).to eq(8)      
      end
    end

    context "Second Alternative" do
      it "Production Example Coefficient Calculates" do
        result = MathMethods::NewSpectral.new(task).coef(:b)
        expect(result).to be_within(0.01).of(0.60)
      end

      it "Get Average Value" do
        expect(MathMethods::NewSpectral.new(task).average(:b)).to eq(4.94)      
      end

      it "Get Rejections Array" do
        solution = [
          {:expert=>:e1, :value=>7.76},
          {:expert=>:e2, :value=>0.261},
          {:expert=>:e3, :value=>12.118},
          {:expert=>:e4, :value=>13.733},
          {:expert=>:e5, :value=>19.4},
          {:expert=>:e6, :value=>1.2},
          {:expert=>:e7, :value=>1.2}
        ]
        expect(MathMethods::NewSpectral.new(task).weak_values(:b)).to eq(solution)      
      end

      it "Get Weak Expert" do
        expect(MathMethods::NewSpectral.new(task).weak_expert(:b)).to eq({expert: :e5, value: 19.4})      
      end
    end
  end
end
