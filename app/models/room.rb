class Room < ApplicationRecord
  validates :full_name, presence: true
  validates :room_types, presence: true

  has_and_belongs_to_many :room_types
  has_and_belongs_to_many :chairs
  has_and_belongs_to_many :tags
  has_many :people, dependent: :nullify
end
