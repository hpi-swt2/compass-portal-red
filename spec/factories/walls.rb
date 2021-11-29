FactoryBot.define do
  factory :wall do
    points { [ (build :point), (build :point, x: -1.0) ] }
  end
end
