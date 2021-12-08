FactoryBot.define do
  factory :chair do
    people { [(build :person)] }
    name { "Enterprise Platform and Integration Concepts" }
  end
end
