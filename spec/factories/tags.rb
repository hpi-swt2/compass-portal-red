FactoryBot.define do
  factory :tag do
    name { "ruhig" }
    trait :printer do
      name { "Drucker" }
    end
  end
end
