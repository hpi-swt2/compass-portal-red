class PointOfInterest < ApplicationRecord
  belongs_to :point

  def to_geojson
    {
      :type => "Feature",
      :geometry => {
          :type => "Point",
          :coordinates => [point.x, point.y]
      },
      :properties => {
        :class => "point-of-interest"
      }
    }
  end
end
