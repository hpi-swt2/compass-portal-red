class Polyline < ApplicationRecord
  # A polyline contains an ordered list of points. For each pair of consecutive points (A, B), it should be interpreted
  # so that there is a line between A and B.
  has_and_belongs_to_many :points
  has_many :walls
  has_many :rooms

  def to_geojson(polygon=true)
    if polygon
      raise "Polygon needs same start and end point." unless points[0] == points[-1]
      {
        type: "Feature",
        geometry: {
          type: "Polygon",
          coordinates: [points.map { |point| [point.x, point.y] } ]
        }
      }
    else
      {
        type: "Feature",
        geometry: {
          type: "LineString",
          coordinates: points.map { |point| [point.x, point.y] }
        }
      }
    end
  end
end
