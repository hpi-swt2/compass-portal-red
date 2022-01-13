FactoryBot.define do
  factory :person do
    email { "michael.perscheid@hpi.de" }
    last_name { "Perscheid" }
    first_name { "Michael" }
    title { "Dr." }
    image { "https://www.shorturl.at/bmpxP" }
    status { "Chair Representative" }
  end
end
