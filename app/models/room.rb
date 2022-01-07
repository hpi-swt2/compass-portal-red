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

  def self.searchable_attributes
    %w[floor number full_name room_types.name tags.name]
  end

  def self.searchable_relations
    joins(:tags, :room_types)
  end

  def display_name
    full_name || number
  end
end
