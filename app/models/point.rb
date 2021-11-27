class Point < ApplicationRecord
  validates :x, presence: true
  validates :y, presence: true

  has_many :point_of_interests, dependent: :destroy
end
