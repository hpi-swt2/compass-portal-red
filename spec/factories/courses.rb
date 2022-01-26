FactoryBot.define do
  factory :course do
    name { "Scalable Software Engineering" }
    module_category { "Pflichtmodul" }
    exam_date { "2022-03-08 09:15:00" }
    people { [(build :person)] }
    room { build :room }
    course_times { [(build :course_time, weekday: "Friday", start_time: "11:00", end_time: "12:30")] }
  end
end
