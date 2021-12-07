# A wall containing points (A, B, C) has 2 segments (a, b) and (b, c).
# If you want to make a circle, you should add the wall as (A, B, C, A).
class Wall < ApplicationRecord
  belongs_to :polyline
  after_initialize :init

  def init
    self.polyline ||= Polyline.new # if no polyline exists yet, create one
  end

  # A wall containing points (A, B, C) has 2 segments (a, b) and (b, c)
  # If you want to make a circle, you should add the wall as (A, B, C, A).
  has_and_belongs_to_many :points

  def to_geojson
    polyline.to_geojson(polygon: false).merge({ properties: { class: "wall" } })
  end
end
