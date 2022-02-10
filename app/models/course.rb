# The model representing a course held at HPI
class Course < SearchableRecord
  validates :name, presence: true

  has_and_belongs_to_many :people
  has_many :course_times, dependent: :destroy
  belongs_to :room, optional: true
  has_one_attached :image, dependent: :destroy

  PLACEHOLDER_IMAGE_LINK = "placeholder_course.png".freeze

  def displayed_tags
    [module_category]
  end

  def to_s
    name
  end

  def self.searchable_attributes
    %w[name module_category]
  end

  def image_or_placeholder
    image.attached? ? image : PLACEHOLDER_IMAGE_LINK
  end
end
