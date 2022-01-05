# Point has horizontal and vertical position (x,y) on a map
class Point < ApplicationRecord
  validates :x, presence: true
  validates :y, presence: true

  has_many :point_of_interests, dependent: :destroy
  has_and_belongs_to_many :polylines
  has_and_belongs_to_many :rooms, dependent: :destroy, required: false

  def ==(other)
    x == other.x and y == other.y
  end
end
