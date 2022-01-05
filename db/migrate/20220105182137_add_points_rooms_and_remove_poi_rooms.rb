class AddPointsRoomsAndRemovePoiRooms < ActiveRecord::Migration[6.1]
  def change
    drop_table :point_of_interests_rooms

    create_join_table :points, :rooms do |t|
      # t.index [:room_id, :point_of_interest_id]
      # t.index [:point_of_interest_id, :room_id]
    end
  end
end
