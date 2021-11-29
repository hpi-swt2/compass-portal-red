FactoryBot.define do
  factory :room do
    outerShape {
      [(build :point),
       (build :point, x: -1.5),
       (build :point, x: -1.5, y: -1.5),
       (build :point, y: -1.5)]
    }
    walls { [(build :wall)] }
  end
end
