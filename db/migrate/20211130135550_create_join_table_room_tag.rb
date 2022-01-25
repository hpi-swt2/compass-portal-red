class CreateJoinTableRoomTag < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :tags do |t|
      # t.index [:room_id, :tag_id]
      # t.index [:tag_id, :room_id]
    end
  end
end
