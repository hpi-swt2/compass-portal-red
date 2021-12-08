class CreateRoomPointOfInterestJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :rooms, :point_of_interests do |t|
      # t.index [:room_id, :point_of_interest_id]
      # t.index [:point_of_interest_id, :room_id]
    end
  end
end
