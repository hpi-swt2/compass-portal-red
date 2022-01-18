class RemoveFloorFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :floor, :string
  end
end
