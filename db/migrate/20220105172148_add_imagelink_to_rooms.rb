class AddImagelinkToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :image, :string
  end
end
