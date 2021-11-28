FactoryBot.define do
  factory :wall do
    points { [ (build :point), (build :point) ] }
  end
end
