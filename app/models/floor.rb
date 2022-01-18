# The model representing a floor associated with the HPI
class Floor < ApplicationRecord
  validates :name, presence: true

  has_many :rooms, dependent: :destroy
  belongs_to :building

  def to_geojson
    rooms.map(&:to_geojson).flatten
  end
end
