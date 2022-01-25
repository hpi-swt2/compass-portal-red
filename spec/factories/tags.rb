FactoryBot.define do
  factory :tag do
    name { "quiet" }
    trait :printer do
      name { "printer" }
    end
  end
end
