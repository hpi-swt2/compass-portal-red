# A Building consists of an ordered list of rooms (zero or more)
class Building < ApplicationRecord
  has_many :rooms, dependent: :nullify
  has_many :point_of_interests, dependent: :destroy

  def to_geojson
    rooms.map(&:to_geojson).flatten
  end
end
