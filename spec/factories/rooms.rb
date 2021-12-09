FactoryBot.define do
  factory :room do
    number { "42" }
    floor { "E" }
    full_name { "H-E.42" }
    outer_shape do
      (build :polyline, points: [(build :point),
                                 (build :point, x: -1.5),
                                 (build :point, x: -1.5, y: -1.5),
                                 (build :point, y: -1.5),
                                 (build :point)])
    end
    walls { [(build :wall)] }
  end
end
