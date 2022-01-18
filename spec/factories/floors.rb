FactoryBot.define do
  factory :floor do
    name { "Example Floor" }
    building { build :building }
    rooms do
      []
    end
  end
end
