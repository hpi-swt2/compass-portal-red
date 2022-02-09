# The model representing a course at the HPI
class Course < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :people
  has_many :course_times, dependent: :destroy
  belongs_to :room, optional: true
  has_one_attached :image, dependent: :destroy

  PLACEHOLDER_IMAGE_LINK = "placeholder_course.png".freeze

  def image_or_placeholder
    image.attached? ? image : PLACEHOLDER_IMAGE_LINK
  end
end
