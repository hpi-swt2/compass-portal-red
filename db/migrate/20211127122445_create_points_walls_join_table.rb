class CreatePointsWallsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :points, :walls do |t|
      # t.index [:point_id, :wall_id]
      # t.index [:wall_id, :point_id]
    end
  end
end
