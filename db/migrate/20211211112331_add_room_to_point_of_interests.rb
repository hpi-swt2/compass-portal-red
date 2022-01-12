class AddRoomToPointOfInterests < ActiveRecord::Migration[6.1]
  def change
    add_reference :point_of_interests, :room, null: false, foreign_key: true
  end
end
