FactoryBot.define do
  factory :data_problem do
    url { "www.hpi.de" }
    description { "some problem" }
    field { "email" }
    room { nil }
    person { nil }
  end
end
