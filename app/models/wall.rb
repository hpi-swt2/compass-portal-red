class Wall < ApplicationRecord
  # A wall containing points (A, B, C) has 2 segments (a, b) and (b, c)
  # If you want to make a circle, you should add the wall as (A, B, C, A).
  belongs_to :polyline
end
