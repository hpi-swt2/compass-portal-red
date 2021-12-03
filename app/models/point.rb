class Point < ApplicationRecord
  validates :x, presence: true
  validates :y, presence: true

  has_many :point_of_interests, dependent: :destroy
  has_and_belongs_to_many :polylines
end