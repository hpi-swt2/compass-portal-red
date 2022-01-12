FactoryBot.define do
  factory :floor do
    name { "Example Floor" }
    building { build :building }
    rooms do
      []
      # [(build :room),
      #  (build :room,
      #         point_of_interests:
      #           [(build :point_of_interest),
      #            (build :point_of_interest, point: (build :point, x: -8.3))])]
    end
  end
end
