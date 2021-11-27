class Room < ApplicationRecord
  # There is a distinction between walls and outer shape. For example, there might be an entrance room connected to
  # a hallway without a door in-between. The outer shape would contain the border between the hallway and entrance room,
  # but there would be no wall segment in the walls array.
  has_and_belongs_to_many :outerShape, class_name: "Point"
  has_and_belongs_to_many :walls
  has_and_belongs_to_many :point_of_interests
end
