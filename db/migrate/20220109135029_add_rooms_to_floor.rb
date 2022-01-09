class AddRoomsToFloor < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :floor, null: true, foreign_key: true
  end
end
