# The model representing a person associated with the HPI
class Person < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :informations, dependent: :destroy, autosave: true
  has_and_belongs_to_many :chairs
  belongs_to :room, optional: true, dependent: :destroy
  belongs_to :user, optional: true, dependent: :destroy

  def name
    "#{first_name} #{last_name}"
  end

  def full_name
    "#{title} #{name}"
  end

  # This map contains the key to the verification for every attribute
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
end
