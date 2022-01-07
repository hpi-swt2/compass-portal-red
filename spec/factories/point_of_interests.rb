FactoryBot.define do
  factory :point_of_interest do
    point { build :point }
    point_type { "point_of_interest" }
  end
end
