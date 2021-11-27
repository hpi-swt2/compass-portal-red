class CreateRoomPointJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :points do |t|
      # t.index [:room_id, :point_id]
      # t.index [:point_id, :room_id]
    end
  end
end
