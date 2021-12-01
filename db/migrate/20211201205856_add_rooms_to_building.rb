class AddRoomsToBuilding < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :building, null: true, foreign_key: true
  end
end
