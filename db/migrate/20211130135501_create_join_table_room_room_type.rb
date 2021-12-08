class CreateJoinTableRoomRoomType < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :room_types do |t|
      # t.index [:room_id, :room_type_id]
      # t.index [:room_type_id, :room_id]
    end
  end
end
