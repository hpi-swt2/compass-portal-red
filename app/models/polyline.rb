# A polyline contains an ordered list of points. For each pair of consecutive points (A, B), it should be interpreted
# so that there is a line between A and B.
class Polyline < ApplicationRecord
  has_and_belongs_to_many :points
  has_many :walls, dependent: :destroy
  has_many :rooms, dependent: :restrict_with_error if Room.pluck(:outer_shape_id).include? ids
end
