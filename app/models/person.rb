# The model representing a person associated with the HPI
class Person < SearchableRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :informations, dependent: :destroy, autosave: true
  has_and_belongs_to_many :chairs
  has_and_belongs_to_many :courses
  belongs_to :room, optional: true, dependent: :destroy
  belongs_to :user, optional: true, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  PLACEHOLDER_IMAGE_LINK = "placeholder_person.png".freeze

  def image_or_placeholder
    image.attached? ? image : PLACEHOLDER_IMAGE_LINK
  end

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{title} #{name}"
  end

  def to_string
    full_name
  end

  def self.searchable_attributes
    %w[title first_name last_name]
  end

  def displayed_tags
    informations.pluck(:value)
  end

  VERIFICATION_ATTRIBUTES = [
    :human_verified_first_name,
    :human_verified_last_name,
    :human_verified_title,
    :human_verified_email,
    :human_verified_image,
    :human_verified_room_id,
    :human_verified_status
  ].freeze

  def self.verification_attributes
    VERIFICATION_ATTRIBUTES
  end

  def self.verified_attribute_to_field(verification_attr)
    return unless VERIFICATION_ATTRIBUTES.include? verification_attr

    verification_attr[15..].to_sym
  end
end
