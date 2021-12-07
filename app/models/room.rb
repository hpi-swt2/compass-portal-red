# The model representing a room associated with the HPI
class Room < ApplicationRecord
  # validates :full_name, presence: true
  # validates :room_types, presence: true

  has_and_belongs_to_many :room_types
  has_and_belongs_to_many :chairs
  has_and_belongs_to_many :tags
  has_many :people, dependent: :nullify
  belongs_to :building, optional: true # optional, because rooms should be creatable without creating a building
  belongs_to :outer_shape, class_name: 'Polyline'
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :point_of_interests

  after_initialize :init

  def init
    self.outer_shape ||= Polyline.new # if no outer shape exists yet, create an empty one
  end
end
