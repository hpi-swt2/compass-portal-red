class CourseTime < ApplicationRecord
  validates :weekday, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :course
end
