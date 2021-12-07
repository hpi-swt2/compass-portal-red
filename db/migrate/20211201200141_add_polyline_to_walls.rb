class AddPolylineToWalls < ActiveRecord::Migration[6.1]
  def change
    add_reference :walls, :polyline, null: false, foreign_key: true
  end
end
