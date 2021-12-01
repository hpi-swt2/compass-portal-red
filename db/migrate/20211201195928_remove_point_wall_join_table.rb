class RemovePointWallJoinTable < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :points, :walls
  end
end
