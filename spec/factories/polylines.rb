FactoryBot.define do
  factory :polyline do
    points { [ (build :point), (build :point, x: -1.0), (build :point, x: -1.0, y: -1.0), (build :point) ] }
  end
end
