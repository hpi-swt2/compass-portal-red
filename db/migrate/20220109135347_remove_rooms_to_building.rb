class RemoveRoomsToBuilding < ActiveRecord::Migration[6.1]
  def change
    remove_reference :rooms, :building, null: true, foreign_key: true
  end
end
