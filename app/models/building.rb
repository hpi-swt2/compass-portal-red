# A Building consists of an ordered list of floors (zero or more)
class Building < ApplicationRecord
  has_many :floors, dependent: :nullify

  def to_geojson
    floors.map(&:to_geojson).flatten
  end
end
