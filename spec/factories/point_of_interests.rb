FactoryBot.define do
  factory :point_of_interest do
    point { build :point }
    point_type { "point_of_interest" }
    # association :room, factory: :room
  end
end
