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
    tags do
      [(FactoryBot.create :tag), (FactoryBot.create :tag, :printer)]
    end
    room_types { [(build :room_type, name: "lecture hall")] }
    chairs { [(build :chair, name: "EPIC")] }
    walls { [(build :wall)] }
    people { [(build :person, first_name: "Michael", last_name: "Perscheid")] }
  end
end
