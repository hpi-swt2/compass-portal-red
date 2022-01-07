class AddHumanVerifiedRoomIdToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :human_verified_room_id, :datetime
  end
end
