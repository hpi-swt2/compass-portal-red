# There is a distinction between walls and outer shape. For example, there might be an entrance room connected to
# a hallway without a door in-between. The outer shape would contain the border between the hallway and entrance room,
# but there would be no wall segment in the walls array.
class Room < ApplicationRecord
  belongs_to :building, optional: true # optional, because rooms should be creatable without creating a building
  belongs_to :outer_shape, class_name: 'Polyline'
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :point_of_interests

  after_initialize :init

  def init
    self.outer_shape ||= Polyline.new # if no outer shape exists yet, create an empty one
  end

  def to_geojson
    walls.map(&:to_geojson) +
      point_of_interests.map(&:to_geojson) +
      [ outer_shape.to_geojson.merge({ properties: { class: "outer-shape" } }) ]
  end
end
