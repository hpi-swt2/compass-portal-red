# A wall containing points (A, B, C) has 2 segments (a, b) and (b, c).
# If you want to make a circle, you should add the wall as (A, B, C, A).
class Wall < ApplicationRecord
  belongs_to :polyline
  after_initialize :init

  def init
    self.polyline ||= Polyline.new # if no polyline exists yet, create one
  end
end
