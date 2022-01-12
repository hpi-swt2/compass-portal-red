# The model representing a floor associated with the HPI
class Floor < ApplicationRecord
  has_many :rooms, dependent: :nullify
  belongs_to :building

  def to_geojson
    # TODO
  end
end
