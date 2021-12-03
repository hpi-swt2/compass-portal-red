class Polyline < ApplicationRecord
  # A polyline contains an ordered list of points. For each pair of consecutive points (A, B), it should be interpreted
  # so that there is a line between A and B.
  has_and_belongs_to_many :points
  has_many :walls, dependent: :destroy
  has_many :rooms, dependent: :nullify
end
