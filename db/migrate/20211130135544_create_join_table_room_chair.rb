class CreateJoinTableRoomChair < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :chairs do |t|
      # t.index [:room_id, :chair_id]
      # t.index [:chair_id, :room_id]
    end
  end
end
