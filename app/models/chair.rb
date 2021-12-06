class Chair < ApplicationRecord
  validates :name, presence: true
  validates :people, presence: true

  has_and_belongs_to_many :people
  has_and_belongs_to_many :rooms
end
