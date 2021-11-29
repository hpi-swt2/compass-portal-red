FactoryBot.define do
  factory :room do
    outerShape do
      [(build :point),
       (build :point, x: -1.5),
       (build :point, x: -1.5, y: -1.5),
       (build :point, y: -1.5)]
    end
    walls { [(build :wall)] }
  end
end
