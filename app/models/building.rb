class Building < ApplicationRecord
  has_many :rooms

  def to_geojson
    rooms.map(&:to_geojson).flatten
  end
end
