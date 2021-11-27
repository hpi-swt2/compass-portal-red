class Point < ApplicationRecord
  validates :x, presence: true
  validates :y, presence: true
end
