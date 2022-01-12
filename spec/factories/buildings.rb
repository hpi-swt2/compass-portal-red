FactoryBot.define do
  factory :building do
    rooms do
      [(build :room)]
    end
  end
end
