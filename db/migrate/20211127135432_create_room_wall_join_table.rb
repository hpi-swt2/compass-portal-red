class CreateRoomWallJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :walls do |t|
      # t.index [:room_id, :wall_id]
      # t.index [:wall_id, :room_id]
    end
  end
end
