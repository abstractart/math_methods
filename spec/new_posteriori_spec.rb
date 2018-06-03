require "spec_helper"

RSpec.describe MathMethods::NewPosterioriCompetition do
  context "ordinal task" do
    it "works well" do
      experts = [:e1, :e2, :e3, :e4]
      alternatives = [:a1, :a2, :a3, :a4, :a5]
      competitions =
      [
        { expert: :e1, cf: 0.4 },
        { expert: :e2, cf: 0.3 },
        { expert: :e3, cf: 0.2 },
        { expert: :e4, cf: 0.1 }
      ]
      ratings =
      [
        {
          expert: :e1,
          values: [
            { alternative: :a1, rating: 1 },
            { alternative: :a2, rating: 2 },
            { alternative: :a3, rating: 3 },
            { alternative: :a4, rating: 4 },
            { alternative: :a5, rating: 5 }
          ]
        },
        {
          expert: :e2,
          values: [
            { alternative: :a1, rating: 5 },
            { alternative: :a2, rating: 4 },
            { alternative: :a3, rating: 3 },
            { alternative: :a4, rating: 2 },
            { alternative: :a5, rating: 1 }
          ]
        },
        {
          expert: :e3,
          values: [
            { alternative: :a1, rating: 4 },
            { alternative: :a2, rating: 3 },
            { alternative: :a3, rating: 2 },
            { alternative: :a4, rating: 1 },
            { alternative: :a5, rating: 5 }
          ]
        },
        {
          expert: :e4,
          values: [
            { alternative: :a1, rating: 3 },
            { alternative: :a2, rating: 2 },
            { alternative: :a3, rating: 1 },
            { alternative: :a4, rating: 5 },
            { alternative: :a5, rating: 4 }
          ]
        }
      ]
      result_range = { 4 => :a1, 3 => :a2, 1 => :a3, 2 => :a4, 5 => :a5 }

      task = MathMethods::TaskModel.new(alternatives, experts, competitions, ratings)
      c = MathMethods::NewPosterioriCompetition.new(task, result_range, :ordinal)

      expect(c.get_new_coefficients).to eq({ e1: 0.3895, e2: 0.2909, e3: 0.2035, e4: 0.098 })
    end

    it "works well with soft ranges" do
      e = [:e1, :e2, :e3, :e4]

      c =
      [
        {
          expert: :e1,
          cf: 0.4
        },
        {
          expert: :e2,
          cf: 0.3
        },
        {
          expert: :e3,
          cf: 0.2
        },
        {
          expert: :e4,
          cf: 0.1
        }
      ]

      a = [:a1, :a2, :a3, :a4, :a5]

      r =
      [
        {
          expert: :e1,
          values: [
            {
              alternative: :a1,
              rating: 1
            },
            {
              alternative: :a2,
              rating: 2
            },
            {
              alternative: :a3,
              rating: 3
            },
            {
              alternative: :a4,
              rating: 4
            },
            {
              alternative: :a5,
              rating: 5
            }
          ]
        },
        {
          expert: :e2,
          values: [
            {
              alternative: :a1,
              rating: 5
            },
            {
              alternative: :a2,
              rating: 4
            },
            {
              alternative: :a3,
              rating: 3
            },
            {
              alternative: :a4,
              rating: 2
            },
            {
              alternative: :a5,
              rating: 1
            }
          ]
        },
        {
          expert: :e3,
          values: [
            {
              alternative: :a1,
              rating: 4
            },
            {
              alternative: :a2,
              rating: 3
            },
            {
              alternative: :a3,
              rating: 2
            },
            {
              alternative: :a4,
              rating: 1
            },
            {
              alternative: :a5,
              rating: 5
            }
          ]
        },
        {
          expert: :e4,
          values: [
            {
              alternative: :a1,
              rating: 3
            },
            {
              alternative: :a2,
              rating: 2
            },
            {
              alternative: :a3,
              rating: 1
            },
            {
              alternative: :a4,
              rating: 5
            },
            {
              alternative: :a5,
              rating: 4
            }
          ]
        }
      ]
      result_range = {1=>[:a3], 2=>[:a2], 3=>[:a1, :a4], 4=>[:a5]}

      task = MathMethods::TaskModel.new(a, e, c, r)
      c = MathMethods::NewPosterioriCompetition.new(task, result_range, :ordinal)

      expect(c.get_new_coefficients).to eq({ e1: 0.3979, e2: 0.2909, e3: 0.1986, e4: 0.1024 })
    end
  end

  context 'cardinal task' do
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

    it 'simple task' do
      result_range = {8 => :a, 4.94 => :b}

      c = MathMethods::NewPosterioriCompetition.new(task, result_range, :cardinal)

      expect(c.get_new_coefficients).to eq(
        {
          :e1 => 0.2428,
          :e2 => 0.2374,
          :e3 => 0.1639,
          :e4 => 0.1445,
          :e5 => 0.0966,
          :e6 => 0.0501,
          :e7 => 0.0501
        }
      )

    end

    it 'loop (for debug only)', skip: true do
      competitions = [
        { expert: :e1, cf: 0.25 },
        { expert: :e2, cf: 0.23 },
        { expert: :e3, cf: 0.17 },
        { expert: :e4, cf: 0.15 },
        { expert: :e5, cf: 0.1 },
        { expert: :e6, cf: 0.05 },
        { expert: :e7, cf: 0.05 },
      ]
      result_range = {8 => :a, 4.94 => :b}

      1000.times do
        task = MathMethods::CardinalTask.new(
          alternatives,
          experts,
          competitions,
          ratings,
          [],
          10
        )

        c = MathMethods::NewPosterioriCompetition.new(task, result_range, :cardinal)
        competitions = c.get_new_coefficients.to_a.map do |cmp|
          {expert: cmp.first, cf: cmp.last}
        end
      end

      expect(competitions).to eq(
        {
          :e1 => 0.2428,
          :e2 => 0.2374,
          :e3 => 0.1639,
          :e4 => 0.1445,
          :e5 => 0.0966,
          :e6 => 0.0501,
          :e7 => 0.0501
        }
      )

    end
  end
end