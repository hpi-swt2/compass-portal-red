class CourseTime < ApplicationRecord
  validates :weekday, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  belongs_to :course

  def full_time
    "#{weekday}: #{start_time} - #{end_time}"
  end
end
