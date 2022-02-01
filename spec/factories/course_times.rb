FactoryBot.define do
  factory :course_time do
    weekday { "Friday" }
    start_time { "11:00" }
    end_time { "12:30" }
  end
end
