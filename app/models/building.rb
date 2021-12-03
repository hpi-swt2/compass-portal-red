class Building < ApplicationRecord
  has_many :rooms

  def to_geojson
    {
      :type => "FeatureCollection",
      :features => rooms.map{ |room| room.to_geojson }
    }
  end
end
