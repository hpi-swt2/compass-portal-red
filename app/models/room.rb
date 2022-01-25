# The model representing a room associated with the HPI
class Room < SearchableRecord
  validates :full_name, presence: true

  has_and_belongs_to_many :room_types
  has_and_belongs_to_many :chairs
  has_and_belongs_to_many :tags
  has_many :people, dependent: :nullify
  belongs_to :floor
  belongs_to :outer_shape, class_name: 'Polyline'
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :points

  after_initialize :init

  def init
    self.outer_shape ||= Polyline.new # if no outer shape exists yet, create an empty one
  end

  def to_string
    name
  end

  def to_geojson
    walls.map(&:to_geojson) +
      points.map(&:to_geojson) +
      [ outer_shape.to_geojson.merge({ properties: { class: "outer-shape" } }) ]
  end

  def self.searchable_attributes
    %w[number full_name room_types.name tags.name floors.name]
  end

  def self.searchable_relations
    [:floor, :tags, :room_types]
  end

  def self.search_by_tags(query)
    joins(searchable_relations).where("tags.name like '%#{query}%'").group(:id)
  end

  def name
    full_name || number
  end
end
