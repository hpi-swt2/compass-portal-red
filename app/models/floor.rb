class Floor < ApplicationRecord
  has_many :rooms, dependent: :nullify
  belongs_to :building, optional: true # optional, because floors should be creatable without creating a building

  def to_geojson
    # TODO
  end
end
