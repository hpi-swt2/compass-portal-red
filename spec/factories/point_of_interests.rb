FactoryBot.define do
  factory :point_of_interest do
    point { build :point }
    type { "point_of_interest" }
    room { build :room }
  end
end
