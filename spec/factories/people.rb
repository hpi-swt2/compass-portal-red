FactoryBot.define do
  factory :person do
    email { "michael.perscheid@hpi.de" }
    last_name { "Perscheid" }
    first_name { "Michael" }
    title { "Dr." }
    status { "Chair Representative" }

    after(:build) do |person|
      person.image.attach(
        io: File.open("spec/fixture_files/placeholder_person.png"),
        filename: 'test.png',
        content_type: 'image/png'
      )
    end
  end
end
