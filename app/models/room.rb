# The model representing a room associated with the HPI
class Room < SearchableRecord
  validates :full_name, presence: true

  has_and_belongs_to_many :room_types
  has_and_belongs_to_many :chairs
  has_and_belongs_to_many :tags
  has_many :people, dependent: :nullify
  has_many :courses, dependent: :nullify
  belongs_to :floor, optional: true
  belongs_to :outer_shape, class_name: 'Polyline'
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :points

  after_initialize :init
  before_save :normalize_blank_image

  PLACEHOLDER_IMAGE_LINK = "placeholder_room.png".freeze

  def normalize_blank_image
    image.present? || self.image = PLACEHOLDER_IMAGE_LINK
  end

  def init
    self.outer_shape ||= Polyline.new # if no outer shape exists yet, create an empty one
  end

  def to_s
    name
  end

  def related_searchable_records
    people + chairs
  end

  def to_geojson
    walls.map(&:to_geojson) +
      points.map(&:to_geojson) +
      [ outer_shape.to_geojson.merge({ properties: { class: "outer-shape" } }) ]
  end

  def to_navigation
    # get coordinates of room and calculate the center of mass return this for navigation
    geojson = to_geojson.first[:geometry]
    coordinates = geojson[:type] == 'LineString' ? geojson[:coordinates] : geojson[:coordinates].first
    coordinate = coordinates.transpose.map do |c|
      c.sum / c.size
    end
    "#{coordinate.first.to_s.tr('.', 'p')},#{coordinate.second.to_s.tr('.', 'p')}"
  end

  def self.searchable_attributes
    %w[number full_name room_types.name tags.name floors.name]
  end

  def self.searchable_relations
    [:floor, :tags, :room_types]
  end

  def displayed_tags
    tags.pluck(:name) + room_types.pluck(:name)
  end

  def self.search_by_tags(query)
    left_outer_joins(searchable_relations).where("tags.name like '%#{query}%'").group(:id)
  end

  def name
    full_name || number
  end
end
