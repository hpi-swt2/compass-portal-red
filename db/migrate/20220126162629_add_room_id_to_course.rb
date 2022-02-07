class AddRoomIdToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :room_id, :integer
    add_index :courses, :room_id
  end
end
