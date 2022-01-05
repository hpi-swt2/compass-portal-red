# The model representing a person associated with the HPI
class Person < SearchableRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :informations, dependent: :destroy, autosave: true
  has_and_belongs_to_many :chairs
  belongs_to :room, optional: true, dependent: :destroy
  belongs_to :user, optional: true, dependent: :destroy

  before_save :normalize_blank_image

  PLACEHOLDER_IMAGE_LINK = "placeholder_person.png"

  def normalize_blank_image
    self.image.present? || self.image = PLACEHOLDER_IMAGE_LINK
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

  VERIFICATION_ATTRIBUTES = [
    :human_verified_first_name,
    :human_verified_last_name,
    :human_verified_title,
    :human_verified_email,
    :human_verified_image,
    :human_verified_room_id
  ].freeze

  def self.verification_attributes
    VERIFICATION_ATTRIBUTES
  end

  def verified_attribute_to_field(verification_attr)
    return unless VERIFICATION_ATTRIBUTES.include? verification_attr

    verification_attr[15..].to_sym
  end
end
