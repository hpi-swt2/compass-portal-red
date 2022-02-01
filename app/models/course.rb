class Course < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :people
  has_many :course_times, dependent: :destroy
  belongs_to :room, optional: true
end
