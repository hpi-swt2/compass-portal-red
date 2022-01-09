FactoryBot.define do
  factory :building do
    floors { [ (build :floor) ] }
  end
end
