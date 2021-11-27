class Wall < ApplicationRecord
  has_and_belongs_to_many :points
end
