FactoryBot.define do
  factory :room do
    house { "H" }
    number { "42" }
    floor { "E" }
    full_name { "H-E.42" }
  end
end
