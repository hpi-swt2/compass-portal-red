class Information < ApplicationRecord
  validates :value, presence: true
  validates :key, presence: true

  belongs_to :person
end
