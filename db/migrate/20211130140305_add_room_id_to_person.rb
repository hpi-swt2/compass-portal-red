class AddRoomIdToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :room_id, :integer
    add_index :people, :room_id
  end
end
