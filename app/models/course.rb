# The model representing a course held at HPI
class Course < SearchableRecord
  validates :name, presence: true

  has_and_belongs_to_many :people
  has_many :course_times, dependent: :destroy
  belongs_to :room, optional: true

  def image_or_placeholder
    "https://via.placeholder.com/512?text=Course"
  end

  def displayed_tags
    [module_category]
  end

  def to_string
    name
  end

  def self.searchable_attributes
    %w[name module_category]
  end
end
