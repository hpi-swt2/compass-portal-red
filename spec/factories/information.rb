FactoryBot.define do
  factory :information do
    key { "Telegram" }
    value { "@hpi" }
    association :person, factory: :person
  end
end
