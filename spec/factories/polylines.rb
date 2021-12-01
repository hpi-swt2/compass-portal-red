FactoryBot.define do
  factory :polyline do
    points { [ (build :point), (build :point, x: -1.0) ] }
  end
end
