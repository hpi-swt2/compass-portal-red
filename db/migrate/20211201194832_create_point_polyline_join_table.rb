class CreatePointPolylineJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :points, :polylines do |t|
      # t.index [:point_id, :polyline_id]
      # t.index [:polyline_id, :point_id]
    end
  end
end
