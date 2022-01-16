class AddRoomIdToPoint < ActiveRecord::Migration[6.1]
  def change
    remove_column :point_of_interests, :room_id
    add_reference :points, :room, null: true, foreign_key: true
  end
end
