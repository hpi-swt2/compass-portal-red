class AddRoomsToFloor < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :floor, null: false, foreign_key: true
  end
end
