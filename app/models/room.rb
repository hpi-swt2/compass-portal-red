require "polylabel"

# The model representing a room associated with the HPI
class Room < SearchableRecord
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

  def to_string
    display_name
  end

  def to_geojson
    walls.map(&:to_geojson) +
      point_of_interests.map(&:to_geojson) +
      [ outer_shape.to_geojson.merge({ properties: { class: "outer-shape" } }) ]
  end

  # Returns a good coordinate for labels, the "visual center" of a polygon
  def visual_center_coordinates
    outer = outer_shape.to_geojson.merge({ properties: { class: "outer-shape" } })
    # Polylabel returns a hash with x, y and distance. Distance describes how much room there is for a label
    label_coordinates = Polylabel.compute(outer[:geometry][:coordinates])
    [label_coordinates[:y], label_coordinates[:x]]
  end

  def self.searchable_attributes
    %w[floor number full_name]
  end

  def display_name
    full_name || number
  end
end
