# A Point of Interest (e.g. door) has exactly one Point for the position on a map
class PointOfInterest < ApplicationRecord
  belongs_to :point
  
  def to_geojson
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [point.x, point.y]
      },
      properties: {
        class: "point-of-interest",
        description: description,
        name: name
      }
    }
  end
end
